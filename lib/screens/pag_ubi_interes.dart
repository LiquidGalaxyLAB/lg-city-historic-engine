import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import 'pag_lanza_lg.dart';

class PagUbicInteres extends StatefulWidget {
  const PagUbicInteres({super.key});

  @override
  State<PagUbicInteres> createState() => _PagUbicInteresState();
}

class _PagUbicInteresState extends State<PagUbicInteres> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'SCIENCE / TECHNOLOGY': [
      POI(
        name: 'Parc Científic',
        location: '41.6051°N, 0.6071°E',
        image: 'assets/images_points_of_interest/parc_cientific.jpg',
        lat: 41.605135,
        lng: 0.607070,
        range: 434,
        heading: -9.0,
        tilt: 51.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '2004',
        fechaFi: '2009',
        description: 'The Agri-Food Science and Technology Park of Lleida was inaugurated in 2005 and is the result of collaboration between the City Council of Lleida and the University of Lleida, with the aim of boosting the local economy and improving business competitiveness. Its history is marked by the transformation of a former military complex on Gardeny Hill, which belonged to the Spanish army until the late 1990s. The City Council of Lleida purchased the land to promote an economic development project, and in 2005 the Consortium of the Agri-Food Science and Technology Park of Lleida was established together with the University of Lleida. The park has become a key hub for research and development in the agri-food sector, while also covering other areas such as ICT, health, biotechnology, and audiovisual industries.',
      ),
    ],
    'SPORTS': [
      POI(
        name: 'Sícoris Club',
        location: '41.6065°N, 0.6403°E',
        image: 'assets/images_points_of_interest/sicoris_club.jpg',
        lat: 41.606516,
        lng: 0.640333,
        range: 111,
        heading: 19.0,
        tilt: 47.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1947',
        fechaFi: '1948',
        description: 'Sicoris Club was founded in 1947 by two youth groups and became a cultural, sports, and leisure association. It has stood out in sports such as canoeing (with Olympians like Saül Craviotto and Damián Vindel) and rhythmic gymnastics. The futsal section was created in 1973. Since its beginnings, it has aimed to promote both sports and culture at all levels. In 2003, it renovated its facilities to offer new services such as an indoor swimming pool, fitness room, and games room.',      ),
      POI(
        name: 'Camp d\'Esports',
        location: '41.6231°N, 0.6138°E',
        image: 'assets/images_points_of_interest/camp_sport.jpg',
        lat: 41.6231,
        lng: 0.6138,
        range: 1000,
        epoca: 'Edad Contemporánea',
        fechaInici: '1918',
        fechaFi: '1919',
        description: 'Lleida Sports Field was inaugurated on January 1, 1919, and was designed by architect Adolf Florensa. In 1920, the football field received official certification. Throughout its history, it has been home to multiple teams such as Juventud FC and UE Lleida, and it has undergone several renovations, the most significant of which took place between 1993 and 1994 following the team’s promotion to the First Division.',      ),
    ],
    'HISTORY / HERITAGE': [
      POI(
        name: 'Castell Templer de Gardeny',
        location: '41.6084°N, 0.6148°E',
        image:
            'assets/images_points_of_interest/Castell Templer de Gardeny.jpg',
        lat: 41.608434,
        lng: 0.614781,
        range: 191,
        heading: -3.0,
        tilt: 62.0,
        epoca: 'Edad Media',
        fechaInici: '1150',
        fechaFi: '1200',
          description: 'During the 17th and 18th centuries, the old medieval enclosure was expanded and transformed into a new military fortress. Following the conquest of the city of Lleida in 1149, the Knights Templar received several properties, including Gardeny Hill. The monumental complex of Gardeny is one of the most outstanding examples of Templar architecture built in Catalonia during the second half of the 12th century. The castle played a very important role during the Reapers' ' War (1641–1647) and the War of the Spanish Succession (1700–1714).',      ),
      POI(
        name: 'Statue of Indíbil and Mandoni',
        location: '41.6150°N, 0.6273°E',
        image:
            'assets/images_points_of_interest/Statue of Indíbil and Mandoni.jpg',
        lat: 41.614953,
        lng: 0.627290,
        range: 168,
        heading: -56.0,
        tilt: 52.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1945',
        fechaFi: '1946',
        description: 'The statue of Indíbil (Atabeles) and Mandoni (Balduin) is a bronze sculptural group located in Agelet i Garriga Square in Lleida, beneath the Pont Arch. The work was originally titled Cry of Independence and was created in plaster by the Barcelona sculptor Medardo Sanmartí in 1884. In 1946, a bronze replica was made, which currently commemorates the Iberian Ilergetes warriors.',      ),
      POI(
        name: 'Old Hospital of Santa Maria',
        location: '41.6126°N, 0.6238°E',
        image:
            'assets/images_points_of_interest/Old Hospital of Santa Maria.jpg',
        lat: 41.612631,
        lng: 0.623788,
        range: 258,
        heading: 14.0,
        tilt: 50.0,
        epoca: 'Edad Moderna',
        fechaInici: '1454',
        fechaFi: '1461',
        description: 'A Gothic-Plateresque style building from the 15th and 16th centuries, whose main façade faces the New Cathedral of Lleida, it housed a hospital for many years. The former healthcare facility is a magnificent construction, notable for its central courtyard, where an impressive stone staircase rises and leads to a gallery of pointed arches. Today, this historic building serves as the headquarters of the Institute of Ilerdenc Studies.',      ),
      POI(
        name: 'La Paeria',
        location: '41.6146°N, 0.6269°E',
        image: 'assets/images_points_of_interest/La Paeria.jpg',
        lat: 41.614631,
        lng: 0.626850,
        range: 279,
        heading: -51.0,
        tilt: 55.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1150',
        fechaFi: '1208',
        description: 'The Palace of La Paeria is the seat of the municipal government of Lleida and is located in the heart of the Commercial Axis. The word "paer" comes from the Latin paciari, meaning "man of peace," and originates from a privilege granted by James I of Aragon in 1264. It is a building with two façades: one in the civil Romanesque style facing Paeria Square, and the other, in Neoclassical style with a neo-medieval renovation from 1929, facing the Segre River.',      ),
      POI(
        name: 'Governor’s Fountain',
        location: '41.6173°N, 0.6289°E',
        image: 'assets/images_points_of_interest/Governor’s Fountain.jpg',
        lat: 41.617291,
        lng: 0.628925,
        range: 167,
        heading: -48.0,
        tilt: 57.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1789',
        fechaFi: '1789',
        description: 'The Governor’s Fountain is a Neoclassical work in Lleida, protected as a Cultural Asset of Local Interest. The fountain is composed of projecting pilasters framing the structure, topped with an eclectic-style pediment containing the city’s coat of arms. The fountain was gifted to the city by Governor Blondel, from whom it takes its name.',      ),
      POI(
        name: 'Hospital Fountain',
        location: '41.6126°N, 0.6240°E',
        image: 'assets/images_points_of_interest/Hospital Fountain.jpg',
        lat: 41.612600,
        lng: 0.623997,
        range: 272,
        heading: 38.0,
        tilt: 42.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1802',
        fechaFi: '1802',
        description: 'Fuente pública con tratamiento monumentalista enmarcada por pilastras laterales y que aguantan un friso con triglifos. Rematado por un frontón barroco encima de un alero que enmarca una inscripción conmemorativa. Fue construida al mismo tiempo que uno de los añadidos en el hospital de Santa Maria. Hoy se encuentra apoyada a la medianera del casal de la Juventud Republicana.',
      ),
      POI(
        name: 'La Mitjana (natural heritage)',
        location: '41.6289°N, 0.6435°E',
        image:
            'assets/images_points_of_interest/La Mitjana (natural heritage).jpg',
        lat: 41.628880,
        lng: 0.643496,
        range: 513,
        heading: 49.0,
        tilt: 44.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1979',
        fechaFi: '1986',
        description: 'La Mediana de Lérida es una zona húmeda del curso bajo del Ebro, de una superficie de unas 100 hectáreas. Es un parque municipal constituido por tres islas formadas por el canal de Balaguer y dos ramales del río Ebro. Declarada al BOE como zona de interés natural en febrero de 1980 e incluida al P.O.Uno. del 1979.',
      ),
      POI(
        name: 'General’s Pillar',
        location: '41.6154°N, 0.6273°E',
        image: 'assets/images_points_of_interest/General’s Pillar.png',
        lat: 41.615434,
        lng: 0.627330,
        range: 262,
        heading: -102.0,
        tilt: 43.0,
        epoca: 'Edad Moderna',
        fechaInici: '1573',
        fechaFi: '1573',
        description: 'Hecho en Siglo XVI Alterado en los siglo XVIII. La representación escultórica del ángel lleva la fecha 1759. Pilastra utilizada hasta 1707 para fijar bandos o edictos de la Paheria y la Diputación del General de Cataluña. También para Exponer a la Vindicta Pública los reos del Tribunal del corte o Vegué Real.',
      ),
      POI(
        name: 'La Suda of Lleida',
        location: '41.6181°N, 0.6272°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
        lat: 41.6181,
        lng: 0.6272,
        range: 1000,
        epoca: 'Edad Media',
        fechaInici: '1150',
        fechaFi: '1200',
        description: 'El castillo de la Suda está situado junto a la sede vieja de Lérida. Su existencia está documentada desde aproximadamente en 883. A partir de la conquista cristiana, el castillo de la Suda fue participe de algunos hechos históricos remarcables. El 1150, se celebró el casamiento entre el conde Ramon Berenguer IV y Peronella, hija del rey Ramiro de Aragón.',
      ),
      POI(
        name: 'Sant Joan Square',
        location: '41.6157°N, 0.6273°E',
        image: 'assets/images_points_of_interest/Sant Joan Square.png',
        lat: 41.615692,
        lng: 0.627325,
        range: 431,
        heading: 78.0,
        tilt: 38.0,
        epoca: 'Edad Media',
        fechaInici: '1149',
        fechaFi: '1149',
        description: 'Desde el 1168, el templo ha sido denominado San Juan de la Plaza, la cual ya existía el 1149. Desde el año 1553 al 1640 se celebraron justas, concursos y fiestas cortesanas. A finales del siglo xviii, el corregidor Lluís Blondel feudo construir, en medio de la plaza, la monumental fuente de las sirenas.',
      ),
      POI(
        name: 'Sant Anastasi Mill',
        location: '41.6054°N, 0.6404°E',
        image: 'assets/images_points_of_interest/Sant Anastasi Mill.jpg',
        lat: 41.605431,
        lng: 0.640435,
        range: 155,
        heading: 0.0,
        tilt: 53.0,
        epoca: 'Edad Moderna',
        fechaInici: '1190',
        fechaFi: '1210',
        description: 'Para poder moler trigo de la Bladeria Municipal, la Paeria disponía del molino de Cervià, el molino de Casa Gualda y el molino de Vilanova de l\'Horta. Este último recibirá el nombre posteriormente de Santo Anastasi. El 1995 la Paeria adquirió el molino. Después de obras de rehabilitación, el 2022 abrió como parte del Museo del Agua.',
      ),
      POI(
        name: 'La Cuirassa',
        location: '41.6142°N, 0.6249°E',
        image: 'assets/images_points_of_interest/La Cuirassa.jpg',
        lat: 41.614227,
        lng: 0.624879,
        range: 294,
        heading: 158.0,
        tilt: 28.0,
        epoca: 'Edad Media',
        fechaInici: '1150',
        fechaFi: '1391',
        description: 'Hace 500 años fueron expulsados los últimos judíos de la Lérida medieval. Siendo conocedores que la "Coraza" llegó a ser una de las comunidades judías más importantes de la antigua Corona de Aragón, con privilegios reales equivalentes y una comunidad científica con escuela de medicina propia. Después de años de trabajo de arqueólogos, historiadores y arquitectos, podemos confirmar la presencia judía en la "Coraza" en forma de calles, talleres de pergamineros e incluso la casa de un rico prohombre judío: la Casa del Pogromo.',
      ),
      POI(
        name: 'Tanneries',
        location: '41.6172°N, 0.6295°E',
        image: 'assets/images_points_of_interest/Tanneries.jpg',
        lat: 41.617193,
        lng: 0.629525,
        range: 180,
        heading: -20.0,
        tilt: 37.0,
        epoca: 'Edad Media',
        fechaInici: '1200',
        fechaFi: '1299',
        description: 'Las Curtiduirías, situadas en el número 9 de la Rambla de Ferran, son las más antiguas de España y las que mejor se han conservado. Se trata de dos obradores, ahora restaurados, que forman parte de un complejo de siete tenerías del siglo XIII. Las dos que se han recuperado contienen aún la canalización que utilizaban en la Edad Media, con el curso del agua restablecido.',
      ),
    ],
    'URBAN / CITY LANDMARKS': [
      POI(
        name: 'La Llotja',
        location: '41.6193°N, 0.6383°E',
        image: 'assets/images_points_of_interest/La Llotja.jpg',
        lat: 41.619262,
        lng: 0.638298,
        range: 368,
        heading: -25.0,
        tilt: 56.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '2007',
        fechaFi: '2010',
        description: 'La Lonja de Lérida es un palacio de congresos y teatro de titularidad municipal ubicado en la ciudad de Lérida (Cataluña, España). El edificio ocupa la explanada donde se celebraba el antiguo mercado de frutas y verduras, conocido popularmente como el mercado de los campesinos, en el barrio de Pardiñas. El proyecto se financiará gracias a la construcción de dos torres de viviendas de 24 y 16 plantas situadas en el mismo terreno que la Lonja. Las obras del palacio se iniciaron en la primavera de 2007 y la inauguración oficial tuvo lugar el 21 de enero de 2010 con la representación de El trovador de Giuseppe Verdi, aunque ya fue estrenada en diciembre del 2009.',
      ),
      POI(
        name: 'Europa Square',
        location: '41.6257°N, 0.6226°E',
        image: 'assets/images_points_of_interest/Europa Square.jpeg',
        lat: 41.625674,
        lng: 0.622631,
        range: 611,
        heading: -136.0,
        tilt: 34.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1982',
        fechaFi: '1983',
        description: 'El origen de la Plaza Europa de Lérida están relacionados con la expansión urbana moderna de la ciudad, particularmente en la zona de los antiguos Campos del Obispo y su transformación en un espacio público moderno. La plaza fue proyectada y construida en la década de 1970 y principios de 1980, marcando el inicio de la urbanización del área. La plaza, con una superficie de más de 26.000 metros cuadrados, fue diseñada como un gran espacio público moderno, con áreas verdes, fuentes, zonas de juegos y un gran aparcamiento subterráneo.',
      ),
      POI(
        name: 'Lleida Courthouse',
        location: '41.6170°N, 0.6279°E',
        image: 'assets/images_points_of_interest/Lleida Courthouse.jpg',
        lat: 41.617003,
        lng: 0.627903,
        range: 564,
        heading: -42.0,
        tilt: 46.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1981',
        fechaFi: '1985',
        description: 'El Palacio de Justicia es el edificio que acoge hoy en día los juzgados de Lérida (Segrià) incluida al Inventario del Patrimonio Arquitectónico de Cataluña. Edificio con un despliegue lineal y horizontal vinculado a la geografía. El edificio es capaz de resolver la necesidad de ubicar una torre de telecomunicaciones que fuera respetuosa con el campanario de la Sede Vieja, que domina la ciudad y todo el Plan de Lérida.',
      ),
      POI(
        name: 'Lleida–Pirineus Train Station',
        location: '41.6204°N, 0.6332°E',
        image:
            'assets/images_points_of_interest/Lleida–Pirineus Train Station.jpg',
        lat: 41.620362,
        lng: 0.633234,
        range: 420,
        heading: 42.0,
        tilt: 44.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1925',
        fechaFi: '1929',
        description: 'Es una obra de protegida como bien cultural de interés local construido el 1926. El 2003 con la llegada del Tren de gran velocidad, la estación pasó a denominarse Lérida Pirineos, y entre las modificaciones que se hizo figura la instalación de una gran estructura de acero y vidrio que protege los andenes de las inclemencias del tiempo. La estación de Lérida Pirineos es considerada una de las más bonitas de España.',
      ),
      POI(
        name: 'Camps Elisis Park',
        location: '41.6140°N, 0.6324°E',
        image: 'assets/images_points_of_interest/Camps Elisis Park lleida.jpg',
        lat: 41.613950,
        lng: 0.632387,
        range: 282,
        heading: 1.0,
        tilt: 46.0,
        epoca: 'Edad Contemporánea',
        fechaInici: '1861',
        fechaFi: '1864',
        description: 'Los Campos Eliseos es un parque urbano de la ciudad de Lérida, situado a Cappont, dividido en áreas de jardines de estilo francés y romántico inglés, construidos en base a terrenos boscosos. El Parque de los Campos Eliseos de Lérida se inauguró el 1864. La Feria de San Miguel que, desde el siglo xiii y hasta el siglo xix, había estado anual en la ciudad, volvió a celebrarse a partir de 1954.',
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
                        image: AssetImage(
                            'assets/images_points_of_interest/La_Seu.jpg'),
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
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => MenuFlotante.mostrar(context,
                                currentTitle: T.s('poi')),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.menu,
                                  color: Colors.white, size: 26),
                            ),
                          ),
                          const AppTopBar(
                              onDarkBackground: true, wifiOnly: true),
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
                          color: Colors.black.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 22),
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
                          T.s('poi').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.8,
                            fontFamily: 'serif',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          T.s('poi_subtitle'),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
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
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            '${pois.length} ${T.s('available')}',
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
                      child: _buildFilterBar()),
                ],
              ),
              const SizedBox(height: 45),
              Expanded(
                child: pois.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off_rounded,
                                size: 80, color: Colors.grey[300]),
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
                            horizontal: 20, vertical: 0),
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
                hintText: T.s('search'),
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
              child: const Icon(Icons.close_rounded,
                  color: Color(0xFF8E8E93), size: 20),
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
                    fontSize: 15,
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
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF1C1C1E), size: 18),
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
                  child: const Icon(Icons.image_not_supported,
                      size: 50, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  poi.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'serif',
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFF2F2F7), thickness: 1.5),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.explore_outlined,
                            size: 16, color: Color(0xFF8E8E93)),
                        const SizedBox(width: 6),
                        Text(
                          T.s('details'),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8E8E93),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PagLanzaLG(poi: poi)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F7).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              T.s('send_lg'),
                              style: const TextStyle(
                                color: Color(0xFF6B5B45),
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 0.6,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded,
                                size: 16, color: Color(0xFF6B5B45)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
