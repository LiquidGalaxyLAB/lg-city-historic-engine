async function overpass(query) {
  const res = await fetch('https://overpass.kumi.systems/api/interpreter', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'User-Agent': 'lg-city-historic-engine/1.0',
    },
    body: 'data=' + encodeURIComponent(query),
  });
  const text = await res.text();
  try {
    return JSON.parse(text);
  } catch {
    console.error(text.slice(0, 200));
    throw new Error('Overpass failed');
  }
}

function simplify(ring, max = 28) {
  if (ring.length <= max) return ring;
  const step = Math.ceil(ring.length / max);
  const out = [];
  for (let i = 0; i < ring.length; i += step) out.push(ring[i]);
  const first = out[0];
  const last = out[out.length - 1];
  if (first[0] !== last[0] || first[1] !== last[1]) out.push(first);
  return out;
}

function distMeters(lng1, lat1, lng2, lat2) {
  const dLat = (lat2 - lat1) * 111320;
  const dLng = (lng2 - lng1) * 111320 * Math.cos((lat1 * Math.PI) / 180);
  return Math.sqrt(dLat * dLat + dLng * dLng);
}

const lat = 41.613794;
const lng = 0.620883;
const q =
  `[out:json][timeout:60];(` +
  `way["building"](around:120,${lat},${lng});` +
  `relation["building"](around:120,${lat},${lng});` +
  `);out geom;`;

const data = await overpass(q);
let best = null;
let bestD = 1e9;

for (const el of data.elements || []) {
  let pts = [];
  if (el.type === 'way' && el.geometry) {
    pts = el.geometry.map((g) => [g.lon, g.lat]);
  }
  if (el.type === 'relation') {
    const outer = (el.members || []).find((m) => m.role === 'outer' && m.geometry);
    if (outer) pts = outer.geometry.map((g) => [g.lon, g.lat]);
  }
  if (pts.length < 3) continue;
  const cl = pts.reduce((s, p) => s + p[0], 0) / pts.length;
  const ca = pts.reduce((s, p) => s + p[1], 0) / pts.length;
  const d = distMeters(lng, lat, cl, ca);
  const tag = JSON.stringify(el.tags || {});
  if (d < bestD) bestD = d, best = { pts, d, tag };
}

console.log('best', Math.round(bestD), 'm', best.tag);
const ring = simplify(best.pts);
for (const p of ring) {
  console.log(`      [${p[0].toFixed(7)}, ${p[1].toFixed(7)}],`);
}
