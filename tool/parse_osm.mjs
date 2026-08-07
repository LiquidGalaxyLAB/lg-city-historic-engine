async function fetchXml(url) {
  const r = await fetch(url, { headers: { 'User-Agent': 'lg-city-historic-engine/1.0' } });
  return r.text();
}

function parseOsmXml(xml) {
  const nodes = {};
  for (const m of xml.matchAll(/<node id="(\d+)"[^>]*lat="([^"]+)" lon="([^"]+)"/g)) {
    nodes[m[1]] = { lat: parseFloat(m[2]), lon: parseFloat(m[3]) };
  }
  const ways = [];
  for (const wm of xml.matchAll(/<way id="(\d+)"[\s\S]*?<\/way>/g)) {
    const block = wm[0];
    const id = wm[1];
    const refs = [...block.matchAll(/<nd ref="(\d+)"/g)].map((x) => x[1]);
    const tags = {};
    for (const tm of block.matchAll(/<tag k="([^"]+)" v="([^"]*)"/g)) tags[tm[1]] = tm[2];
    const ring = refs.map((ref) => {
      const n = nodes[ref];
      return [n.lon, n.lat];
    });
    ways.push({ id, ring, tags });
  }
  return ways;
}

function simplify(ring, max = 32) {
  if (ring.length <= max) return ring;
  const step = Math.ceil(ring.length / max);
  const out = [];
  for (let i = 0; i < ring.length; i += step) out.push(ring[i]);
  const first = out[0];
  const last = out[out.length - 1];
  if (first[0] !== last[0] || first[1] !== last[1]) out.push(first);
  return out;
}

function printRing(name, ring) {
  console.log(`\n=== ${name} (${ring.length} pts) ===`);
  for (const p of ring) {
    console.log(`      [${p[0].toFixed(7)}, ${p[1].toFixed(7)}],`);
  }
}

function centroid(ring) {
  const cl = ring.reduce((s, p) => s + p[0], 0) / ring.length;
  const ca = ring.reduce((s, p) => s + p[1], 0) / ring.length;
  return { lng: cl, lat: ca };
}

function distMeters(lng1, lat1, lng2, lat2) {
  const dLat = (lat2 - lat1) * 111320;
  const dLng = (lng2 - lng1) * 111320 * Math.cos((lat1 * Math.PI) / 180);
  return Math.sqrt(dLat * dLat + dLng * dLng);
}

const seuXml = await fetchXml('https://www.openstreetmap.org/api/0.6/way/48495190/full');
const seuWays = parseOsmXml(seuXml);
if (seuWays[0]) {
  const ring = simplify(seuWays[0].ring);
  const c = centroid(ring);
  console.log('Seu Vella way 48495190 tags:', seuWays[0].tags);
  console.log('Centroid:', c.lat, c.lng, 'dist from POI', Math.round(distMeters(0.6269, 41.617475, c.lng, c.lat)), 'm');
  printRing('Seu Vella', ring);
}

const relXml = await fetchXml('https://www.openstreetmap.org/api/0.6/relation/4008211/full');
const outerMatch = [...relXml.matchAll(/<member type="way" ref="(\d+)" role="outer"/g)];
console.log('\nRelation 4008211 outer ways:', outerMatch.map((m) => m[1]).join(', '));
const relWays = parseOsmXml(relXml);
for (const w of relWays) {
  if (outerMatch.some((m) => m[1] === w.id)) {
    const ring = simplify(w.ring);
    const c = centroid(ring);
    console.log('Outer way', w.id, w.tags, Math.round(distMeters(0.6269, 41.617475, c.lng, c.lat)), 'm');
    printRing(`Seu outer ${w.id}`, ring);
  }
}

const tanLat = 41.617327;
const tanLng = 0.6295042;
const overpassUrls = [
  'https://lz4.overpass-api.de/api/interpreter',
  'https://maps.mail.ru/osm/tools/overpass/api/interpreter',
];
const tanQuery =
  `[out:json][timeout:60];(` +
  `way["building"](around:100,${tanLat},${tanLng});` +
  `way["historic"](around:100,${tanLat},${tanLng});` +
  `);out geom;`;

for (const url of overpassUrls) {
  try {
    const res = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'User-Agent': 'lg-city-historic-engine/1.0',
      },
      body: 'data=' + encodeURIComponent(tanQuery),
    });
    const text = await res.text();
    const data = JSON.parse(text);
    console.log('\nOverpass', url, 'elements', data.elements?.length);
    for (const el of data.elements || []) {
      if (!el.geometry) continue;
      const pts = el.geometry.map((g) => [g.lon, g.lat]);
      const c = centroid(pts);
      console.log(' ', el.id, el.tags, Math.round(distMeters(tanLng, tanLat, c.lng, c.lat)), 'm');
      printRing(`way ${el.id}`, simplify(pts));
    }
    break;
  } catch (e) {
    console.log('Overpass fail', url, String(e).slice(0, 120));
  }
}
