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
  const ring = refs.map((ref) => [nodes[ref].lon, nodes[ref].lat]);
  return { id, tags, ring };
}

function printRing(name, ring) {
  console.log(`\n=== ${name} (${ring.length} pts) ===`);
  for (const p of ring) {
    console.log(`      [${p[0].toFixed(7)}, ${p[1].toFixed(7)}],`);
  }
}

for (const id of ['1082529846', '1082529847', '1082529845', '282936632']) {
  const w = await fetchWay(id);
  console.log('\nWay', w.id, w.tags);
  printRing(w.id, w.ring);
}
