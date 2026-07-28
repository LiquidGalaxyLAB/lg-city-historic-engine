import { readFileSync, writeFileSync } from 'fs';

const path = new URL('./outlines_progress.json', import.meta.url);
const data = JSON.parse(readFileSync(path, 'utf8'));

data.entries['Automotive Museum'] = [
  [0.632707, 41.6132779],
  [0.6327889, 41.6132117],
  [0.632745, 41.6131819],
  [0.6329418, 41.613023],
  [0.6331325, 41.6128682],
  [0.6332512, 41.6129626],
  [0.6333658, 41.6130537],
  [0.6332379, 41.6131557],
  [0.6331377, 41.6132356],
  [0.6330042, 41.6133444],
  [0.63291, 41.6134212],
  [0.63279, 41.6133365],
  [0.632707, 41.6132779],
];
data.meta['Automotive Museum'] = 'nominatim:Museu de l\'Automoció RodaRoda';

data.entries['First University of the Kingdom of Aragon'] = [
  [0.6195214, 41.6143252],
  [0.6199696, 41.6142067],
  [0.6201558, 41.614599],
  [0.620444, 41.615206],
  [0.620458, 41.6152355],
  [0.6199607, 41.615333],
  [0.6199051, 41.6152053],
  [0.61969, 41.6147119],
  [0.6195214, 41.6143252],
];
data.meta['First University of the Kingdom of Aragon'] =
  'nominatim:Plaça de Víctor Siurana Lleida';

writeFileSync(path, JSON.stringify(data, null, 2));
console.log('Patched 2 POIs');
