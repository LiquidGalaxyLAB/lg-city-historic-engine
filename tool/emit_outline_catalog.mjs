#!/usr/bin/env node
/** Refetch fallback POIs and emit poi_outline_catalog.dart */
import { readFileSync, writeFileSync } from 'fs';

const PROGRESS = JSON.parse(
  readFileSync(new URL('./outlines_progress.json', import.meta.url), 'utf8'),
);
const { entries, meta } = PROGRESS;

const REFETCH = [
  ['Hospital Fountain', 41.612659, 0.623962, ['Font de l\'Hospital Lleida', 'Plaça del Mercadal Lleida']],
  ['La Mitjana (natural heritage)', 41.626418, 0.648638, ['Espai Natural de la Mitjana', 'Parc de la Mitjana Lleida']],
  ['Camps Elisis Park', 41.613817, 0.632234, ['Parc dels Camps Elisis Lleida', 'Camps Elisis Lleida']],
  ['Automotive Museum', 41.613319, 0.632769, ['Museu de l\'Automoció Roda Roda Lleida', 'Museu Roda Roda Lleida']],
  ['Chapel of la Sang', 41.611911, 0.621158, ['Oratori de la Sang Lleida', 'Capella de la Sang Lleida']],
  ['First University of the Kingdom of Aragon', 41.6146803, 0.619876, ['Estudi General de Lleida', 'Institut d\'Estudis Ilerdencs Lleida']],
  ['Seu Vella', 41.617475, 0.6269, ['Castell de la Suda Lleida', 'Fortalesa de la Seu Vella Lleida']],
  ['Seu Vella Cathedral', 41.617475, 0.6269, ['Castell de la Suda Lleida', 'Fortalesa de la Seu Vella Lleida']],
];

const SEU_VELLA_EVENTS = [
  'Revolt of Indibilis and Mandonius',
  'Battle of Ilerda, 49 BC',
  'Siege of Lleida (800)',
  'Siege of Lleida (884)',
  'Union of the Kingdom of Aragon and the County of Barcelona',
  'Siege of Lleida (1413)',
  'Siege of Lleida (1644)',
  'Siege of Lleida (1646)',
  'Siege of Lleida (1647)',
  'Siege of Lleida (1707)',
  'Siege of Lleida (1810)',
  'Battle of Lleida (1938)',
];

const USER_AGENT = 'lg-city-historic-engine/1.0 (outline-fetch)';
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

function ringFromGeojson(geo) {
  const { type, coordinates } = geo;
  if (type === 'Polygon') return coordinates[0].map(([lng, lat]) => [lng, lat]);
  if (type === 'MultiPolygon') {
    const largest = coordinates.reduce((a, b) => (a[0].length >= b[0].length ? a : b));
    return largest[0].map(([lng, lat]) => [lng, lat]);
  }
  return null;
}

function simplifyRing(ring, maxPoints = 24) {
  if (ring.length <= maxPoints) return ring;
  const step = Math.max(1, Math.floor(ring.length / maxPoints));
  const simplified = ring.filter((_, i) => i % step === 0);
  if (simplified[0][0] !== simplified.at(-1)[0] || simplified[0][1] !== simplified.at(-1)[1]) {
    simplified.push(simplified[0]);
  }
  return simplified;
}

async function nominatimPolygon(query, lat, lng) {
  const params = new URLSearchParams({
    q: `${query}, Lleida, Spain`,
    format: 'json',
    polygon_geojson: '1',
    limit: '5',
  });
  const res = await fetch(`https://nominatim.openstreetmap.org/search?${params}`, {
    headers: { 'User-Agent': USER_AGENT },
  });
  const results = await res.json();
  let best = null;
  let bestLen = 0;
  for (const item of results) {
    const ring = item.geojson ? ringFromGeojson(item.geojson) : null;
    if (ring && ring.length > bestLen) {
      bestLen = ring.length;
      best = ring;
    }
  }
  return best;
}

async function main() {
  for (const [name, lat, lng, queries] of REFETCH) {
    for (const q of queries) {
      process.stderr.write(`Refetch ${name} via ${q}\n`);
      const ring = await nominatimPolygon(q, lat, lng);
      await sleep(1100);
      if (ring && ring.length >= 4) {
        let simplified = simplifyRing(ring);
        if (simplified[0][0] !== simplified.at(-1)[0] || simplified[0][1] !== simplified.at(-1)[1]) {
          simplified = [...simplified, simplified[0]];
        }
        entries[name] = simplified;
        meta[name] = `nominatim-refetch:${q}`;
        break;
      }
    }
  }

  const citadel =
    entries['Seu Vella']?.length > 10
      ? entries['Seu Vella']
      : entries['La Suda of Lleida'] || entries['Seu Vella'];
  if (citadel) {
    for (const name of ['Seu Vella', 'Seu Vella Cathedral', ...SEU_VELLA_EVENTS]) {
      if (entries[name]) {
        entries[name] = citadel.map((p) => [...p]);
        meta[name] = 'alias:citadel';
      }
    }
  }

  writeFileSync(
    new URL('./outlines_progress.json', import.meta.url),
    JSON.stringify({ entries, meta }, null, 2),
    'utf8',
  );

  const lines = [
    "import '../models/poi_model.dart';",
    "import '../data/poi_name_catalog.dart';",
    '',
    '/// Per-site ground outlines (lng, lat vertices) that wrap the real footprint.',
    'class PoiOutlineCatalog {',
    '  PoiOutlineCatalog._();',
    '',
    '  static const Map<String, List<List<double>>> _byCanonicalName = {',
  ];

  for (const [name, ring] of Object.entries(entries)) {
    const safe = name.replace(/'/g, "\\'");
    lines.push(`    '${safe}': [`);
    for (const [lng, lat] of ring) {
      lines.push(`      [${lng.toFixed(7)}, ${lat.toFixed(7)}],`);
    }
    lines.push('    ],');
  }

  lines.push(
    '  };',
    '',
    '  /// Returns a closed polygon for [poi], or null to use the generic outline.',
    '  static List<({double lat, double lng})>? polygonFor(POI poi) {',
    '    final names = <String>{poi.name};',
    '    if (poi.names != null) {',
    '      names.addAll(poi.names!.values);',
    '    }',
    '',
    '    for (final name in names) {',
    '      final canonical = canonicalEnglishNameFor(name) ?? name;',
    '      final ring = _byCanonicalName[canonical];',
    '      if (ring != null) {',
    '        return ring',
    '            .map((p) => (lat: p[1], lng: p[0]))',
    '            .toList(growable: false);',
    '      }',
    '    }',
    '    return null;',
    '  }',
    '}',
    '',
  );

  const outPath = new URL('../lib/data/poi_outline_catalog.dart', import.meta.url);
  writeFileSync(outPath, lines.join('\n'), 'utf8');
  console.log(`Wrote ${outPath.pathname}`);
  console.log('Sources:', JSON.stringify(meta, null, 2));
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
