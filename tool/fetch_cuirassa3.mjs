async function overpass(query) {
  const res = await fetch('https://overpass-api.de/api/interpreter', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'User-Agent': 'lg-city-historic-engine/1.0',
    },
    body: 'data=' + encodeURIComponent(query),
  });
  return res.json();
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

function printRing(name, ring) {
  console.log(`\n=== ${name} (${ring.length} pts) ===`);
  for (const p of ring) {
    console.log(`      [${p[0].toFixed(7)}, ${p[1].toFixed(7)}],`);
  }
}

const poiLat = 41.614267;
const poiLng = 0.625061;

const data = await overpass(
  `[out:json][timeout:90];(` +
    `way(around:100,${poiLat},${poiLng});` +
    `);out geom tags;`,
);

const rows = [];
for (const el of data.elements || []) {
  if (!el.geometry || el.geometry.length < 3) continue;
  const pts = el.geometry.map((g) => [g.lon, g.lat]);
  const c = centroid(pts);
  rows.push({
    id: el.id,
    name: el.tags?.name,
    tags: el.tags,
    d: distMeters(poiLng, poiLat, c.lng, c.lat),
    pts,
  });
}
rows.sort((a, b) => a.d - b.d);

for (const r of rows.slice(0, 25)) {
  const tagSummary = [
    r.tags?.building,
    r.tags?.historic,
    r.tags?.leisure,
    r.tags?.landuse,
    r.tags?.amenity,
  ]
    .filter(Boolean)
    .join(',');
  console.log(`${Math.round(r.d)}m way ${r.id} ${r.name || ''} [${tagSummary}] ${r.pts.length}pts`);
}

// Buildings only within 50m - merge for local cluster
const local = rows.filter((r) => r.d <= 50 && r.tags?.building);
const allPts = local.flatMap((r) => r.pts);
console.log('\nLocal buildings within 50m:', local.length, 'points', allPts.length);

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

if (allPts.length >= 3) {
  const hull = convexHull(allPts);
  const c = centroid(hull);
  console.log('Local hull dist', Math.round(distMeters(poiLng, poiLat, c.lng, c.lat)), 'm');
  printRing('Local building hull', hull);
}

// Archaeological site + nearest buildings to POI
const arch = rows.find((r) => r.tags?.name === 'la Cuirassa');
if (arch) {
  const mixPts = [...arch.pts, ...allPts];
  const hull2 = convexHull(mixPts);
  const c2 = centroid(hull2);
  console.log('Arch+buildings hull dist', Math.round(distMeters(poiLng, poiLat, c2.lng, c2.lat)), 'm');
  printRing('Arch + buildings hull', hull2);
}
