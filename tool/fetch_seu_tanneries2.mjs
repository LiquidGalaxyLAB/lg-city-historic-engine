async function overpass(query) {
  const urls = [
    'https://overpass-api.de/api/interpreter',
    'https://overpass.kumi.systems/api/interpreter',
  ];
  for (const url of urls) {
    const res = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'User-Agent': 'lg-city-historic-engine/1.0',
      },
      body: 'data=' + encodeURIComponent(query),
    });
    const text = await res.text();
    try {
      const data = JSON.parse(text);
      if (data.elements?.length) return data;
    } catch {
      console.error('fail', url, text.slice(0, 200));
    }
    await new Promise((r) => setTimeout(r, 2000));
  }
  throw new Error('Overpass failed');
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

function extractPts(el) {
  if (el.type === 'way' && el.geometry) {
    return el.geometry.map((g) => [g.lon, g.lat]);
  }
  if (el.type === 'relation') {
    for (const m of el.members || []) {
      if (m.role === 'outer' && m.geometry?.length >= 3) {
        return m.geometry.map((g) => [g.lon, g.lat]);
      }
    }
  }
  return [];
}

async function listNear(label, lat, lng, query) {
  const data = await overpass(query);
  console.log(`\n## ${label} (${data.elements.length} elements)`);
  const rows = [];
  for (const el of data.elements) {
    const pts = extractPts(el);
    if (pts.length < 3) continue;
    const c = centroid(pts);
    rows.push({
      name: el.tags?.name || el.tags?.historic || el.tags?.building || el.id,
      d: distMeters(lng, lat, c.lng, c.lat),
      pts,
      tags: el.tags,
    });
  }
  rows.sort((a, b) => a.d - b.d);
  for (const r of rows.slice(0, 12)) {
    console.log(`  ${Math.round(r.d)}m  ${r.name}  ${JSON.stringify(r.tags || {})}`);
  }
  return rows;
}

const seuLat = 41.617475;
const seuLng = 0.626900;

const seuRows = await listNear(
  'Seu Vella',
  seuLat,
  seuLng,
  `[out:json][timeout:90];(` +
    `nwr["name"~"Seu Vella",i](around:600,${seuLat},${seuLng});` +
    `nwr["name"~"Catedral de Lleida",i](around:600,${seuLat},${seuLng});` +
    `way["historic"="cathedral"](around:450,${seuLat},${seuLng});` +
    `relation["historic"="cathedral"](around:450,${seuLat},${seuLng});` +
    `way["building"="cathedral"](around:450,${seuLat},${seuLng});` +
    `);out geom;`,
);

const bestSeu = seuRows.find((r) =>
  /seu|catedral|cathedral/i.test(String(r.name)),
);
if (bestSeu) printRing('Seu Vella BEST', simplify(bestSeu.pts));
else if (seuRows[0]) printRing('Seu Vella nearest', simplify(seuRows[0].pts));

const tanLat = 41.6142;
const tanLng = 0.6215;

const tanRows = await listNear(
  'Tanneries Rambla Ferran',
  tanLat,
  tanLng,
  `[out:json][timeout:90];(` +
    `nwr["name"~"curtid|tanner|adober",i](around:800,${tanLat},${tanLng});` +
    `nwr["tourism"="museum"]["name"~"curtid|adober",i](around:800,${tanLat},${tanLng});` +
    `way["historic"](around:250,${tanLat},${tanLng});` +
    `);out geom;`,
);

const bestTan = tanRows.find((r) => /curtid|tanner|adober/i.test(String(r.name)));
if (bestTan) printRing('Tanneries BEST', simplify(bestTan.pts));
else if (tanRows[0]) printRing('Tanneries nearest', simplify(tanRows[0].pts));
