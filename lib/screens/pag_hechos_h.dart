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
<<<<<<< HEAD
        image:
            'assets/images_historical_events/Revolta d\'Indíbil i Mandoni.jpg',
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Antiga',
        fechaInici: '206 aC',
        fechaFi: '205 aC',
        description:
            'Indíbil i Mandoni, líders ibers, es van rebel·lar contra Roma en comprendre que Escipió no portaria la independència, sinó una nova ocupació. L\'any 205 aC, van formar una gran coalició de pobles de la vall de l\'Ebre per expulsar els invasors. Tanmateix, es van enfrontar a la superioritat tàctica de les legions en una batalla decisiva. Indíbil va morir en combat lluitant heroicament, cosa que va desmuntar la resistència de les seves tropes.',
=======
        image: 'assets/images_historical_events/Revolta d\'Indíbil i Mandoni.jpg',
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Batalla de Ilerda 49 aC',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Batalla de Ilerda 49 aC.png',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Antiga',
        fechaInici: '49 aC',
        fechaFi: '49 aC',
        description:
            'La Batalla d\'Ilerda va ser un enfrontament magistral de la Segona Guerra Civil romana en què Juli Cèsar va derrotar els generals de Pompeu, Afrani i Petreu, als voltants de l\'actual Lleida. Malgrat quedar aïllat i sense subministraments per una gran crescuda del riu Segre, Cèsar va capgirar la situació amb una brillant maniobra d\'enginyeria i una estratègia de desgast que va envoltar les legions pompeianes.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
    ],
    'Edad Media Temprana': [
      POI(
        name: 'Invasió musulmana',
        location: '41.6180° N, 0.6258° E',
        image: 'assets/images_historical_events/invasio_musulmana.jpg',
<<<<<<< HEAD
        lat: 41.6180451,
        lng: 0.6258326,
        range: 361.12,
        heading: 12.41,
        tilt: 0.0,
        epoca: 'Edat Mitjana',
        fechaInici: '716',
        fechaFi: '719',
        description:
            'La ciutat va ser ocupada per les tropes àrabs i berbers entre els anys 716 i 719, aprofitant la ràpida descomposició del regne visigot. Sota el nom de Lārida, es va transformar en una fortalesa estratègica de la Marca Superior. Durant aquest període, els musulmans van desenvolupar un avançat sistema de regadiu a l\'horta i van erigir la Suda, una impressionant alcassaba sobre la roca sobirana.',
=======
        lat: 41.6180451, lng: 0.6258326, range: 361.12, heading: 12.41, tilt: 0.0,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Setge de Lleida (800)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (800).png',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Mitjana',
        fechaInici: '800',
        fechaFi: '800',
        description:
            'L\'any 800, les tropes carolíngies de Lluís el Pietós van assetjar Lleida amb l\'objectiu d\'expandir la Marca Hispànica cap al sud dels Pirineus. L\'exèrcit franc va devastar els voltants de la ciutat per ofegar-la econòmicament. Davant l\'assetjament, el valí de Lleida va pactar una treva de tres anys i el pagament de tributs als francs.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Setge de Lleida (884)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (884).png',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Mitjana',
        fechaInici: '884',
        fechaFi: '884',
        description:
            'El comte Guifré el Pilós va atacar Lleida l\'any 884 com a resposta a la fortificació de la ciutat per part dels musulmans. La ciutat estava governada pel valí Ismaïl ibn Mussa, membre de la poderosa família dels Banu Qasi. L\'atac de Guifré va ser un fracàs militar: les cròniques àrabs parlen d\'una gran mortaldat entre les tropes catalanes.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
    ],
    'Reconquista / Alta Edad Media': [
      POI(
        name: 'Reconquesta Cristiana 1149',
        location: '41.6090° N, 0.6103° E',
        image: 'assets/images_historical_events/reconquista_cristiana_1149.jpg',
<<<<<<< HEAD
        lat: 41.6089691,
        lng: 0.6103237,
        range: 1159.27,
        heading: -53.72,
        tilt: 56.84,
        epoca: 'Edat Mitjana',
        fechaInici: '1149',
        fechaFi: '1149',
        description:
            'Les hostes de Ramon Berenguer IV i Ermengol VI d\'Urgell van establir el seu campament estratègic al turó de Gardeny durant la primavera de 1149 per iniciar el setge definitiu de la ciutat. La resistència musulmana finalment es va trencar el 24 d\'octubre de 1149, quan la guarnició almoràvit va capitular. Aquesta victòria va provocar la caiguda immediata de Fraga i Mequinensa.',
=======
        lat: 41.6089691, lng: 0.6103237, range: 1159.27, heading: -53.72, tilt: 56.84,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Unió del regne de Aragó i comtat de Barcelona',
        location: '41.6168° N, 0.6255° E',
<<<<<<< HEAD
        image:
            'assets/images_historical_events/Unio del regne de Arago i comtat de barcelona.jpg',
        lat: 41.6167910,
        lng: 0.6254991,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Mitjana',
        fechaInici: '1150',
        fechaFi: '1150',
        description:
            'A l\'agost de 1150, el Castell de la Suda de Lleida va acollir el casament entre Peronella d\'Aragó i Ramon Berenguer IV. Aquest enllaç va ser l\'acte fundacional de la Corona d\'Aragó, unint el Regne d\'Aragó amb el Comtat de Barcelona i creant una potència política que respectava les lleis i els furs de cada territori.',
=======
        image: 'assets/images_historical_events/Unio del regne de Arago i comtat de barcelona.jpg',
        lat: 41.6167910, lng: 0.6254991, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
    ],
    'Edad Media / Baja Edad Media': [
      POI(
        name: 'Jura de fidelitat a Jaume I',
        location: '41.6180° N, 0.6258° E',
        image: 'assets/images_historical_events/jura_fidelitat_jaume1.jpg',
<<<<<<< HEAD
        lat: 41.6180451,
        lng: 0.6258326,
        range: 361.12,
        heading: 12.41,
        tilt: 0.0,
        epoca: 'Edat Mitjana',
        fechaInici: '1214',
        fechaFi: '1214',
        description:
            'Les Corts de Lleida de 1214 es consideren les primeres de la història catalana amb participació dels tres estaments, convocades amb urgència per jurar fidelitat al nen Jaume I i estabilitzar la Corona d\'Aragó després de la catastròfica mort de Pere el Catòlic a la batalla de Muret. L\'assemblea va designar el comte Sanç de Rosselló com a procurador general per governar el territori.',
=======
        lat: 41.6180451, lng: 0.6258326, range: 361.12, heading: 12.41, tilt: 0.0,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Primera universitat del regne d\'Aragó',
        location: '41.6147° N, 0.6199° E',
<<<<<<< HEAD
        image:
            'assets/images_historical_events/Primera universitat del regne d\'arago.jpg',
        lat: 41.6146803,
        lng: 0.6198760,
        range: 270.14,
        heading: -70.55,
        tilt: 47.35,
        epoca: 'Edat Mitjana',
        fechaInici: '1300',
        fechaFi: '1300',
        description:
            'Fundat l\'any 1300 per Jaume II després d\'una butlla papal de 1297, l\'Estudi General de Lleida va ser la primera universitat de Catalunya i de la Corona d\'Aragó. Durant segles va destacar com a centre de referència en Dret, Medicina i Filosofia. L\'any 1717, Felip V va clausurar la institució. La Universitat de Lleida actual es va refundar el 1991.',
=======
        image: 'assets/images_historical_events/Primera universitat del regne d\'arago.jpg',
        lat: 41.6146803, lng: 0.6198760, range: 270.14, heading: -70.55, tilt: 47.35,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Setge de Lleida (1413)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1413).jpg',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Mitjana',
        fechaInici: '1413',
        fechaFi: '1414',
        description:
            'Després del Compromís de Casp, Jaume II d\'Urgell es va alçar contra el nou rei Ferran I. El juny de 1413, les tropes del comte van intentar prendre Lleida per sorpresa. La ciutat es va mantenir fidel a Ferran I i les seves defenses van repel·lir l\'atac inicial, forçant el comte d\'Urgell a retirar-se cap a Balaguer.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
    ],
    'Edad Moderna': [
      POI(
        name: 'La batalla de Lleida (1642)',
        location: '41.6100° N, 0.6367° E',
<<<<<<< HEAD
        image:
            'assets/images_historical_events/La batalla de Lleida (1642).jpg',
        lat: 41.6100091,
        lng: 0.6367412,
        range: 2017.02,
        heading: -53.71,
        tilt: 56.85,
        epoca: 'Edat Moderna',
        fechaInici: '1642',
        fechaFi: '1642',
        description:
            'El 7 d\'octubre de 1642, en plena Guerra dels Segadors, l\'exèrcit espanyol va intentar recuperar Lleida. Les tropes de la Monarquia Hispànica, dirigides pel marquès de Leganés, van topar amb l\'exèrcit franco-català del mariscal La Mothe-Houdancourt. Malgrat la seva superioritat numèrica, les forces espanyoles van patir una derrota estrepitosa.',
=======
        image: 'assets/images_historical_events/La batalla de Lleida (1642).jpg',
        lat: 41.6100091, lng: 0.6367412, range: 2017.02, heading: -53.71, tilt: 56.85,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Setge de Lleida (1644)',
        location: '41.6149° N, 0.6204° E',
        image: 'assets/images_historical_events/Setge de lleida (1644).png',
<<<<<<< HEAD
        lat: 41.6149206,
        lng: 0.6204228,
        range: 1229.41,
        heading: -52.03,
        tilt: 60.58,
        epoca: 'Edat Moderna',
        fechaInici: '1644',
        fechaFi: '1644',
        description:
            'El maig de 1644, l\'exèrcit de Felip IV, liderat per Felip de Silva, va posar setge a la ciutat de Lleida. Les tropes de la Monarquia Hispànica van aconseguir derrotar l\'exèrcit francès de La Mothe-Houdancourt. La capitulació final, a finals de juliol de 1644, va representar una de les victòries militars més importants per a Espanya durant la Guerra dels Segadors.',
=======
        lat: 41.6149206, lng: 0.6204228, range: 1229.41, heading: -52.03, tilt: 60.58,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Setge de Lleida (1646)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1646).jpg',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Moderna',
        fechaInici: '1646',
        fechaFi: '1646',
        description:
            'El maig de 1646, les tropes franceses sota el comandament del comte d\'Harcourt van assetjar Lleida. L\'exèrcit espanyol, dirigit pel marquès de Leganés, va aconseguir trencar el setge mitjançant un audaciós atac sorpresa nocturn. La derrota francesa va ser tan contundent que Harcourt es va veure obligat a fugir abandonant artilleria i subministraments.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Setge de Lleida (1647)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1647).png',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Moderna',
        fechaInici: '1647',
        fechaFi: '1647',
        description:
            'El maig de 1647, el príncep de Condé, heroi francès de Rocroi, va iniciar un nou setge sobre Lleida. La defensa va recaure en el governador Gregorio Brito, que va resistir amb tenacitat els assalts. Davant la impossibilitat de trencar les muralles, Condé es va veure obligat a aixecar el setge al juny, patint una de les poques derrotes de la seva carrera militar.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Setge de Lleida (1707)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1707)png.png',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Moderna',
        fechaInici: '1707',
        fechaFi: '1707',
        description:
            'El setembre de 1707, les tropes borbòniques del duc d\'Orleans van assetjar Lleida. Després d\'un mes d\'intensos bombardejos, els borbònics van assaltar la ciutat el 12 d\'octubre. La victòria borbònica va suposar un càstig sever: la ciutat va ser saquejada, va perdre els seus furs i la seva universitat fou clausurada.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
    ],
    'Edad Contemporánea': [
      POI(
        name: 'Setge de Lleida (1810)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Setge de lleida (1810).png',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Contemporània',
        fechaInici: '1810',
        fechaFi: '1810',
        description:
            'El maig de 1810, durant la Guerra del Francès, les tropes napoleòniques del mariscal Suchet van assetjar Lleida. La guarnició espanyola, liderada pel general Jaime García-Conde, va resistir un violent bombardeig fins que els francesos van aconseguir obrir bretxes a les muralles. La capitulació el 14 de maig va permetre als francesos controlar una plaça estratègica clau.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
      ),
      POI(
        name: 'Batalla de Lleida (1938)',
        location: '41.6191° N, 0.6232° E',
        image: 'assets/images_historical_events/Batalla de Lleida (1938).jpeg',
<<<<<<< HEAD
        lat: 41.6191230,
        lng: 0.6232056,
        range: 1480.59,
        heading: -25.26,
        tilt: 65.45,
        epoca: 'Edat Contemporània',
        fechaInici: '1938',
        fechaFi: '1938',
        description:
            'La Batalla de Lleida, culminada el 3 d\'abril de 1938, va marcar l\'entrada definitiva de les tropes de Franco a Catalunya després de trencar el front d\'Aragó. El general Yagüe va liderar l\'assalt contra una defensa republicana que va resistir ferotgement al nucli urbà sota intensos bombardejos. La caiguda de Lleida va permetre a Franco derogar l\'Estatut d\'Autonomia de Catalunya.',
=======
        lat: 41.6191230, lng: 0.6232056, range: 1480.59, heading: -25.26, tilt: 65.45,
        description: item.description,
>>>>>>> parent of fdca477 (17/06/2026)
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
