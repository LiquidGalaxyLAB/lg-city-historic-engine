import { readFileSync, writeFileSync } from 'fs';

const path = new URL('./outlines_progress.json', import.meta.url);
const data = JSON.parse(readFileSync(path, 'utf8'));

const POIS = [
  ['La Mitjana (natural heritage)', 41.626418, 0.648638, 250, 'leisure'],
  ['Camps Elisis Park', 41.613817, 0.632234, 180, 'leisure'],
  ['Automotive Museum', 41.613319, 0.632769, 120, 'building'],
  ['First University of the Kingdom of Aragon', 41.6146803, 0.619876, 100, 'building'],
];

function simplify(ring, max = 28) {
  if (ring.length <= max) return ring;
  const step = Math.max(1, Math.floor(ring.length / max));
  const s = ring.filter((_, i) => i % step === 0);
  if (s[0][0] !== s.at(-1)[0] || s[0][1] !== s.at(-1)[1]) s.push(s[0]);
  return s;
}

async function overpass(lat, lng, radius, tag) {
  const q = `[out:json][timeout:20];(way(around:${radius},${lat},${lng})["${tag}"];relation(around:${radius},${lat},${lng})["${tag}"];);out geom;`;
  for (const server of [
    'https://overpass.kumi.systems/api/interpreter',
    'https://overpass-api.de/api/interpreter',
  ]) {
    try {
      const res = await fetch(server, {
        method: 'POST',
        headers: {
          'User-Agent': 'lg-city-historic-engine/1.0',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `data=${encodeURIComponent(q)}`,
        signal: AbortSignal.timeout(25000),
      });
      if (!res.ok) continue;
      const json = await res.json();
      let best = null;
      let bestA = 0;
      for (const el of json.elements || []) {
        let ring = null;
        if (el.type === 'way' && el.geometry) ring = el.geometry.map((p) => [p.lon, p.lat]);
        else if (el.type === 'relation' && el.members) {
          const o = el.members.find((m) => m.role === 'outer' && m.geometry);
          if (o) ring = o.geometry.map((p) => [p.lon, p.lat]);
        }
        if (!ring || ring.length < 4) continue;
        const xs = ring.map((p) => p[0]);
        const ys = ring.map((p) => p[1]);
        const area = (Math.max(...xs) - Math.min(...xs)) * (Math.max(...ys) - Math.min(...ys));
        if (area > bestA) {
          bestA = area;
          best = ring;
        }
      }
      if (best) return simplify(best);
    } catch {
      /* try next server */
    }
  }
  return null;
}

for (const [name, lat, lng, radius, tag] of POIS) {
  process.stderr.write(`overpass ${name}\n`);
  const ring = await overpass(lat, lng, radius, tag);
  if (ring) {
    data.entries[name] = ring;
    data.meta[name] = `overpass-refetch:${tag}`;
    process.stderr.write(`  OK ${ring.length} pts\n`);
  } else {
    process.stderr.write(`  FAIL\n`);
  }
  await new Promise((r) => setTimeout(r, 1500));
}

writeFileSync(path, JSON.stringify(data, null, 2));
