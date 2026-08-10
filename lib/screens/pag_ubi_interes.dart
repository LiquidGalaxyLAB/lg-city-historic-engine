import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_hero_header.dart';
import '../widgets/themed_poi_card.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
import '../services/poi_localization.dart';
import 'pag_lanza_lg.dart';

class POILocationsPage extends StatefulWidget {
  const POILocationsPage({super.key});

  @override
  State<POILocationsPage> createState() => _POILocationsPageState();
}

class _POILocationsPageState extends State<POILocationsPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<POI>> _data = {
    'SCIENCE / TECHNOLOGY': [
      POI(
        name: 'Science Park',
        location: '41.6051°N, 0.6071°E',
        image: 'assets/images_points_of_interest/parc_cientific.jpg',
        lat: 41.605135,
        lng: 0.607070,
        range: 434,
        heading: -9.0,
        tilt: 51.0,
        era: 'Contemporary Age',
        startDate: '2004',
        endDate: '2009',
        description:
            'The Agri-Food Science and Technology Park of Lleida was inaugurated in 2005 and is the result of collaboration between the City Council of Lleida and the University of Lleida, with the aim of boosting the local economy and improving business competitiveness. Its history is marked by the transformation of a former military complex on Gardeny Hill, which belonged to the Spanish army until the late 1990s. The City Council of Lleida purchased the land to promote an economic development project, and in 2005 the Consortium of the Agri-Food Science and Technology Park of Lleida was established together with the University of Lleida. The park has become a key hub for research and development in the agri-food sector, while also covering other areas such as ICT, health, biotechnology, and audiovisual industries.',
      ),
    ],
    'SPORTS': [
      POI(
        name: 'Sícoris Club',
        location: '41.6066°N, 0.6405°E',
        image: 'assets/images_points_of_interest/sicoris_club.jpg',
        lat: 41.606622,
        lng: 0.640498,
        range: 101,
        heading: 33.0,
        tilt: 53.0,
        era: 'Contemporary Age',
        startDate: '1947',
        endDate: '1948',
        description:
            'Sicoris Club was founded in 1947 by two youth groups and became a cultural, sports, and leisure association. It has stood out in sports such as canoeing (with Olympians like Saül Craviotto and Damián Vindel) and rhythmic gymnastics. The futsal section was created in 1973. Since its beginnings, it has aimed to promote both sports and culture at all levels. In 2003, it renovated its facilities to offer new services such as an indoor swimming pool, fitness room, and games room.',
      ),
      POI(
        name: 'Camp d\'Esports',
        location: '41.6210°N, 0.6143°E',
        image: 'assets/images_points_of_interest/camp_sport.jpg',
        lat: 41.620982,
        lng: 0.614260,
        range: 281,
        heading: -177.0,
        tilt: 62.0,
        era: 'Contemporary Age',
        startDate: '1918',
        endDate: '1919',
        description:
            'Lleida Sports Field was inaugurated on January 1, 1919, and was designed by architect Adolf Florensa. In 1920, the football field received official certification. Throughout its history, it has been home to multiple teams such as Juventud FC and UE Lleida, and it has undergone several renovations, the most significant of which took place between 1993 and 1994 following the team’s promotion to the First Division.',
      ),
    ],
    'HISTORY / HERITAGE': [
      POI(
        name: 'Castell Templer de Gardeny',
        location: '41.6083°N, 0.6149°E',
        image:
            'assets/images_points_of_interest/Castell Templer de Gardeny.jpg',
        lat: 41.608256,
        lng: 0.614865,
        range: 130,
        heading: -12.0,
        tilt: 57.0,
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1200',
        description:
            'During the 17th and 18th centuries, the old medieval enclosure was expanded and transformed into a new military fortress. Following the conquest of the city of Lleida in 1149, the Knights Templar received several properties, including Gardeny Hill. The monumental complex of Gardeny is one of the most outstanding examples of Templar architecture built in Catalonia during the second half of the 12th century. The castle played a very important role during the Reapers'
            ' War (1641–1647) and the War of the Spanish Succession (1700–1714).',
      ),
      POI(
        name: 'Statue of Indíbil and Mandoni',
        location: '41.6152°N, 0.6274°E',
        image:
            'assets/images_points_of_interest/Statue of Indíbil and Mandoni.jpg',
        lat: 41.615162,
        lng: 0.627375,
        range: 44,
        heading: -33.0,
        tilt: 65.0,
        era: 'Contemporary Age',
        startDate: '1945',
        endDate: '1946',
        description:
            'The statue of Indíbil (Atabeles) and Mandoni (Balduin) is a bronze sculptural group located in Agelet i Garriga Square in Lleida, beneath the Pont Arch. The work was originally titled Cry of Independence and was created in plaster by the Barcelona sculptor Medardo Sanmartí in 1884. In 1946, a bronze replica was made, which currently commemorates the Iberian Ilergetes warriors.',
      ),
      POI(
        name: 'Old Hospital of Santa Maria',
        location: '41.6128°N, 0.6236°E',
        image:
            'assets/images_points_of_interest/Old Hospital of Santa Maria.jpg',
        lat: 41.612755,
        lng: 0.623605,
        range: 104,
        heading: 21.0,
        tilt: 59.0,
        era: 'Modern Age',
        startDate: '1454',
        endDate: '1461',
        description:
            'A Gothic-Plateresque style building from the 15th and 16th centuries, whose main façade faces the New Cathedral of Lleida, it housed a hospital for many years. The former healthcare facility is a magnificent construction, notable for its central courtyard, where an impressive stone staircase rises and leads to a gallery of pointed arches. Today, this historic building serves as the headquarters of the Institute of Ilerdenc Studies.',
      ),
      POI(
        name: 'La Paeria',
        location: '41.6146°N, 0.6269°E',
        image: 'assets/images_points_of_interest/La Paeria.jpg',
        lat: 41.614591,
        lng: 0.626919,
        range: 102,
        heading: -40.0,
        tilt: 65.0,
        era: 'Contemporary Age',
        startDate: '1150',
        endDate: '1208',
        description:
            'The Palace of La Paeria is the seat of the municipal government of Lleida and is located in the heart of the Commercial Axis. The word "paer" comes from the Latin paciari, meaning "man of peace," and originates from a privilege granted by James I of Aragon in 1264. It is a building with two façades: one in the civil Romanesque style facing Paeria Square, and the other, in Neoclassical style with a neo-medieval renovation from 1929, facing the Segre River.',
      ),
      POI(
        name: 'Governor’s Fountain',
        location: '41.6173°N, 0.6288°E',
        image: 'assets/images_points_of_interest/Governor’s Fountain.jpg',
        lat: 41.617293,
        lng: 0.628825,
        range: 85,
        heading: -54.0,
        tilt: 50.0,
        era: 'Contemporary Age',
        startDate: '1789',
        endDate: '1789',
        description:
            'The Governor’s Fountain is a Neoclassical work in Lleida, protected as a Cultural Asset of Local Interest. The fountain is composed of projecting pilasters framing the structure, topped with an eclectic-style pediment containing the city’s coat of arms. The fountain was gifted to the city by Governor Blondel, from whom it takes its name.',
      ),
      POI(
        name: 'Hospital Fountain',
        location: '41.6127°N, 0.6240°E',
        image: 'assets/images_points_of_interest/Hospital Fountain.jpg',
        lat: 41.612659,
        lng: 0.623962,
        range: 50,
        heading: 46.0,
        tilt: 57.0,
        era: 'Contemporary Age',
        startDate: '1802',
        endDate: '1802',
        description:
            'A public fountain with a monumental treatment, framed by lateral pilasters that support a frieze with triglyphs. It is topped by a Baroque pediment above a cornice that frames a commemorative inscription. It was built at the same time as one of the additions to the Hospital of Santa Maria. Today it stands against the party wall of the Republican Youth clubhouse.',
      ),
      POI(
        name: 'La Mitjana (natural heritage)',
        location: '41.6264°N, 0.6486°E',
        image:
            'assets/images_points_of_interest/La Mitjana (natural heritage).jpg',
        lat: 41.626418,
        lng: 0.648638,
        range: 1521,
        heading: 120.0,
        tilt: 62.0,
        era: 'Contemporary Age',
        startDate: '1979',
        endDate: '1986',
        description:
            'La Mitjana de Lleida is a wetland area in the lower course of the Ebro River, covering about 100 hectares. It is a municipal park made up of three islands formed by the Balaguer Canal and two branches of the Ebro River. It was declared a zone of natural interest in the Spanish Official State Gazette (BOE) in February 1980 and was included in the 1979 General Urban Development Plan.',
      ),
      POI(
        name: 'General’s Pillar',
        location: '41.6154°N, 0.6271°E',
        image: 'assets/images_points_of_interest/General’s Pillar.png',
        lat: 41.615394,
        lng: 0.627119,
        range: 50,
        heading: -137.0,
        tilt: 37.0,
        era: 'Modern Age',
        startDate: '1573',
        endDate: '1573',
        description:
            'Made in the 16th century and altered in the 18th century. The sculptural representation of the angel bears the date 1759. The pillar was used until 1707 to post proclamations or edicts from the Paeria and the Diputació del General de Catalunya. It was also used to publicly expose prisoners sentenced by the Royal Court or the Veguer\'s Tribunal.',
      ),
      POI(
        name: 'La Suda of Lleida',
        location: '41.6187°N, 0.6256°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
        lat: 41.618660,
        lng: 0.625649,
        range: 297,
        heading: 159.0,
        tilt: 61.0,
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1200',
        description:
            'The Suda Castle is located next to the Seu Vella of Lleida. Its existence has been documented since approximately 883. Following the Christian conquest, the Suda Castle took part in several notable historical events. In 1150, the wedding of Count Ramon Berenguer IV and Petronila, daughter of King Ramiro of Aragon, was celebrated there.',
      ),
      POI(
        name: 'Seu Vella',
        location: '41.6175°N, 0.6269°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
        panoramaImage: 'assets/3d_points_of_interest/la_seu_vella.png',
        lat: 41.617475,
        lng: 0.626900,
        range: 404,
        heading: -40.0,
        tilt: 62.0,
        era: 'Middle Ages',
        startDate: '1203',
        endDate: '1278',
        description:
            'The Old Cathedral of Lleida, known as the Seu Vella, stands atop Turó de la Seu Vella overlooking the city. Built between 1203 and 1278 in a transitional Romanesque-Gothic style, it was used as a military barracks for over 200 years after the War of the Spanish Succession, which unintentionally preserved much of its original structure. Today it is one of the most emblematic monuments of Catalonia, admired for its cloister, bell tower and panoramic views over Lleida and the Segre valley.',
      ),
      POI(
        name: 'Sant Joan Square',
        location: '41.6160°N, 0.6274°E',
        image: 'assets/images_points_of_interest/Sant Joan Square.png',
        lat: 41.616028,
        lng: 0.627358,
        range: 102,
        heading: 7.0,
        tilt: 51.0,
        era: 'Middle Ages',
        startDate: '1149',
        endDate: '1149',
        description:
            'Since 1168, the church has been known as Sant Joan de la Plaça, which already existed in 1149. Between 1553 and 1640, jousts, contests, and courtly festivities were held here. At the end of the 18th century, the magistrate Lluís Blondel had the monumental Fountain of the Mermaids built in the middle of the square.',
      ),
      POI(
        name: 'Sant Anastasi Mill',
        location: '41.6056°N, 0.6401°E',
        image: 'assets/images_points_of_interest/Sant Anastasi Mill.jpg',
        lat: 41.605572,
        lng: 0.640122,
        range: 46,
        heading: 59.0,
        tilt: 50.0,
        era: 'Modern Age',
        startDate: '1190',
        endDate: '1210',
        description:
            'To grind wheat for the Municipal Granary, the Paeria had the Cervià mill, the Casa Gualda mill, and the Vilanova de l\'Horta mill. The latter would later be named Sant Anastasi. In 1995, the Paeria acquired the mill. After restoration works, it opened in 2022 as part of the Water Museum.',
      ),
      POI(
        name: 'La Cuirassa',
        location: '41.6141°N, 0.6251°E',
        image: 'assets/images_points_of_interest/La Cuirassa.jpg',
        lat: 41.614150,
        lng: 0.625100,
        range: 151,
        heading: 2.0,
        tilt: 61.0,
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1391',
        description:
            '500 years ago, the last Jews were expelled from medieval Lleida. It is known that the "Cuirassa" became one of the most important Jewish communities of the former Crown of Aragon, with royal privileges equivalent to other communities and a scholarly tradition that included its own school of medicine. After years of work by archaeologists, historians, and architects, the Jewish presence in the "Cuirassa" can be confirmed through streets, parchment-makers\' workshops, and even the house of a wealthy Jewish notable: the House of the Pogrom.',
      ),
      POI(
        name: 'Tanneries',
        location: '41.6173°N, 0.6295°E',
        image: 'assets/images_points_of_interest/Tanneries.jpg',
        lat: 41.617327,
        lng: 0.629504,
        range: 55,
        heading: -54.0,
        tilt: 39.0,
        era: 'Middle Ages',
        startDate: '1200',
        endDate: '1299',
        description:
            'The Tanneries, located at number 9 Rambla de Ferran, are the oldest in Spain and the best preserved. They consist of two workshops, now restored, that are part of a complex of seven 13th-century tanneries. The two that have been restored still contain the water channels used in the Middle Ages, with the watercourse now reinstated.',
      ),
    ],
    'URBAN / CITY LANDMARKS': [
      POI(
        name: 'La Llotja',
        location: '41.6195°N, 0.6379°E',
        image: 'assets/images_points_of_interest/La Llotja.jpg',
        lat: 41.619525,
        lng: 0.637890,
        range: 243,
        heading: 8.0,
        tilt: 59.0,
        era: 'Contemporary Age',
        startDate: '2007',
        endDate: '2010',
        description:
            'La Llotja de Lleida is a municipally owned congress hall and theater located in the city of Lleida (Catalonia, Spain). The building occupies the esplanade where the old fruit and vegetable market, popularly known as the farmers\' market, used to be held, in the Pardiñas neighborhood. The project was financed through the construction of two residential towers of 24 and 16 storeys built on the same plot as La Llotja. Construction of the building began in the spring of 2007, and the official inauguration took place on 21 January 2010 with a performance of Giuseppe Verdi\'s Il Trovatore, although it had already opened to the public in December 2009.',
      ),
      POI(
        name: 'Europa Square',
        location: '41.6253°N, 0.6227°E',
        image: 'assets/images_points_of_interest/Europa Square.jpeg',
        lat: 41.625288,
        lng: 0.622660,
        range: 200,
        heading: -139.0,
        tilt: 67.0,
        era: 'Contemporary Age',
        startDate: '1982',
        endDate: '1983',
        description:
            'The origins of Europa Square in Lleida are linked to the city\'s modern urban expansion, particularly in the area of the former Bishop\'s Fields and its transformation into a modern public space. The square was designed and built in the 1970s and early 1980s, marking the start of the area\'s urban development. Covering more than 26,000 square meters, the square was designed as a large modern public space with green areas, fountains, play areas, and a large underground car park.',
      ),
      POI(
        name: 'Lleida Courthouse',
        location: '41.6169°N, 0.6269°E',
        image: 'assets/images_points_of_interest/Lleida Courthouse.jpg',
        lat: 41.616915,
        lng: 0.626921,
        range: 135,
        heading: -93.0,
        tilt: 67.0,
        era: 'Contemporary Age',
        startDate: '1981',
        endDate: '1985',
        description:
            'The Courthouse is the building that today houses the courts of Lleida (Segrià) and is included in the Inventory of Architectural Heritage of Catalonia. It is a building with a linear, horizontal layout tied to the surrounding geography. The building successfully addressed the need to place a telecommunications tower in a way that was respectful of the bell tower of the Seu Vella, which overlooks the city and the entire Pla de Lleida.',
      ),
      POI(
        name: 'Lleida–Pirineus Train Station',
        location: '41.6206°N, 0.6329°E',
        image:
            'assets/images_points_of_interest/Lleida–Pirineus Train Station.jpg',
        lat: 41.620629,
        lng: 0.632886,
        range: 166,
        heading: 86.0,
        tilt: 65.0,
        era: 'Contemporary Age',
        startDate: '1925',
        endDate: '1929',
        description:
            'It is a work protected as a local cultural heritage asset, built in 1926. In 2003, with the arrival of the high-speed train, the station was renamed Lleida-Pirineus, and among the changes made was the installation of a large steel-and-glass structure that shelters the platforms from the weather. Lleida-Pirineus station is considered one of the most beautiful in Spain.',
      ),
      POI(
        name: 'Camps Elisis Park',
        location: '41.6138°N, 0.6322°E',
        image: 'assets/images_points_of_interest/Camps Elisis Park lleida.jpg',
        lat: 41.613817,
        lng: 0.632234,
        range: 484,
        heading: 168.0,
        tilt: 58.0,
        era: 'Contemporary Age',
        startDate: '1861',
        endDate: '1864',
        description:
            'Camps Elisis Park is an urban park in the city of Lleida, located in Cappont, divided into garden areas in the French and English Romantic styles, built on former wooded land. The Camps Elisis Park in Lleida was inaugurated in 1864. The Saint Michael\'s Fair, which had been held annually in the city from the 13th to the 19th century, began to be held again from 1954 onward.',
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
        final List<POI> allPois = (_selectedCategory == 'All'
                ? _data.values.expand((x) => x)
                : (_data[_selectedCategory] ?? []))
            .map(PoiLocalization.instance.enrich)
            .toList();

        final List<POI> pois = allPois
            .where((poi) => poi.matchesSearch(_searchQuery, lang))
            .toList();

        return Scaffold(
          backgroundColor: AppTheme.pageBackground(
            context,
            light: const Color(0xFFF8F7F2),
          ),
          body: Column(
            children: [
              SectionHeroHeader(
                imageAsset: 'assets/images_points_of_interest/La_Seu.jpg',
                menuTitle: T.s('poi'),
                title: T.s('poi').toUpperCase(),
                subtitle: T.s('poi_subtitle'),
                filterBar: _buildFilterBar(),
                onMenuTap: () =>
                    FloatingMenu.show(context, currentTitle: T.s('poi')),
                badge: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
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
                                color: context.appOnSurfaceVariant,
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
                            _cardPunto(pois[index], lang),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterBar() {
    return ThemedListFilterBar(
      searchController: _searchController,
      searchHint: T.s('search'),
      searchQuery: _searchQuery,
      onSearchChanged: (value) => setState(() => _searchQuery = value),
      onClearSearch: () {
        _searchController.clear();
        setState(() => _searchQuery = '');
      },
      categoryMenu: CategoryFilterDropdown(
        selectedCategory: _selectedCategory,
        categories: ['All', ..._data.keys],
        onSelected: (value) => setState(() => _selectedCategory = value),
        labelForCategory: (cat) =>
            cat == 'All' ? T.s('show_all') : T.category(cat),
      ),
    );
  }

  Widget _cardPunto(POI poi, String lang) {
    return ThemedPoiCard(
      imageAsset: poi.image,
      title: poi.getName(lang),
      actionLabel: T.s('send_lg'),
      onSend: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LaunchLGPage(poi: poi)),
      ),
    );
  }
}
