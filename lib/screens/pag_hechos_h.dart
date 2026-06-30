import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import 'pag_lanza_lg.dart';

class PagHechosHistoricos extends StatefulWidget {
  const PagHechosHistoricos({super.key});

  @override
  State<PagHechosHistoricos> createState() => _PagHechosHistoricosState();
}

class _PagHechosHistoricosState extends State<PagHechosHistoricos> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'Antigüedad': [
      POI(
        name: 'Revolta d\'Indíbil i Mandoni',
        location: '41.6191° N, 0.6232° E',
        image:
            'assets/images_historical_events/Revolta d\'Indíbil i Mandoni.jpg',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad antigua',
        fechaInici: '206 aC',
        fechaFi: '205 aC',
        descriptions: {
          'ca':
              'Indíbil i Mandonio, líders ibers, es van rebel·lar contra Roma en comprendre que Escipió no portaria la independència, sinó una nova ocupació. L\'any 205 aC, van formar una gran coalició de pobles de la vall de l\'Ebre per expulsar els invasors. Tanmateix, es van enfrontar a la superioritat tàctica de les legions en una batalla decisiva. Indíbil va morir en combat lluitant heroicament, cosa que va desmuntar la resistència de les seves tropes.',
          'es':
              'Indíbil y Mandonio, líderes íberos, se rebelaron contra Roma al comprender que Escipión no traería la independencia, sino una nueva ocupación. En el 205 a.C., formaron una gran coalición de pueblos del valle del Ebro para expulsar a los invasores. Sin embargo, se enfrentaron a la superioridad táctica de las legiones en una batalla definitiva. Indíbil murió en combate luchando heroicamente, lo que desmoronó la resistencia de sus tropas.',
          'en':
              'Indibilis and Mandonius, Iberian leaders, rebelled against Rome when they realized that Scipio would not bring independence but a new occupation. In 205 BC, they formed a large coalition of peoples from the Ebro Valley to expel the invaders. However, they faced the tactical superiority of the legions in a decisive battle. Indibilis died in combat fighting heroically, which shattered the resistance of his troops.',
        },
      ),
      POI(
        name: 'Batalla de Ilerda 49 aC',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Batalla de Ilerda 49 aC.png',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad antigua',
        fechaInici: '49 aC',
        fechaFi: '49 aC',
        descriptions: {
          'ca':
              'La Batalla d\'Ilerda (49 aC) va ser un enfrontament magistral de la Segona Guerra Civil romana en què Juli Cèsar va derrotar els generals de Pompeu, Afrani i Petreu, als voltants de l\'actual Lleida. Malgrat quedar aïllat i sense subministraments per una gran crescuda del riu Segre, Cèsar va capgirar la situació amb una brillant maniobra d\'enginyeria. En lloc de buscar una massacre, Cèsar va optar per una estratègia de desgast que va envoltar les legions pompeianes.',
          'es':
              'La Batalla de Ilerda (49 a. C.) fue un enfrentamiento magistral de la Segunda Guerra Civil romana donde Julio César derrotó a los generales de Pompeyo, Afranio y Petreyo, en los alrededores de la actual Lleida. A pesar de quedar aislado y sin suministros por una gran crecida del río Segre, César dio la vuelta a la situación con una brillante maniobra de ingeniería. En lugar de buscar una masacre, César optó por una estrategia de desgaste.',
          'en':
              'The Battle of Ilerda (49 BC) was a masterful engagement of the Second Roman Civil War in which Julius Caesar defeated Pompey\'s generals Afranius and Petreius in the area surrounding present-day Lleida. Despite being isolated and cut off from supplies after a major flood of the Segre River, Caesar reversed the situation through a brilliant engineering maneuver. Instead of seeking a massacre, Caesar chose a strategy of attrition.',
        },
      ),
    ],
    'Edad Media Temprana': [
      POI(
        name: 'Invasió musulmana',
        location: '41.6180° N, 0.6258° E',
        image: 'assets/images_historical_events/Invasio musulmana.jpg',
        lat: 41.6180451,
        lng: 0.6258326,
        range: 361.12,
        heading: 12.41,
        tilt: 0.0,
        epoca: 'Edad Media',
        fechaInici: '716',
        fechaFi: '719',
        descriptions: {
          'ca':
              'La ciutat va ser ocupada per les tropes àrabs i berbers entre els anys 716 i 719, aprofitant la ràpida descomposició del regne visigot. Sota el nom de Lārida, es va transformar en una fortalesa estratègica de la Marca Superior que protegia la frontera davant els regnes cristians del nord. Durant aquest període, els musulmans van desenvolupar un avançat sistema de regadiu a l\'horta i van erigir la Suda, una impressionant alcassaba sobre la roca sobirana.',
          'es':
              'La ciudad fue ocupada por las tropas árabes y bereberes entre los años 716 y 719, aprovechando la rápida descomposición del reino visigodo. Bajo el nombre de Lārida, se transformó en una fortaleza estratégica de la Marca Superior que protegía la frontera frente a los reinos cristianos del norte. Durante este periodo, los musulmanes desarrollaron un avanzado sistema de regadío en la huerta y erigieron la suda, una impresionante alcazaba sobre la roca soberana.',
          'en':
              'The city was occupied by Arab and Berber troops between the years 716 and 719, taking advantage of the rapid collapse of the Visigothic kingdom. Under the name Lārida, it became a strategic fortress of the Upper March, protecting the frontier against the Christian kingdoms to the north. During this period, the Muslims developed an advanced irrigation system in the surrounding farmland and built the suda, an impressive citadel standing atop the sovereign rock.',
        },
      ),
      POI(
        name: 'Setge de Lleida (800)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (800).png',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Media',
        fechaInici: '800',
        fechaFi: '800',
        descriptions: {
          'ca':
              'L\'any 800, les tropes carolíngies de Lluís el Pietós van assetjar Lleida amb l\'objectiu d\'expandir la Marca Hispànica cap al sud dels Pirineus. L\'exèrcit franc va devastar els voltants de la ciutat per ofegar-la econòmicament. Davant l\'assetjament, el valí de Lleida no es va rendir del tot, però va pactar una treva de tres anys i el pagament de tributs (paries) als francs.',
          'es':
              'En el año 800, las tropas carolingias de Luis el Piadoso sitiaron Lleida con el objetivo de expandir la Marca Hispánica hacia el sur de los Pirineos. El ejército franco devastó los alrededores de la ciudad para asfixiarla económicamente. Ante el asedio, el valí de Lleida no se rindió totalmente, pero pactó una tregua de tres años y el pago de tributos (parias) a los francos.',
          'en':
              'Indibilis and Mandonius, Iberian leaders, rebelled against Rome when they realized that Scipio would not bring independence but a new occupation. In 205 BC, they formed a large coalition of peoples from the Ebro Valley to expel the invaders. However, they faced the tactical superiority of the legions in a decisive battle. Indibilis died in combat fighting heroically, which shattered the resistance of his troops.',
        },
      ),
      POI(
        name: 'Setge de Lleida (884)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (884).png',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Media',
        fechaInici: '884',
        fechaFi: '884',
        descriptions: {
          'ca':
              'El comte Guifré el Pilós va atacar Lleida l\'any 884 com a resposta a la fortificació de la ciutat per part dels musulmans, que considerava una amenaça per als seus dominis. La ciutat estava governada pel valí Ismaïl ibn Mussa, membre de la poderosa família dels Banu Qasi. A diferència d\'altres incursions, l\'atac de Guifré va ser un fracàs militar. Les cròniques àrabs de l\'època parlen d\'una gran mortaldat entre les tropes catalanes.',
          'es':
              'El conde Wifredo el Velloso atacó Lleida en el año 884 como respuesta a la fortificación de la ciudad por parte de los musulmanes, a quienes consideraba una amenaza para sus dominios. La ciudad estaba gobernada por el valí Ismaíl ibn Musa, miembro de la poderosa familia de los Banu Qasi. A diferencia de otras incursiones, el ataque de Wifredo fue un fracaso militar.',
          'en':
              'Count Wilfred the Hairy attacked Lleida in the year 884 in response to the fortification of the city by the Muslims, which he considered a threat to his domains. The city was governed by the wali Ismaïl ibn Musa, a member of the powerful Banu Qasi family. Unlike other incursions, Wilfred\'s attack was a military failure.',
        },
      ),
    ],
    'Reconquista / Alta Edad Media': [
      POI(
        name: 'Reconquesta Cristiana 1149',
        location: '41.6090° N, 0.6103° E',
        image: 'assets/images_historical_events/Reonquista Cristiana1149.jpg',
        lat: 41.6089691,
        lng: 0.6103237,
        range: 1159.27,
        heading: -53.72,
        tilt: 56.84,
        epoca: 'Edad Media',
        fechaInici: '1149',
        fechaFi: '1149',
        descriptions: {
          'ca':
              'Les hostes de Ramon Berenguer IV i Ermengol VI d\'Urgell van establir el seu campament estratègic al turó de Gardeny durant la primavera de 1149 per iniciar el setge definitiu de la ciutat. La resistència musulmana finalment es va trencar el 24 d\'octubre de 1149, quan la guarnició almoràvit va capitular. Aquesta victòria no només va suposar la presa de Lleida, sinó que va provocar la caiguda immediata de Fraga i Mequinensa.',
          'es':
              'Las huestes de Ramón Berenguer IV y Ermengol VI de Urgell establecieron su campamento estratégico en la colina de Gardeny durante la primavera de 1149 para iniciar el cerco definitivo a la ciudad. La resistencia musulmana finalmente se quebró el 24 de octubre de 1149, cuando la guarnición almorávide capituló. Esta victoria no solo supuso la toma de Lleida, sino que forzó la caída inmediata de Fraga y Mequinenza.',
          'en':
              'The forces of Ramon Berenguer IV and Ermengol VI of Urgell established their strategic camp on the hill of Gardeny during the spring of 1149 to begin the final siege of the city. Muslim resistance finally collapsed on 24 October 1149, when the Almoravid garrison surrendered. This victory not only resulted in the capture of Lleida but also triggered the immediate fall of Fraga and Mequinenza.',
        },
      ),
      POI(
        name: 'Unió del regne de Aragó i comtat de Barcelona',
        location: '41.6168° N, 0.6255° E',
        image:
            'assets/images_historical_events/Unio del regne de Arago i comtat de barcelona.jpg',
        lat: 41.6167910,
        lng: 0.6254991,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Media',
        fechaInici: '1150',
        fechaFi: '1150',
        descriptions: {
          'ca':
              'A l\'agost de 1150, el Castell de la Suda de Lleida va acollir el casament entre Peronella d\'Aragó i Ramon Berenguer IV. La reina tenia 14 anys, complint així el compromís pactat quan era un nadó. Aquest enllaç va ser l\'acte fundacional de la Corona d\'Aragó. Va unir el Regne d\'Aragó amb el Comtat de Barcelona, creant una potència política que respectava les lleis i els furs de cada territori.',
          'es':
              'En agosto de 1150, el Castell de la Suda en Lérida acogió la boda entre Petronila de Aragón y Ramón Berenguer IV. La reina tenía 14 años, cumpliendo así el compromiso pactado cuando era un bebé. Este enlace fue el acto fundacional de la Corona de Aragón. Unió el Reino de Aragón con el Condado de Barcelona, creando una potencia política que respetaba las leyes y fueros de cada territorio.',
          'en':
              'In August 1150, the Castell de la Suda in Lleida hosted the wedding between Petronila of Aragon and Ramon Berenguer IV. The queen was 14 years old, thus fulfilling the marriage pact arranged when she was an infant. This union was the foundational act of the Crown of Aragon. It joined the Kingdom of Aragon with the County of Barcelona, creating a political power that respected the laws and privileges of each territory.',
        },
      ),
    ],
    'Edad Media / Baja Edad Media': [
      POI(
        name: 'Jura de fidelitat a Jaume I',
        location: '41.6180° N, 0.6258° E',
        image:
            'assets/images_historical_events/jura de fidelitat a Jaume I.jpg',
        lat: 41.6180451,
        lng: 0.6258326,
        range: 361.12,
        heading: 12.41,
        tilt: 0.0,
        epoca: 'Edad Media',
        fechaInici: '1214',
        fechaFi: '1214',
        descriptions: {
          'ca':
              'Les Corts de Lleida de 1214 es consideren les primeres de la història catalana amb participació dels tres estaments, convocades amb urgència per jurar fidelitat al nen Jaume I i estabilitzar la Corona d\'Aragó després de la catastròfica mort de Pere el Catòlic a la batalla de Muret. Davant la minoria d\'edat del nou monarca, l\'assemblea va designar el comte Sanç de Rosselló com a procurador general per governar el territori.',
          'es':
              'Las Cortes de Lérida de 1214 se consideran las primeras de la historia catalana con participación de los tres estamentos, convocadas de urgencia para jurar fidelidad al niño Jaime I y estabilizar la Corona de Aragón tras la catastrófica muerte de Pedro el Católico en la batalla de Muret. Ante la minoría de edad del nuevo monarca, la asamblea designó al conde Sancho de Rosellón como procurador general para gobernar el territorio.',
          'en':
              'The Cortes of Lleida of 1214 are considered the first in Catalan history to include participation from the three estates. They were urgently convened to swear loyalty to the child king James I and to stabilize the Crown of Aragon after the catastrophic death of Peter the Catholic at the Battle of Muret. Given the new monarch\'s minority, the assembly appointed Count Sancho of Roussillon as general procurator to govern the territory.',
        },
      ),
      POI(
        name: 'Primera universitat del regne d\'Aragó',
        location: '41.6147° N, 0.6199° E',
        image:
            'assets/images_historical_events/Primera universitat del regne d\'arago.jpg',
        lat: 41.6146803,
        lng: 0.6198760,
        range: 270.14,
        heading: -70.55,
        tilt: 47.35,
        epoca: 'Edad Media',
        fechaInici: '1300',
        fechaFi: '1300',
        descriptions: {
          'ca':
              'Fundat l\'any 1300 per Jaume II després d\'una butlla papal de 1297, l\'Estudi General de Lleida va ser la primera universitat de Catalunya i de la Corona d\'Aragó. Durant segles va destacar com a centre de referència en Dret, Medicina i Filosofia, seguint el prestigiós model organitzatiu de la Universitat de Bolonya. L\'any 1717, Felip V va clausurar la institució mitjançant el Decret de Nova Planta. La Universitat de Lleida actual es va refundar el 1991.',
          'es':
              'Fundado en 1300 por Jaime II tras una bula papal de 1297, el Estudi General de Lleida fue la primera universidad de Cataluña y de la Corona de Aragón. Durante siglos destacó como centro de referencia en Derecho, Medicina y Filosofía, siguiendo el prestigioso modelo organizativo de la Universidad de Bolonia. En 1717, Felipe V clausuró la institución mediante el Decreto de Nueva Planta. La actual Universidad de Lleida se refundó en 1991.',
          'en':
              'Founded in 1300 by James II following a papal bull issued in 1297, the Estudi General of Lleida was the first university in Catalonia and in the Crown of Aragon. For centuries it stood out as a leading center in Law, Medicine, and Philosophy, following the prestigious organizational model of the University of Bologna. In 1717, Philip V closed the institution through the Nueva Planta Decree. The modern University of Lleida was re-established in 1991.',
        },
      ),
      POI(
        name: 'Setge de Lleida (1413)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1413).jpg',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Media',
        fechaInici: '1413',
        fechaFi: '1414',
        descriptions: {
          'ca':
              'Després del Compromís de Casp, Jaume II d\'Urgell es va alçar contra el nou rei Ferran I. El juny de 1413, les tropes del comte van intentar prendre Lleida per sorpresa. Tanmateix, la ciutat es va mantenir fidel a Ferran I i les seves defenses van repel·lir l\'atac inicial. El fracàs a Lleida va deixar el comte d\'Urgell en una posició desesperada, forçant-lo a retirar-se cap a Balaguer.',
          'es':
              'Tras el Compromiso de Caspe, Jaime II de Urgel se alzó contra el nuevo rey Fernando I. En junio de 1413, las tropas del conde intentaron tomar Lérida por sorpresa. Sin embargo, la ciudad se mantuvo fiel a Fernando I y sus defensas repelieron el ataque inicial. El fracaso en Lérida dejó al conde de Urgel en una posición desesperada, forzándolo a retirarse hacia Balaguer.',
          'en':
              'After the Compromise of Caspe, James II of Urgell rose up against the new king, Ferdinand I. In June 1413, the count\'s troops attempted to seize Lleida by surprise. However, the city remained loyal to Ferdinand I, and its defenses repelled the initial attack. The failure at Lleida left the Count of Urgell in a desperate position, forcing him to retreat to Balaguer.',
        },
      ),
    ],
    'Edad Moderna': [
      POI(
        name: 'La batalla de Lleida (1642)',
        location: '41.6100° N, 0.6367° E',
        image:
            'assets/images_historical_events/La batalla de Lleida (1642).jpg',
        lat: 41.6100091,
        lng: 0.6367412,
        range: 2017.02,
        heading: -53.71,
        tilt: 56.85,
        epoca: 'Edad Moderna',
        fechaInici: '1642',
        fechaFi: '1642',
        descriptions: {
          'ca':
              'El 7 d\'octubre de 1642, en plena Guerra dels Segadors, l\'exèrcit espanyol va intentar recuperar Lleida per frenar l\'avanç francès a Catalunya. Les tropes de la Monarquia Hispànica, dirigides pel marquès de Leganés, van topar amb l\'exèrcit franco-català del mariscal La Mothe-Houdancourt. Malgrat la seva superioritat numèrica, les forces espanyoles van patir una derrota estrepitosa.',
          'es':
              'El 7 de octubre de 1642, en plena Guerra de los Segadores, el ejército español intentó recuperar Lérida para frenar el avance francés en Cataluña. Las tropas de la Monarquía Hispánica, dirigidas por el marqués de Leganés, chocaron contra el ejército franco-catalán del mariscal La Mothe-Houdancourt. A pesar de su superioridad numérica, las fuerzas españolas sufrieron una derrota estrepitosa.',
          'en':
              'On 7 October 1642, in the midst of the Reapers\' War, the Spanish army attempted to retake Lleida in order to halt the French advance in Catalonia. The troops of the Hispanic Monarchy, led by the Marquis of Leganés, clashed with the Franco-Catalan army commanded by Marshal La Mothe-Houdancourt. Despite their numerical superiority, the Spanish forces suffered a crushing defeat.',
        },
      ),
      POI(
        name: 'Setge de Lleida (1644)',
        location: '41.6149° N, 0.6204° E',
        image: 'assets/images_historical_events/Setge de lleida (1644).png',
        lat: 41.6149206,
        lng: 0.6204228,
        range: 1229.41,
        heading: -52.03,
        tilt: 60.58,
        epoca: 'Edad Moderna',
        fechaInici: '1644',
        fechaFi: '1644',
        descriptions: {
          'ca':
              'El maig de 1644, l\'exèrcit de Felip IV, liderat per Felip de Silva, va posar setge a la ciutat de Lleida després d\'haver recuperat Montsó. Les tropes de la Monarquia Hispànica van aconseguir derrotar l\'exèrcit francès de La Mothe-Houdancourt. La ciutat va capitular a finals de juliol de 1644, fet que va representar una de les victòries militars i estratègiques més importants per a Espanya durant la Guerra dels Segadors.',
          'es':
              'En mayo de 1644, el ejército de Felipe IV, liderado por Felipe de Silva, puso bajo asedio la ciudad de Lérida tras haber recuperado Monzón. Las tropas de la Monarquía Hispánica lograron derrotar al ejército francés de La Mothe-Houdancourt. La ciudad capituló a finales de julio de 1644, lo que representó una de las victorias militares y estratégicas más importantes para España en la Guerra de los Segadores.',
          'en':
              'In May 1644, the army of Philip IV, led by Felipe de Silva, laid siege to the city of Lleida after having retaken Monzón. The troops of the Hispanic Monarchy succeeded in defeating the French army of La Mothe-Houdancourt. The city surrendered at the end of July 1644, marking one of the most important military and strategic victories for Spain in the Reapers\' War.',
        },
      ),
      POI(
        name: 'Setge de Lleida (1646)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1646).jpg',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Moderna',
        fechaInici: '1646',
        fechaFi: '1646',
        descriptions: {
          'ca':
              'El maig de 1646, les tropes franceses sota el comandament del comte d\'Harcourt van assetjar Lleida amb l\'objectiu de recuperar-la per al bàndol franco-català. L\'exèrcit espanyol, dirigit pel marquès de Leganés, va aconseguir trencar el setge francès mitjançant un audaciós atac sorpresa nocturn. La derrota francesa va ser tan contundent que Harcourt es va veure obligat a fugir abandonant artilleria i subministraments.',
          'es':
              'En mayo de 1646, las tropas francesas bajo el mando del conde de Harcourt sitiaron Lérida con el objetivo de recuperarla para el bando franco-catalán. El ejército español, dirigido por el marqués de Leganés, logró romper el cerco francés mediante un audaz ataque sorpresa nocturno. La derrota francesa fue tan contundente que Harcourt se vio obligado a huir abandonando artillería y suministros.',
          'en':
              'In May 1646, the French troops under the command of the Count of Harcourt laid siege to Lleida with the aim of recapturing it for the Franco-Catalan side. The Spanish army, led by the Marquis of Leganés, managed to break the French siege through a daring nighttime surprise attack. The French defeat was so overwhelming that Harcourt was forced to flee, abandoning artillery and supplies.',
        },
      ),
      POI(
        name: 'Setge de Lleida (1647)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1647).png',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Moderna',
        fechaInici: '1647',
        fechaFi: '1647',
        descriptions: {
          'ca':
              'El maig de 1647, el prestigiós príncep de Condé, heroi francès de Rocroi, va iniciar un nou setge sobre Lleida amb la intenció d\'esmenar el fracàs de l\'any anterior. La defensa de la ciutat va recaure en el governador Gregorio Brito, que va resistir amb tenacitat els assalts. Davant l\'impossibilitat de trencar les muralles, Condé es va veure obligat a aixecar el setge al juny, patint una de les poques derrotes de la seva carrera militar.',
          'es':
              'En mayo de 1647, el prestigioso príncipe de Condé, héroe francés de Rocroi, inició un nuevo asedio sobre Lérida con la intención de enmendar el fracaso del año anterior. La defensa de la ciudad corrió a cargo del gobernador Gregorio Brito, quien resistió con tenacidad los asaltos. Ante la imposibilidad de romper las murallas, Condé se vio obligado a levantar el sitio en junio, sufriendo una de las pocas derrotas de su carrera militar.',
          'en':
              'In May 1647, the prestigious Prince of Condé, the French hero of Rocroi, launched a new siege of Lleida in an attempt to make up for the failure of the previous year. The city\'s defense was led by Governor Gregorio Brito, who tenaciously resisted the assaults. Unable to breach the walls, Condé was forced to lift the siege in June, suffering one of the few defeats of his military career.',
        },
      ),
      POI(
        name: 'Setge de Lleida (1707)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1707)png.png',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Moderna',
        fechaInici: '1707',
        fechaFi: '1707',
        descriptions: {
          'ca':
              'El setembre de 1707, després de la derrota austriacista a Almansa, les tropes borbòniques del duc d\'Orleans van assetjar Lleida. Després d\'un mes d\'intensos bombardejos, els borbònics van assaltar la ciutat el 12 d\'octubre. La victòria borbònica va suposar un càstig sever per a Lleida: la ciutat va ser saquejada, va perdre els seus furs i la seva universitat fou clausurada.',
          'es':
              'En septiembre de 1707, tras la derrota austriacista en Almansa, las tropas borbónicas del Duque de Orleans cercaron Lérida. Tras un mes de intensos bombardeos, los borbones asaltaron la ciudad el 12 de octubre. La victoria borbónica supuso un castigo severo para Lérida: la ciudad fue saqueada, perdió sus fueros y su universidad fue clausurada.',
          'en':
              'In September 1707, after the Austriacist defeat at Almansa, the Bourbon troops of the Duke of Orléans laid siege to Lleida. After a month of intense bombardment, the Bourbons stormed the city on 12 October. The Bourbon victory brought severe punishment upon Lleida: the city was sacked, it lost its traditional privileges, and its university was closed.',
        },
      ),
    ],
    'Edad Contemporánea': [
      POI(
        name: 'Setge de Lleida (1810)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1810).png',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Contemporánea',
        fechaInici: '1810',
        fechaFi: '1810',
        descriptions: {
          'ca':
              'El maig de 1810, durant la Guerra del Francès, les tropes napoleòniques del mariscal Suchet van assetjar Lleida després de la seva victòria a la batalla de Margalef. La guarnició espanyola, liderada pel general Jaime García-Conde, va resistir un violent bombardeig fins que els francesos van aconseguir obrir bretxes a les muralles de la ciutat. La capitulació final, el 14 de maig, va permetre als francesos controlar una plaça estratègica clau.',
          'es':
              'En mayo de 1810, durante la Guerra de la Independencia, las tropas napoleónicas del mariscal Suchet sitiaron Lérida tras su victoria en la batalla de Margalef. La guarnición española, liderada por el general Jaime García-Conde, resistió un violento bombardeo hasta que los francesos lograron abrir brechas en las murallas de la ciudad. La capitulación final el 14 de mayo permitió a los franceses controlar una plaza estratégica clave.',
          'en':
              'In May 1810, during the Peninsular War, the Napoleonic troops of Marshal Suchet laid siege to Lleida after their victory at the Battle of Margalef. The Spanish garrison, led by General Jaime García-Conde, resisted a violent bombardment until the French managed to open breaches in the city walls. The final capitulation on 14 May allowed the French to secure a key strategic stronghold.',
        },
      ),
      POI(
        name: 'Batalla de Lleida (1938)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Batalla de Lleida (1938).jpeg',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edad Contemporánea',
        fechaInici: '1938',
        fechaFi: '1938',
        descriptions: {
          'ca':
              'La Batalla de Lleida, culminada el 3 d\'abril de 1938, va marcar l\'entrada definitiva de les tropes de Franco a Catalunya després de trencar el front d\'Aragó. El general Yagüe va liderar l\'assalt contra una defensa republicana que, encapçalada per "El Campesino", va resistir ferotgement al nucli urbà sota intensos bombardejos. La caiguda de Lleida va tenir un impacte polític immediat, ja que va permetre a Franco derogar l\'Estatut d\'Autonomia de Catalunya.',
          'es':
              'La Batalla de Lleida, culminada el 3 de abril de 1938, marcó la entrada definitiva de las tropas de Franco en Cataluña tras romper el frente de Aragón. El general Yagüe lideró el asalto contra una defensa republicana que, encabezada por "El Campesino", resistió ferozmente en el casco urbano bajo intensos bombardeos. La caída de Lleida tuvo un peso político inmediato, ya que permitió a Franco derogar el Estatuto de Autonomía de Cataluña.',
          'en':
              'The Battle of Lleida, which culminated on 3 April 1938, marked the definitive entry of Franco\'s troops into Catalonia after breaking through the Aragon front. General Yagüe led the assault against a Republican defense that, under the command of "El Campesino," fought fiercely in the urban center under heavy bombardment. The fall of Lleida had an immediate political impact, as it allowed Franco to abolish Catalonia\'s Statute of Autonomy.',
        },
      ),
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, _) {
        final List<POI> allPois = _selectedCategory == 'All'
            ? _data.values.expand((x) => x).toList()
            : (_data[_selectedCategory] ?? []);

        final List<POI> pois = allPois.where((poi) {
          return poi.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF8F7F2),
          body: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/denoche.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.55),
                          Colors.transparent,
                          Colors.black.withOpacity(0.45),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => MenuFlotante.mostrar(
                              context,
                              currentTitle: T.s('events'),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                          ),
                          const AppTopBar(
                            onDarkBackground: true,
                            wifiOnly: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 90,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          T.s('events').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          T.s('events_subtitle'),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 35,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.history_edu_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${pois.length} ${T.s('events_available')}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -28,
                    left: 16,
                    right: 16,
                    child: _buildFilterBar(),
                  ),
                ],
              ),
              const SizedBox(height: 45),
              Expanded(
                child: pois.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 80,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              T.s('no_results_found'),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 0,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: pois.length,
                        itemBuilder: (context, index) =>
                            _cardPunto(pois[index]),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          const Icon(Icons.search_rounded, color: Color(0xFF8E8E93), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: T.s('search_events'),
                hintStyle: const TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF1C1C1E)),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
              child: const Icon(
                Icons.close_rounded,
                color: Color(0xFF8E8E93),
                size: 20,
              ),
            ),
          const SizedBox(width: 10),
          _buildCategoryDropdown(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      offset: const Offset(0, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 12,
      itemBuilder: (context) {
        List<String> categories = ['All', ..._data.keys];
        return categories
            .map(
              (cat) => PopupMenuItem<String>(
                value: cat,
                child: Text(
                  cat == 'All' ? T.s('show_all') : cat,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: _selectedCategory == cat
                        ? FontWeight.w800
                        : FontWeight.w500,
                    color: const Color(0xFF1C1C1E),
                  ),
                ),
              ),
            )
            .toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              T.s('categories'),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                color: Color(0xFF1C1C1E),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF1C1C1E),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardPunto(POI poi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.asset(
              poi.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    poi.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'serif',
                      color: Color(0xFF1C1C1E),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PagLanzaLG(poi: poi),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      T.s('send_lg'),
                      style: const TextStyle(
                        color: Color(0xFF6B5B45),
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
