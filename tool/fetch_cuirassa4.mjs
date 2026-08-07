async function fetchWay(id) {
  const xml = await fetch(`https://www.openstreetmap.org/api/0.6/way/${id}/full`, {
    headers: { 'User-Agent': 'lg-city-historic-engine/1.0' },
  }).then((r) => r.text());

  const nodes = {};
  for (const m of xml.matchAll(/<node id="(\d+)"[^>]*lat="([^"]+)" lon="([^"]+)"/g)) {
    nodes[m[1]] = { lat: parseFloat(m[2]), lon: parseFloat(m[3]) };
  }
  const block = xml.match(new RegExp(`<way id="${id}"[\\s\\S]*?</way>`))?.[0] || '';
  const refs = [...block.matchAll(/<nd ref="(\d+)"/g)].map((x) => x[1]);
  const tags = {};
  for (const tm of block.matchAll(/<tag k="([^"]+)" v="([^"]*)"/g)) tags[tm[1]] = tm[2];
  return refs.map((ref) => [nodes[ref].lon, nodes[ref].lat]);
}

function centroid(ring) {
  return {
    lng: ring.reduce((s, p) => s + p[0], 0) / ring.length,
    lat: ring.reduce((s, p) => s + p[1], 0) / ring.length,
  };
}

function distMeters(lng1, lat1, lng2, lat2) {
  const dLat = (lat2 - lat1) * 111320;
  const dLng = (lng2 - lng1) * 111320 * Math.cos((lat1 * Math.PI) / 180);
  return Math.sqrt(dLat * dLat + dLng * dLng);
}

function convexHull(points) {
  const pts = [...points];
  pts.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
  const cross = (o, a, b) => (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0]);
  const lower = [];
  for (const p of pts) {
    while (lower.length >= 2 && cross(lower.at(-2), lower.at(-1), p) <= 0) lower.pop();
    lower.push(p);
  }
  const upper = [];
  for (let i = pts.length - 1; i >= 0; i--) {
    const p = pts[i];
    while (upper.length >= 2 && cross(upper.at(-2), upper.at(-1), p) <= 0) upper.pop();
    upper.push(p);
  }
  const hull = lower.slice(0, -1).concat(upper.slice(0, -1));
  hull.push(hull[0]);
  return hull;
}

function printRing(name, ring) {
  console.log(`\n=== ${name} (${ring.length} pts) ===`);
  for (const p of ring) {
    console.log(`      [${p[0].toFixed(7)}, ${p[1].toFixed(7)}],`);
  }
}

const poiLat = 41.614267;
const poiLng = 0.625061;

const wayIds = [
  '264968607', // la Cuirassa archaeological site
  '1083782307',
  '1083782308',
  '1083782309',
  '1083782310',
  '1083782311',
  '1083782312',
  '1083782313',
  '1083782314',
];

const allPts = [];
for (const id of wayIds) {
  const ring = await fetchWay(id);
  allPts.push(...ring);
  const c = centroid(ring);
  console.log(`way ${id}: ${Math.round(distMeters(poiLng, poiLat, c.lng, c.lat))}m from POI`);
}

const hull = convexHull(allPts);
const hc = centroid(hull);
console.log('\nHull centroid dist from POI:', Math.round(distMeters(poiLng, poiLat, hc.lng, hc.lat)), 'm');
printRing('La Cuirassa hull', hull);

// Also print arch site alone for comparison
const arch = await fetchWay('264968607');
printRing('Archaeological site only', arch);
