async function overpass(query) {
  const urls = [
    'https://overpass-api.de/api/interpreter',
    'https://lz4.overpass-api.de/api/interpreter',
  ];
  for (const url of urls) {
    try {
      const res = await fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': 'lg-city-historic-engine/1.0',
        },
        body: 'data=' + encodeURIComponent(query),
      });
      const text = await res.text();
      const data = JSON.parse(text);
      if (data.elements?.length) return data;
    } catch (_) {}
    await new Promise((r) => setTimeout(r, 1500));
  }
  return null;
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

function extractPts(el) {
  if (el.geometry) return el.geometry.map((g) => [g.lon, g.lat]);
  if (el.type === 'relation') {
    const m = (el.members || []).find((x) => x.role === 'outer' && x.geometry);
    if (m) return m.geometry.map((g) => [g.lon, g.lat]);
  }
  return [];
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

const poiLat = 41.614267;
const poiLng = 0.625061;

const searches = [
  `[out:json][timeout:90];(nwr["name"~"Cuirassa|Jardins|Jardines|Juderia|Call Jueu",i](around:500,${poiLat},${poiLng}););out geom;`,
  `[out:json][timeout:90];(way["leisure"="park"](around:250,${poiLat},${poiLng});way["landuse"](around:250,${poiLat},${poiLng}););out geom;`,
  `[out:json][timeout:90];(way["historic"="archaeological_site"](around:300,${poiLat},${poiLng}););out geom;`,
];

for (const q of searches) {
  const data = await overpass(q);
  console.log('\nQuery elements:', data?.elements?.length ?? 0);
  for (const el of data?.elements || []) {
    const pts = extractPts(el);
    if (pts.length < 3) continue;
    const c = centroid(pts);
    console.log(
      el.type,
      el.id,
      el.tags?.name,
      el.tags?.historic || el.tags?.leisure || el.tags?.landuse,
      Math.round(distMeters(poiLng, poiLat, c.lng, c.lat)) + 'm',
      pts.length + 'pts',
    );
    if (/cuirassa|jard|jueu|jud|archaeological/i.test(JSON.stringify(el.tags || {}))) {
      printRing(el.tags?.name || String(el.id), pts);
    }
  }
}

// Combine buildings + archaeological site near POI for better area coverage
const bdata = await overpass(
  `[out:json][timeout:90];(` +
    `way["historic"="archaeological_site"](around:120,${poiLat},${poiLng});` +
    `way["building"](around:80,${poiLat},${poiLng});` +
    `);out geom;`,
);

const allPts = [];
for (const el of bdata?.elements || []) {
  allPts.push(...extractPts(el));
}
if (allPts.length >= 3) {
  const hull = convexHull(allPts);
  const c = centroid(hull);
  console.log('\nCombined hull dist from POI:', Math.round(distMeters(poiLng, poiLat, c.lng, c.lat)), 'm');
  printRing('Combined hull', hull);
}

// Test POI at archaeological site center
const archLat = 41.6138785;
const archLng = 0.6247169;
console.log('\nIf POI moved to arch site:', archLat, archLng);
