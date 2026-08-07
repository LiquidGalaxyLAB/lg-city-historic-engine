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
    console.error(text.slice(0, 300));
    throw new Error('Overpass failed');
  }
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

function distMeters(lng1, lat1, lng2, lat2) {
  const dLat = (lat2 - lat1) * 111320;
  const dLng = (lng2 - lng1) * 111320 * Math.cos((lat1 * Math.PI) / 180);
  return Math.sqrt(dLat * dLat + dLng * dLng);
}

function centroid(ring) {
  const cl = ring.reduce((s, p) => s + p[0], 0) / ring.length;
  const ca = ring.reduce((s, p) => s + p[1], 0) / ring.length;
  return { lng: cl, lat: ca };
}

function printRing(name, ring) {
  console.log(`\n=== ${name} (${ring.length} pts) ===`);
  for (const p of ring) {
    console.log(`      [${p[0].toFixed(7)}, ${p[1].toFixed(7)}],`);
  }
}

async function fetchBest(name, lat, lng, radius, extra = '') {
  const q =
    `[out:json][timeout:90];(` +
    `way["building"](around:${radius},${lat},${lng});` +
    `relation["building"](around:${radius},${lat},${lng});` +
    `way["historic"](around:${radius},${lat},${lng});` +
    `relation["historic"](around:${radius},${lat},${lng});` +
    `way["tourism"](around:${radius},${lat},${lng});` +
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
      for (const m of el.members || []) {
        if (m.role === 'outer' && m.geometry?.length >= 3) {
          pts = m.geometry.map((g) => [g.lon, g.lat]);
          break;
        }
      }
    }
    if (pts.length < 3) continue;
    const c = centroid(pts);
    const d = distMeters(lng, lat, c.lng, c.lat);
    const label = el.tags?.name || el.tags?.historic || el.tags?.building || 'feature';
    if (d < bestD) bestD = d, best = { pts, d, label, tags: el.tags };
  }

  console.log(`\n-- ${name} @ ${lat}, ${lng} r=${radius} --`);
  if (!best) {
    console.log('NO MATCH');
    return null;
  }
  console.log(`best: ${best.label} (${Math.round(best.d)}m)`, JSON.stringify(best.tags || {}));
  return simplify(best.pts);
}

async function searchName(namePattern, lat, lng, radius = 800) {
  const q =
    `[out:json][timeout:90];(` +
    `nwr["name"~"${namePattern}",i](around:${radius},${lat},${lng});` +
    `);out geom;`;
  const data = await overpass(q);
  console.log(`\nSearch "${namePattern}" near ${lat},${lng}:`);
  for (const el of data.elements || []) {
    let pts = [];
    if (el.geometry) pts = el.geometry.map((g) => [g.lon, g.lat]);
    if (el.type === 'relation') {
      const outer = (el.members || []).find((m) => m.role === 'outer' && m.geometry);
      if (outer) pts = outer.geometry.map((g) => [g.lon, g.lat]);
    }
    if (pts.length < 3) continue;
    const c = centroid(pts);
    const d = distMeters(lng, lat, c.lng, c.lat);
    console.log(`  ${el.tags?.name} (${Math.round(d)}m, ${pts.length} pts)`);
    if (el.tags?.name?.match(/curtid|tanner|Seu|Vella/i)) {
      printRing(el.tags.name, simplify(pts));
    }
  }
}

// Seu Vella cathedral on the hill
let seu = await fetchBest('Seu Vella POI', 41.617475, 0.626900, 350);
if (seu) printRing('Seu Vella', seu);

// Also search by name for cathedral complex
await searchName('Seu Vella', 41.617475, 0.626900, 500);

// Tanneries - current POI coords
let tan1 = await fetchBest('Tanneries POI', 41.617285, 0.629640, 150);
if (tan1) printRing('Tanneries @ POI', tan1);

// Rambla de Ferran area (city center)
await searchName('curtid|tanner', 41.614, 0.621, 600);
let tan2 = await fetchBest('Rambla Ferran area', 41.6142, 0.6215, 200);
if (tan2) printRing('Tanneries Rambla', tan2);
