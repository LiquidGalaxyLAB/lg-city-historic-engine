import 'package:flutter/material.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/m_superior.dart';
import '../main.dart';
import '../models/poi_model.dart';
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
        location: '41.6065°N, 0.6403°E',
        image: 'assets/images_points_of_interest/sicoris_club.jpg',
        lat: 41.606516,
        lng: 0.640333,
        range: 111,
        heading: 19.0,
        tilt: 47.0,
        era: 'Contemporary Age',
        startDate: '1947',
        endDate: '1948',
        description:
            'Sicoris Club was founded in 1947 by two youth groups and became a cultural, sports, and leisure association. It has stood out in sports such as canoeing (with Olympians like Saül Craviotto and Damián Vindel) and rhythmic gymnastics. The futsal section was created in 1973. Since its beginnings, it has aimed to promote both sports and culture at all levels. In 2003, it renovated its facilities to offer new services such as an indoor swimming pool, fitness room, and games room.',
      ),
      POI(
        name: 'Camp d\'Esports',
        location: '41.6231°N, 0.6138°E',
        image: 'assets/images_points_of_interest/camp_sport.jpg',
        lat: 41.6231,
        lng: 0.6138,
        range: 1000,
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
        location: '41.6084°N, 0.6148°E',
        image:
            'assets/images_points_of_interest/Castell Templer de Gardeny.jpg',
        lat: 41.608434,
        lng: 0.614781,
        range: 191,
        heading: -3.0,
        tilt: 62.0,
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1200',
        description:
            'During the 17th and 18th centuries, the old medieval enclosure was expanded and transformed into a new military fortress. Following the conquest of the city of Lleida in 1149, the Knights Templar received several properties, including Gardeny Hill. The monumental complex of Gardeny is one of the most outstanding examples of Templar architecture built in Catalonia during the second half of the 12th century. The castle played a very important role during the Reapers'
            ' War (1641–1647) and the War of the Spanish Succession (1700–1714).',
      ),
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
        era: 'Contemporary Age',
        startDate: '1945',
        endDate: '1946',
        description:
            'The statue of Indíbil (Atabeles) and Mandoni (Balduin) is a bronze sculptural group located in Agelet i Garriga Square in Lleida, beneath the Pont Arch. The work was originally titled Cry of Independence and was created in plaster by the Barcelona sculptor Medardo Sanmartí in 1884. In 1946, a bronze replica was made, which currently commemorates the Iberian Ilergetes warriors.',
      ),
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
        lat: 41.614631,
        lng: 0.626850,
        range: 279,
        heading: -51.0,
        tilt: 55.0,
        era: 'Contemporary Age',
        startDate: '1150',
        endDate: '1208',
        description:
            'The Palace of La Paeria is the seat of the municipal government of Lleida and is located in the heart of the Commercial Axis. The word "paer" comes from the Latin paciari, meaning "man of peace," and originates from a privilege granted by James I of Aragon in 1264. It is a building with two façades: one in the civil Romanesque style facing Paeria Square, and the other, in Neoclassical style with a neo-medieval renovation from 1929, facing the Segre River.',
      ),
      POI(
        name: 'Governor’s Fountain',
        location: '41.6173°N, 0.6289°E',
        image: 'assets/images_points_of_interest/Governor’s Fountain.jpg',
        lat: 41.617291,
        lng: 0.628925,
        range: 167,
        heading: -48.0,
        tilt: 57.0,
        era: 'Contemporary Age',
        startDate: '1789',
        endDate: '1789',
        description:
            'The Governor’s Fountain is a Neoclassical work in Lleida, protected as a Cultural Asset of Local Interest. The fountain is composed of projecting pilasters framing the structure, topped with an eclectic-style pediment containing the city’s coat of arms. The fountain was gifted to the city by Governor Blondel, from whom it takes its name.',
      ),
      POI(
        name: 'Hospital Fountain',
        location: '41.6126°N, 0.6240°E',
        image: 'assets/images_points_of_interest/Hospital Fountain.jpg',
        lat: 41.612600,
        lng: 0.623997,
        range: 272,
        heading: 38.0,
        tilt: 42.0,
        era: 'Contemporary Age',
        startDate: '1802',
        endDate: '1802',
        description:
            'A public fountain with a monumental treatment, framed by lateral pilasters that support a frieze with triglyphs. It is topped by a Baroque pediment above a cornice that frames a commemorative inscription. It was built at the same time as one of the additions to the Hospital of Santa Maria. Today it stands against the party wall of the Republican Youth clubhouse.',
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
        era: 'Contemporary Age',
        startDate: '1979',
        endDate: '1986',
        description:
            'La Mitjana de Lleida is a wetland area in the lower course of the Ebro River, covering about 100 hectares. It is a municipal park made up of three islands formed by the Balaguer Canal and two branches of the Ebro River. It was declared a zone of natural interest in the Spanish Official State Gazette (BOE) in February 1980 and was included in the 1979 General Urban Development Plan.',
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
        era: 'Modern Age',
        startDate: '1573',
        endDate: '1573',
        description:
            'Made in the 16th century and altered in the 18th century. The sculptural representation of the angel bears the date 1759. The pillar was used until 1707 to post proclamations or edicts from the Paeria and the Diputació del General de Catalunya. It was also used to publicly expose prisoners sentenced by the Royal Court or the Veguer\'s Tribunal.',
      ),
      POI(
        name: 'La Suda of Lleida',
        location: '41.6181°N, 0.6272°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
        lat: 41.6181,
        lng: 0.6272,
        range: 1000,
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1200',
        description:
            'The Suda Castle is located next to the Seu Vella of Lleida. Its existence has been documented since approximately 883. Following the Christian conquest, the Suda Castle took part in several notable historical events. In 1150, the wedding of Count Ramon Berenguer IV and Petronila, daughter of King Ramiro of Aragon, was celebrated there.',
      ),
      POI(
        name: 'Seu Vella',
        location: '41.6183°N, 0.6222°E',
        image: 'assets/images_points_of_interest/La_Seu.jpg',
        panoramaImage: 'assets/3d_points_of_interest/la_seu_vella.png',
        lat: 41.6183,
        lng: 0.6222,
        range: 400,
        heading: -20.0,
        tilt: 55.0,
        era: 'Middle Ages',
        startDate: '1203',
        endDate: '1278',
        description:
            'The Old Cathedral of Lleida, known as the Seu Vella, stands atop Turó de la Seu Vella overlooking the city. Built between 1203 and 1278 in a transitional Romanesque-Gothic style, it was used as a military barracks for over 200 years after the War of the Spanish Succession, which unintentionally preserved much of its original structure. Today it is one of the most emblematic monuments of Catalonia, admired for its cloister, bell tower and panoramic views over Lleida and the Segre valley.',
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
        era: 'Middle Ages',
        startDate: '1149',
        endDate: '1149',
        description:
            'Since 1168, the church has been known as Sant Joan de la Plaça, which already existed in 1149. Between 1553 and 1640, jousts, contests, and courtly festivities were held here. At the end of the 18th century, the magistrate Lluís Blondel had the monumental Fountain of the Mermaids built in the middle of the square.',
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
        era: 'Modern Age',
        startDate: '1190',
        endDate: '1210',
        description:
            'To grind wheat for the Municipal Granary, the Paeria had the Cervià mill, the Casa Gualda mill, and the Vilanova de l\'Horta mill. The latter would later be named Sant Anastasi. In 1995, the Paeria acquired the mill. After restoration works, it opened in 2022 as part of the Water Museum.',
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
        era: 'Middle Ages',
        startDate: '1150',
        endDate: '1391',
        description:
            '500 years ago, the last Jews were expelled from medieval Lleida. It is known that the "Cuirassa" became one of the most important Jewish communities of the former Crown of Aragon, with royal privileges equivalent to other communities and a scholarly tradition that included its own school of medicine. After years of work by archaeologists, historians, and architects, the Jewish presence in the "Cuirassa" can be confirmed through streets, parchment-makers\' workshops, and even the house of a wealthy Jewish notable: the House of the Pogrom.',
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
        location: '41.6193°N, 0.6383°E',
        image: 'assets/images_points_of_interest/La Llotja.jpg',
        lat: 41.619262,
        lng: 0.638298,
        range: 368,
        heading: -25.0,
        tilt: 56.0,
        era: 'Contemporary Age',
        startDate: '2007',
        endDate: '2010',
        description:
            'La Llotja de Lleida is a municipally owned congress hall and theater located in the city of Lleida (Catalonia, Spain). The building occupies the esplanade where the old fruit and vegetable market, popularly known as the farmers\' market, used to be held, in the Pardiñas neighborhood. The project was financed through the construction of two residential towers of 24 and 16 storeys built on the same plot as La Llotja. Construction of the building began in the spring of 2007, and the official inauguration took place on 21 January 2010 with a performance of Giuseppe Verdi\'s Il Trovatore, although it had already opened to the public in December 2009.',
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
        era: 'Contemporary Age',
        startDate: '1982',
        endDate: '1983',
        description:
            'The origins of Europa Square in Lleida are linked to the city\'s modern urban expansion, particularly in the area of the former Bishop\'s Fields and its transformation into a modern public space. The square was designed and built in the 1970s and early 1980s, marking the start of the area\'s urban development. Covering more than 26,000 square meters, the square was designed as a large modern public space with green areas, fountains, play areas, and a large underground car park.',
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
        era: 'Contemporary Age',
        startDate: '1981',
        endDate: '1985',
        description:
            'The Courthouse is the building that today houses the courts of Lleida (Segrià) and is included in the Inventory of Architectural Heritage of Catalonia. It is a building with a linear, horizontal layout tied to the surrounding geography. The building successfully addressed the need to place a telecommunications tower in a way that was respectful of the bell tower of the Seu Vella, which overlooks the city and the entire Pla de Lleida.',
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
        era: 'Contemporary Age',
        startDate: '1925',
        endDate: '1929',
        description:
            'It is a work protected as a local cultural heritage asset, built in 1926. In 2003, with the arrival of the high-speed train, the station was renamed Lleida-Pirineus, and among the changes made was the installation of a large steel-and-glass structure that shelters the platforms from the weather. Lleida-Pirineus station is considered one of the most beautiful in Spain.',
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
                            onTap: () => FloatingMenu.show(context,
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
                        MaterialPageRoute(builder: (_) => LaunchLGPage(poi: poi)),
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
