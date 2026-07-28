#!/usr/bin/env node
/** Fetch OSM footprint polygons for Lleida POIs and emit Dart catalog. */
import { writeFileSync, readFileSync, existsSync } from 'fs';

const USER_AGENT = 'lg-city-historic-engine/1.0 (outline-fetch)';
const NOMINATIM = 'https://nominatim.openstreetmap.org/search';
const OVERPASS = 'https://overpass-api.de/api/interpreter';

const POIS = [
  ['Science Park', 41.605135, 0.60707, ['Parc Agrobiotech Lleida']],
  ['Sícoris Club', 41.606622, 0.640498, ['Sícoris Club Lleida', 'Club Sicoris Lleida']],
  ["Camp d'Esports", 41.620982, 0.61426, ["Camp d'Esports Lleida", "Estadi Camp d'Esports"]],
  ['Castell Templer de Gardeny', 41.608256, 0.614865, ['Castell de Gardeny', 'Castillo de Gardeny Lleida']],
  ['Statue of Indíbil and Mandoni', 41.615162, 0.627375, ['Monument Indíbil Mandoni Lleida', 'Plaça Agelet i Garriga Lleida']],
  ['Old Hospital of Santa Maria', 41.612755, 0.623605, ['Antic Hospital de Santa Maria Lleida']],
  ['La Paeria', 41.614591, 0.626919, ['Paeria Lleida', 'Ajuntament de Lleida']],
  ["Governor's Fountain", 41.617293, 0.628825, ['Font del Governador Lleida']],
  ['Hospital Fountain', 41.612659, 0.623962, ["Font de l'Hospital Lleida"]],
  ['La Mitjana (natural heritage)', 41.626418, 0.648638, ['Parc de la Mitjana Lleida', 'Espai Natural La Mitjana']],
  ["General's Pillar", 41.615394, 0.627119, ['Pilar del General Lleida']],
  ['La Suda of Lleida', 41.61866, 0.625649, ['Castell de la Suda Lleida', 'Suda Lleida']],
  ['Seu Vella', 41.617475, 0.6269, ['Seu Vella Lleida', 'Catedral de Lleida']],
  ['Sant Joan Square', 41.616028, 0.627358, ['Plaça de Sant Joan Lleida']],
  ['Sant Anastasi Mill', 41.605572, 0.640122, ['Molí de Sant Anastasi Lleida']],
  ['La Cuirassa', 41.614267, 0.625061, ['Call Jueu Lleida', 'Cuirassa Lleida']],
  ['Tanneries', 41.617285, 0.62964, ['Carrer de les Adoberies Lleida', 'Adoberies Lleida']],
  ['La Llotja', 41.619525, 0.63789, ['La Llotja Lleida', 'Auditori Enric Granados Lleida']],
  ['Europa Square', 41.625288, 0.62266, ['Plaça Europa Lleida']],
  ['Lleida Courthouse', 41.616915, 0.626921, ['Palau de Justícia Lleida']],
  ['Lleida–Pirineus Train Station', 41.620629, 0.632886, ['Estació de Lleida-Pirineus']],
  ['Camps Elisis Park', 41.613817, 0.632234, ['Camps Elisis Lleida', 'Parc dels Camps Elisis']],
  ['Museum of Modern and Contemporary Art of Lleida', 41.617625, 0.629728, ['Museu Morera Lleida', "Museu d'Art Jaume Morera"]],
  ['Diocesan Museum', 41.613794, 0.620883, ['Museu de Lleida', 'Museu Diocesà Lleida']],
  ['Water Museum', 41.603211, 0.635728, ["Museu de l'Aigua Lleida", 'Camp de la Canadenca Lleida']],
  ['Automotive Museum', 41.613319, 0.632769, ["Museu de l'Automoció Lleida"]],
  ['Seu Vella Cathedral', 41.617475, 0.6269, ['Seu Vella Lleida']],
  ['New Cathedral', 41.6129, 0.623125, ['Catedral Nova Lleida', 'Nova Seu Lleida']],
  ['Church of Sant Llorenç', 41.61425, 0.621639, ['Església de Sant Llorenç Lleida']],
  ['Old Church of San Martí', 41.617669, 0.622039, ['Església de Sant Martí Lleida']],
  ['Church of San Juan', 41.616403, 0.627722, ['Església de Sant Joan Lleida']],
  ['Chapel of Sant Jaume', 41.613458, 0.6246, ['Capella de Sant Jaume Lleida']],
  ['Chapel of la Sang', 41.611911, 0.621158, ['Oratori de la Sang Lleida']],
  ['Church of Sant Pere', 41.614269, 0.626103, ['Església de Sant Pere Lleida']],
  ['Hermitage of Granyena', 41.641917, 0.662147, ['Ermita de Granyena Alcoletge', 'Ermita de la Mare de Déu de Granyena']],
  ['Convent del Roser', 41.614419, 0.623989, ['Convent del Roser Lleida']],
  ['Academia Mariana', 41.610928, 0.619022, ['Acadèmia Mariana Lleida', 'Santuari de la Mare de Déu del Castell']],
  ['Revolt of Indibilis and Mandonius', 41.619123, 0.6232056, ['Seu Vella Lleida', 'Centre històric Lleida']],
  ['Battle of Ilerda, 49 BC', 41.619123, 0.6232056, ['Seu Vella Lleida', "Pla d'Almatà Lleida"]],
  ['Muslim Invasion', 41.6180451, 0.6258326, ['Castell de la Suda Lleida', 'Seu Vella Lleida']],
  ['Siege of Lleida (800)', 41.619123, 0.6232056, ['Seu Vella Lleida']],
  ['Siege of Lleida (884)', 41.619123, 0.6232056, ['Seu Vella Lleida']],
  ['Christian Reconquest, 1149', 41.6089691, 0.6103237, ['Castell de Gardeny', 'Castillo de Gardeny Lleida']],
  ['Union of the Kingdom of Aragon and the County of Barcelona', 41.616791, 0.6254991, ['Seu Vella Lleida', 'Plaça de la Catedral Lleida']],
  ['Oath of Allegiance to James I', 41.6180451, 0.6258326, ['Castell de la Suda Lleida']],
  ['First University of the Kingdom of Aragon', 41.6146803, 0.619876, ['Estudi General Lleida', 'Universitat de Lleida històric']],
  ['Siege of Lleida (1413)', 41.619123, 0.6232056, ['Seu Vella Lleida']],
  ['The Battle of Lleida (1642)', 41.6100091, 0.6367412, ['Camps Elisis Lleida']],
  ['Siege of Lleida (1644)', 41.6149206, 0.6204228, ['Seu Vella Lleida', 'Catedral de Lleida']],
  ['Siege of Lleida (1646)', 41.619123, 0.6232056, ['Seu Vella Lleida']],
  ['Siege of Lleida (1647)', 41.619123, 0.6232056, ['Seu Vella Lleida']],
  ['Siege of Lleida (1707)', 41.619123, 0.6232056, ['Seu Vella Lleida']],
  ['Siege of Lleida (1810)', 41.619123, 0.6232056, ['Seu Vella Lleida']],
  ['Battle of Lleida (1938)', 41.619123, 0.6232056, ['Seu Vella Lleida', 'Centre històric Lleida']],
];

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function httpGet(url, { method = 'GET', body, retries = 3 } = {}) {
  for (let attempt = 0; attempt < retries; attempt++) {
    try {
      const res = await fetch(url, {
        method,
        headers: {
          'User-Agent': USER_AGENT,
          ...(body ? { 'Content-Type': 'application/x-www-form-urlencoded' } : {}),
        },
        body,
      });
      if (res.ok) return res.text();
      if (attempt < retries - 1 && (res.status >= 500 || res.status === 429)) {
        await sleep(2000 * (attempt + 1));
        continue;
      }
      throw new Error(`${url} -> ${res.status}`);
    } catch (err) {
      if (attempt < retries - 1) {
        await sleep(2000 * (attempt + 1));
        continue;
      }
      throw err;
    }
  }
  throw new Error(`${url} failed after retries`);
}

function distM(lat1, lng1, lat2, lng2) {
  const r = 6378137;
  const dlat = ((lat2 - lat1) * Math.PI) / 180;
  const dlng = ((lng2 - lng1) * Math.PI) / 180;
  const a =
    Math.sin(dlat / 2) ** 2 +
    Math.cos((lat1 * Math.PI) / 180) * Math.cos((lat2 * Math.PI) / 180) * Math.sin(dlng / 2) ** 2;
  return 2 * r * Math.asin(Math.sqrt(a));
}

function ringFromGeojson(geo) {
  const { type, coordinates } = geo;
  if (type === 'Polygon') return coordinates[0].map(([lng, lat]) => [lng, lat]);
  if (type === 'MultiPolygon') {
    const largest = coordinates.reduce((a, b) => (a[0].length >= b[0].length ? a : b));
    return largest[0].map(([lng, lat]) => [lng, lat]);
  }
  return null;
}

function pointInRing(lng, lat, ring) {
  let inside = false;
  for (let i = 0, n = ring.length; i < n; i++) {
    const [x1, y1] = ring[i];
    const [x2, y2] = ring[(i + 1) % n];
    if (y1 > lat !== y2 > lat && lng < ((x2 - x1) * (lat - y1)) / (y2 - y1 + 1e-12) + x1) inside = !inside;
  }
  return inside;
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
  const raw = await httpGet(`${NOMINATIM}?${params}`);
  const results = JSON.parse(raw);
  let best = null;
  let bestScore = Infinity;
  for (const item of results) {
    const geo = item.geojson;
    if (!geo) continue;
    const ring = ringFromGeojson(geo);
    if (!ring || ring.length < 4) continue;
    const ilat = parseFloat(item.lat);
    const ilng = parseFloat(item.lon);
    const d = distM(lat, lng, ilat, ilng);
    const score = pointInRing(lng, lat, ring) ? d : d + 500;
    if (score < bestScore) {
      bestScore = score;
      best = ring;
    }
  }
  return best;
}

const OVERPASS_SERVERS = [
  'https://overpass.kumi.systems/api/interpreter',
  'https://overpass-api.de/api/interpreter',
];

const PROGRESS_FILE = new URL('./outlines_progress.json', import.meta.url);

async function overpassBuilding(lat, lng, radius = 90) {
  const q = `
    [out:json][timeout:15];
    (
      way(around:${radius},${lat},${lng})["building"];
      relation(around:${radius},${lat},${lng})["building"];
    );
    out geom;
  `;
  const body = `data=${encodeURIComponent(q)}`;
  let data = null;
  for (const server of OVERPASS_SERVERS) {
    try {
      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), 20000);
      const res = await fetch(server, {
        method: 'POST',
        headers: { 'User-Agent': USER_AGENT, 'Content-Type': 'application/x-www-form-urlencoded' },
        body,
        signal: controller.signal,
      });
      clearTimeout(timer);
      if (!res.ok) continue;
      data = JSON.parse(await res.text());
      break;
    } catch {
      await sleep(800);
    }
  }
  if (!data) return null;
  let best = null;
  let bestArea = 0;
  for (const el of data.elements || []) {
    let ring = null;
    if (el.type === 'way' && el.geometry) ring = el.geometry.map((p) => [p.lon, p.lat]);
    else if (el.type === 'relation' && el.members) {
      const outer = el.members.find((m) => m.role === 'outer' && m.geometry);
      if (outer) ring = outer.geometry.map((p) => [p.lon, p.lat]);
    }
    if (!ring || ring.length < 4) continue;
    if (!pointInRing(lng, lat, ring)) {
      const cx = ring.reduce((s, p) => s + p[0], 0) / ring.length;
      const cy = ring.reduce((s, p) => s + p[1], 0) / ring.length;
      if (distM(lat, lng, cy, cx) > 60) continue;
    }
    const xs = ring.map((p) => p[0]);
    const ys = ring.map((p) => p[1]);
    const area = (Math.max(...xs) - Math.min(...xs)) * (Math.max(...ys) - Math.min(...ys));
    if (area > bestArea) {
      bestArea = area;
      best = ring;
    }
  }
  return best;
}

function orientedRect(lat, lng, rangeM = 120, heading = 0) {
  let halfL = Math.max(25, Math.min(rangeM * 0.38, 140));
  const halfW = halfL * 0.72;
  const headingRad = ((heading || 0) - 90) * (Math.PI / 180);
  const corners = [
    [halfL, -halfW],
    [halfL, halfW],
    [-halfL, halfW],
    [-halfL, -halfW],
  ];
  const ring = corners.map(([north, east]) => {
    const rn = north * Math.cos(headingRad) - east * Math.sin(headingRad);
    const re = north * Math.sin(headingRad) + east * Math.cos(headingRad);
    const dlat = (rn / 6378137) * (180 / Math.PI);
    const dlng = (re / (6378137 * Math.cos((lat * Math.PI) / 180))) * (180 / Math.PI);
    return [lng + dlng, lat + dlat];
  });
  ring.push(ring[0]);
  return ring;
}

async function fetchRing(name, lat, lng, queries) {
  for (const q of queries) {
    try {
      const ring = await nominatimPolygon(q, lat, lng);
      if (ring) return [ring, `nominatim:${q}`];
    } catch (err) {
      process.stderr.write(`  nominatim failed for ${q}: ${err.message}\n`);
    }
    await sleep(1100);
  }
  try {
    const ring = await overpassBuilding(lat, lng);
    if (ring) return [ring, 'overpass:building'];
  } catch (err) {
    process.stderr.write(`  overpass failed: ${err.message}\n`);
  }
  return [orientedRect(lat, lng), 'fallback:rect'];
}

function saveProgress(entries, meta) {
  writeFileSync(PROGRESS_FILE, JSON.stringify({ entries, meta }, null, 2), 'utf8');
}

function loadProgress() {
  if (!existsSync(PROGRESS_FILE)) return [{}, {}];
  const parsed = JSON.parse(readFileSync(PROGRESS_FILE, 'utf8'));
  return [parsed.entries || {}, parsed.meta || {}];
}

async function main() {
  const [entries, meta] = loadProgress();
  for (const [name, lat, lng, queries] of POIS) {
    if (entries[name]) {
      process.stderr.write(`Skipping ${name} (cached)\n`);
      continue;
    }
    process.stderr.write(`Fetching ${name}...\n`);
    try {
      const [ring, source] = await fetchRing(name, lat, lng, queries);
      let simplified = simplifyRing(ring);
      if (simplified[0][0] !== simplified.at(-1)[0] || simplified[0][1] !== simplified.at(-1)[1]) {
        simplified = [...simplified, simplified[0]];
      }
      entries[name] = simplified;
      meta[name] = source;
      saveProgress(entries, meta);
    } catch (err) {
      process.stderr.write(`  ERROR ${name}: ${err.message}\n`);
      entries[name] = orientedRect(lat, lng);
      meta[name] = 'fallback:error';
      saveProgress(entries, meta);
    }
    await sleep(1100);
  }

  const lines = [];
  lines.push('// Sources: ' + JSON.stringify(meta, null, 2));
  lines.push('');
  lines.push('static const Map<String, List<List<double>>> _byCanonicalName = {');
  for (const [name, ring] of Object.entries(entries)) {
    const safe = name.replace(/'/g, "\\'");
    lines.push(`    '${safe}': [`);
    for (const [lng, lat] of ring) lines.push(`      [${lng.toFixed(7)}, ${lat.toFixed(7)}],`);
    lines.push('    ],');
  }
  lines.push('};');
  const out = lines.join('\n');
  writeFileSync(new URL('./outlines_generated.txt', import.meta.url), out, 'utf8');
  console.log(out);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
