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
    const ring = refs.map((ref) => [nodes[ref].lon, nodes[ref].lat]);
    ways.push({ id, ring, tags });
  }
  return ways;
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

const lat = 41.614267;
const lng = 0.625061;

// Nominatim search
const nom = await fetch(
  `https://nominatim.openstreetmap.org/search?q=${encodeURIComponent('Cuirassa Lleida')}&format=json&polygon_geojson=1&limit=10`,
  { headers: { 'User-Agent': 'lg-city/1.0' } },
).then((r) => r.json());

console.log('Nominatim results:');
for (const x of nom) {
  console.log(x.osm_type + x.osm_id, x.type, x.class, x.lat, x.lon, x.display_name?.slice(0, 90));
  if (x.geojson?.type === 'Polygon') {
    const ring = x.geojson.coordinates[0].map((c) => [c[0], c[1]]);
    const c = centroid(ring);
    console.log('  dist', Math.round(distMeters(lng, lat, c.lng, c.lat)), 'm', ring.length, 'pts');
    printRing(x.display_name?.slice(0, 40), simplify(ring));
  }
}

const overpassUrls = [
  'https://lz4.overpass-api.de/api/interpreter',
  'https://overpass-api.de/api/interpreter',
];

const queries = [
  `[out:json][timeout:60];(nwr["name"~"Cuirassa|Call Jueu|Juderia",i](around:400,${lat},${lng});way["historic"](around:200,${lat},${lng});relation["historic"](around:200,${lat},${lng}););out geom;`,
  `[out:json][timeout:60];(way["building"](around:150,${lat},${lng}););out geom;`,
];

for (const query of queries) {
  for (const url of overpassUrls) {
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
      console.log('\nOverpass OK', query.slice(0, 60), 'elements', data.elements?.length);
      const rows = [];
      for (const el of data.elements || []) {
        let pts = [];
        if (el.geometry) pts = el.geometry.map((g) => [g.lon, g.lat]);
        if (el.type === 'relation') {
          const m = (el.members || []).find((x) => x.role === 'outer' && x.geometry);
          if (m) pts = m.geometry.map((g) => [g.lon, g.lat]);
        }
        if (pts.length < 3) continue;
        const c = centroid(pts);
        rows.push({ name: el.tags?.name || el.id, d: distMeters(lng, lat, c.lng, c.lat), pts, tags: el.tags });
      }
      rows.sort((a, b) => a.d - b.d);
      for (const r of rows.slice(0, 8)) {
        console.log(`  ${Math.round(r.d)}m ${r.name}`, JSON.stringify(r.tags || {}));
        if (r.d < 120) printRing(String(r.name), simplify(r.pts));
      }
      break;
    } catch (e) {
      console.log('fail', url, String(e).slice(0, 60));
    }
  }
}

// Current polygon centroid
const current = [
  [0.6245732, 41.6138135], [0.6246996, 41.6137809], [0.6247183, 41.6137514],
  [0.6246298, 41.6137201], [0.6246548, 41.6136836], [0.6247349, 41.6137116],
  [0.6248660, 41.6139134], [0.6247895, 41.6139612], [0.6246801, 41.6140343],
];
const cc = centroid(current);
console.log('\nCurrent polygon centroid dist from POI:', Math.round(distMeters(lng, lat, cc.lng, cc.lat)), 'm');
