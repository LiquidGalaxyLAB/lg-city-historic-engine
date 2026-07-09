import 'package:sqflite/sqflite.dart';

Future<void> insertData(Database db) async {
  final batch = db.batch();

  // ══════════════════════════════════════════════
  // LOCATIONS OF INTEREST  (21 points)
  // ══════════════════════════════════════════════

  batch.insert('places', {
    'category': 'locations',
    'name': 'Parc científic',
    'latitude': 41.6058553,
    'longitude': 0.6066511,
    'altitude': 197.1975577,
    'heading': 27.0274036,
    'tilt': 63.5251492,
    'range': 410.9234931,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '2004',
    'end_date': '2009',
    'description_ca':
        'El Parc Científic i Tecnològic Agroalimentari de Lleida es va inaugurar en 2005 i és fruit de la col·laboració entre l\'Ajuntament de Lleida i la Universitat de Lleida, amb l\'objectiu de dinamitzar l\'economia local i la competitivitat empresarial. La seva història està marcada per l\'adaptació d\'un antic complex militar en el pujol de Gardeny, que va ser propietat de l\'exèrcit espanyol fins a finals dels 90. L\'Ajuntament de Lleida va comprar els terrenys per a impulsar un projecte de desenvolupament econòmic, i en 2005 es va crear el Consorci del Parc Científic i Tecnològic Agroalimentari de Lleida, juntament amb la Universitat de Lleida. El parc s\'ha convertit en un centre neuràlgic per a la recerca i el desenvolupament en el sector agroalimentari, encara que també abasta altres àrees com les TIC, la salut, la biotecnologia i l\'audiovisual.',
    'description_es':
        'El Parque Científico y Tecnológico Agroalimentario de Lérida se inauguró en 2005 y es fruto de la colaboración entre el Ayuntamiento de Lérida y la Universidad de Lérida, con el objetivo de dinamizar la economía local y la competitividad empresarial. Su historia está marcada por la adaptación de un antiguo complejo militar en la colina de Gardeny, que fue propiedad del ejército español hasta finales de los 90. El Ayuntamiento de Lérida compró los terrenos para impulsar un proyecto de desarrollo económico, y en 2005 se creó el Consorcio del Parque Científico y Tecnológico Agroalimentario de Lérida, junto con la Universidad de Lérida. El parque se ha convertido en un centro neurálgico para la investigación y el desarrollo en el sector agroalimentario, aunque también abarca otras áreas como las TIC, la salud, la biotecnología y el audiovisual.',
    'description_en':
        'The Agri-Food Science and Technology Park of Lleida was inaugurated in 2005 and is the result of collaboration between the Lleida City Council and the University of Lleida, with the aim of boosting the local economy and business competitiveness. Its history is marked by the transformation of a former military complex on the Gardeny hill, which belonged to the Spanish army until the late 1990s. The Lleida City Council purchased the land to promote an economic development project, and in 2005 the Consortium of the Agri-Food Science and Technology Park of Lleida was created together with the University of Lleida. The park has become a key hub for research and development in the agri-food sector, although it also encompasses other fields such as ICT, health, biotechnology, and audiovisual media.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'La llotja',
    'latitude': 41.6196550,
    'longitude': 0.6374808,
    'altitude': 197.1975577,
    'heading': 27.0274036,
    'tilt': 63.5251492,
    'range': 410.9234931,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '2007',
    'end_date': '2010',
    'description_ca':
        'La Llotja de Lleida és un palau de congressos i teatre de titularitat municipal situat a la ciutat de Lleida (Catalunya, Espanya). L\'edifici ocupa l\'esplanada on se celebrava l\'antic mercat de fruites i verdures, conegut popularment com el mercat dels pagesos, en el barri de Pardinyes. El projecte es finançarà gràcies a la construcció de dues torres d\'habitatges de 24 i 16 plantes situades en el mateix terreny que la Llotja. Les obres del palau es van iniciar en la primavera de 2007 i la inauguració oficial va tenir lloc el 21 de gener de 2010 amb la representació del trobador de Giuseppe Verdi, encara que ja va ser estrenada al desembre del 2009.',
    'description_es':
        'La Lonja de Lérida es un palacio de congresos y teatro de titularidad municipal ubicado en la ciudad de Lérida (Cataluña, España). El edificio ocupa la explanada donde se celebraba el antiguo mercado de frutas y verduras, conocido popularmente como el mercado de los campesinos, en el barrio de Pardiñas. El proyecto se financiará gracias a la construcción de dos torres de viviendas de 24 y 16 plantas situadas en el mismo terreno que la Lonja. Las obras del palacio se iniciaron en la primavera de 2007 y la inauguración oficial tuvo lugar el 21 de enero de 2010 con la representación de El trovador de Giuseppe Verdi, aunque ya fue estrenada en diciembre del 2009.',
    'description_en':
        'The Llotja of Lleida is a municipally owned conference and theatre center located in the city of Lleida (Catalonia, Spain). The building stands on the site where the former fruit and vegetable market popularly known as the farmers market used to be held, in the Pardinyes district. The project is financed through the construction of two residential towers of 24 and 16 floors located on the same grounds as the Llotja. Construction of the complex began in the spring of 2007, and the official inauguration took place on January 21, 2010, with a performance of Il trovatore by Giuseppe Verdi, although it had already opened in December 2009.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Plaça Europa',
    'latitude': 41.6253613,
    'longitude': 0.6233193,
    'altitude': 169.3374275,
    'heading': 95.9608878,
    'tilt': 61.1240806,
    'range': 189.5968420,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1982',
    'end_date': '1983',
    'description_ca':
        'L\'origen de la Plaça Europa de Lleida estan relacionats amb l\'expansió urbana moderna de la ciutat, particularment en la zona dels antics Camps del Bisbe i la seva transformació en un espai públic modern. La plaça va ser projectada i construïda en la dècada de 1970 i principis de 1980, marcant l\'inici de la urbanització de l\'àrea i la consolidació del sector oest de la ciutat. La plaça, amb una superfície de més de 26.000 metres quadrats, va ser dissenyada com un gran espai públic modern, amb àrees verdes, fonts, zones de jocs i un gran aparcament subterrani.',
    'description_es':
        'El origen de la Plaza Europa de Lérida están relacionados con la expansión urbana moderna de la ciudad, particularmente en la zona de los antiguos Campos del Obispo y su transformación en un espacio público moderno. La plaza fue proyectada y construida en la década de 1970 y principios de 1980, marcando el inicio de la urbanización del área. La plaza, con una superficie de más de 26.000 metros cuadrados, fue diseñada como un gran espacio público moderno, con áreas verdes, fuentes, zonas de juegos y un gran aparcamiento subterráneo.',
    'description_en':
        'The origins of Lleida\'s Plaça Europa are linked to the city\'s modern urban expansion, particularly in the area of the former Bishop\'s Fields and their transformation into a contemporary public space. The square was planned and built during the 1970s and early 1980s. Covering more than 26,000 square meters, the square was designed as a large modern public space featuring green areas, fountains, playgrounds, and a large underground car park.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Sícoris Club',
    'latitude': 41.6066748,
    'longitude': 0.6400330,
    'altitude': 160.3463270,
    'heading': 39.2877468,
    'tilt': 53.6212381,
    'range': 227.4502655,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1947',
    'end_date': '1948',
    'description_ca':
        'El Sicoris Club es va fundar en 1947 per dos grups juvenils i es va convertir en una associació cultural, esportiva i d\'oci. Ha destacat en esports com a piragüisme (amb olímpics com Saül Craviotto i Damián Vindel) i gimnàstica rítmica. La secció de futbol sala es va crear en 1973. Des dels seus inicis, ha buscat potenciar tant l\'esport com la cultura a tots els nivells. En 2003 va renovar les seves instal·lacions per a oferir nous serveis com una piscina coberta, sala de fitnes i sala de jocs.',
    'description_es':
        'El Sicoris Club se fundó en 1947 por dos grupos juveniles y se convirtió en una asociación cultural, deportiva y de ocio. Ha destacado en deportes como piragüismo (con olímpicos como Saül Craviotto y Damián Vindel) y gimnasia rítmica. La sección de fútbol sala se creó en 1973. Desde sus inicios, ha buscado potenciar tanto el deporte como la cultura a todos los niveles. En 2003 renovó sus instalaciones para ofrecer nuevos servicios como una piscina cubierta, sala de fitness y sala de juegos.',
    'description_en':
        'The Sicoris Club was founded in 1947 by two youth groups and became a cultural, sports, and leisure association. It has stood out in sports such as canoeing (with Olympians like Saül Craviotto and Damián Vindel) and rhythmic gymnastics. The futsal section was created in 1973. In 2003, it renovated its facilities to offer new services such as an indoor swimming pool, a fitness room, and a games room.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Camp d\'Esports',
    'latitude': 41.6214824,
    'longitude': 0.6132146,
    'altitude': 170.4631225,
    'heading': 75.5290955,
    'tilt': 48.4307233,
    'range': 262.4059792,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1918',
    'end_date': '1919',
    'description_ca':
        'El Camp d\'Esports de Lleida es va inaugurar l\'1 de gener de 1919, dissenyat per l\'arquitecte Adolfo Florensa. En 1920 va arribar l\'homologació per al camp de futbol. Al llarg de la seva història, ha estat llar de múltiples equips com el Joventut FC i la UE Lleida, i ha estat escenari de diverses reformes, la més important de les quals va tenir lloc entre 1993 i 1994 després de l\'ascens de l\'equip a Primera Divisió.',
    'description_es':
        'El Campo de Deportes de Lérida se inauguró el 1 de enero de 1919, diseñado por el arquitecto Adolfo Florensa. En 1920 llegó la homologación para el campo de fútbol. A lo largo de su historia, ha sido hogar de múltiples equipos como el Juventud FC y la UE Lérida, y ha sido escenario de diversas reformas, la más importante de las cuales tuvo lugar entre 1993 y 1994 tras el ascenso del equipo a Primera División.',
    'description_en':
        'The Lleida Sports Ground was inaugurated on January 1, 1919, and was designed by the architect Adolfo Florensa. In 1920, the football pitch received official approval. Throughout its history, it has been home to several teams, such as Juventud FC and UE Lleida, and it has undergone various renovations, the most significant of which took place between 1993 and 1994 following the team\'s promotion to the First Division.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Jutjats de Lleida',
    'latitude': 41.6166754,
    'longitude': 0.6269177,
    'altitude': 174.2132588,
    'heading': 19.9997553,
    'tilt': 70.0808680,
    'range': 250.6403576,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1981',
    'end_date': '1985',
    'description_ca':
        'El Palau de Justícia és l\'edifici que acull avui dia els jutjats de Lleida (Segrià) inclosa a l\'Inventari del Patrimoni Arquitectònic de Catalunya. Edifici amb un desplegament lineal i horitzontal vinculat a la geografia. L\'edifici és capaç de resoldre la necessitat d\'ubicar una torre de telecomunicacions que fos respectuosa amb el campanar de la Seu Vella, que domina la ciutat i tot el Pla de Lleida.',
    'description_es':
        'El Palacio de Justicia es el edificio que acoge hoy en día los juzgados de Lérida (Segrià) incluida al Inventario del Patrimonio Arquitectónico de Cataluña. Edificio con un despliegue lineal y horizontal vinculado a la geografía. El edificio es capaz de resolver la necesidad de ubicar una torre de telecomunicaciones que fuera respetuosa con el campanario de la Sede Vieja, que domina la ciudad y todo el Plan de Lérida.',
    'description_en':
        'The Palace of Justice is the building that currently houses the courts of Lleida (Segrià) and is included in the Architectural Heritage Inventory of Catalonia. It is a building with a linear, horizontal layout that relates more to the surrounding geography than to the urban fabric. The building also manages to accommodate the need for a telecommunications tower designed to be respectful of the bell tower of the Old Cathedral.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Estació de Lleida Pirineus',
    'latitude': 41.6205690,
    'longitude': 0.6326880,
    'altitude': 150.1240322,
    'heading': 27.9441881,
    'tilt': 61.0113774,
    'range': 187.8697053,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1925',
    'end_date': '1929',
    'description_ca':
        'És una obra de protegida com a bé cultural d\'interès local construït el 1926. El 2003 amb l\'arribada del Tren de gran velocitat, l\'estació va passar a anomenar-se Lleida Pirineus, i entre les modificacions que hom va fer figura la instal·lació d\'una gran estructura d\'acer i vidre que protegeix les andanes de les inclemències del temps. L\'estació de Lleida Pirineus és considerada una de les més boniques d\'Espanya.',
    'description_es':
        'Es una obra de protegida como bien cultural de interés local construido el 1926. El 2003 con la llegada del Tren de gran velocidad, la estación pasó a denominarse Lérida Pirineos, y entre las modificaciones que se hizo figura la instalación de una gran estructura de acero y vidrio que protege los andenes de las inclemencias del tiempo. La estación de Lérida Pirineos es considerada una de las más bonitas de España.',
    'description_en':
        'It is a structure protected as a local cultural heritage site, built in 1926. In 2003, with the arrival of the high-speed train, the station was renamed Lleida Pirineus, and among the modifications carried out was the installation of a large steel-and-glass structure that shelters the platforms from the weather. Lleida Pirineus Station is considered one of the most beautiful in Spain.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Castell templer de Gardeny',
    'latitude': 41.6086541,
    'longitude': 0.6145339,
    'altitude': 197.1140743,
    'heading': 116.7448884,
    'tilt': 47.5857391,
    'range': 229.2478274,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1150',
    'end_date': '1200',
    'description_ca':
        'Durant els segles XVII i XVIII, l\'antic recinte medieval va ser ampliat i transformat en un nou fortí militar. Amb la conquesta de la ciutat de Lleida, l\'any 1149, els templers van rebre diversos béns, entre els quals s\'incloïa el pujol de Gardeny. El conjunt monumental de Gardeny constitueix un dels testimoniatges més destacats de l\'arquitectura Templera aixecada a Catalunya durant la segona meitat del segle XII. El castell va tenir un paper molt important durant la Guerra dels Segadors (1641-1647) i la Guerra de Successió (1700-1714).',
    'description_es':
        'Durante los siglos XVII y XVIII, el antiguo recinto medieval fue ampliado y transformado en un nuevo fortín militar. Con la conquista de la ciudad de Lérida, en 1149, los templarios recibieron varios bienes, entre los cuales se incluía la colina de Gardeny. El conjunto monumental de Gardeny constituye uno de los testimonios más destacados de la arquitectura Templaria levantada en Cataluña durante la segunda mitad del siglo XII. El castillo tuvo un papel muy importante durante la Guerra de los Segadores (1641-1647) y la Guerra de Sucesión (1700-1714).',
    'description_en':
        'During the 17th and 18th centuries, the former medieval enclosure was expanded and transformed into a new military fort. With the conquest of the city of Lleida in 1149, the Templars received several properties including the hill of Gardeny. The monumental complex of Gardeny is one of the most notable examples of Templar architecture built in Catalonia during the second half of the 12th century. The castle played a very important role during the Reapers\' War (1641–1647) and the War of the Spanish Succession (1700–1714).',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Estatua d\'indibil i mandoni',
    'latitude': 41.6151436,
    'longitude': 0.6274045,
    'altitude': 149.2216539,
    'heading': -48.7595857,
    'tilt': 43.1105486,
    'range': 80.3517364,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1945',
    'end_date': '1946',
    'description_ca':
        'L\'estàtua de Indíbil (Atabeles) i Mandolio (Balduin) és un grup escultòric de bronze que està situat a la plaça Agelet i Garriga de Lleida, sota l\'Arc del Pont. Originalment, l\'obra és titulava Crit d\'independència i la va elaborar en escaiola l\'escultor barceloní Medardo Sanmartí en 1884. L\'any 1946 és va realitzar la rèplica en bronze que actualment recorda als guerrers ibers ilergetes.',
    'description_es':
        'La estatua de Indíbil (Atabeles) y Mandolio (Balduin) es un grupo escultórico de bronce que está situado en la plaza Agelet y Garriga de Lérida, bajo el Arco del Pont. Originalmente, la obra es titulaba Grito de independencia y la elaboró en escayola el escultor barcelonés Medardo Sanmartí en 1884. El año 1946 es realizó la réplica en bronce que actualmente recuerda a los guerreros íberos ilergetes.',
    'description_en':
        'The statue of Indíbil (Atabeles) and Mandonius (Balduin) is a bronze sculptural group located in Lleida\'s Agelet i Garriga Square. Originally titled Cry of Independence, the work was created in plaster in 1884 by the Barcelona sculptor Medardo Sanmartí. In 1946, the bronze replica was produced, which today commemorates the Ilergetan Iberian warriors.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Antic Hospital de Santa Maria',
    'latitude': 41.6125456,
    'longitude': 0.6235025,
    'altitude': 162.4503718,
    'heading': 24.7131699,
    'tilt': 49.7907544,
    'range': 149.4712257,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1454',
    'end_date': '1461',
    'description_ca':
        'Edifici d\'estil gòtic-plateresc dels segles XV i XVI, la façana principal dels quals se situa enfront de la Catedral Nova, que va albergar durant molts anys un hospital. L\'antic establiment sanitari és una magnífica construcció de la qual destaca el seu pati central on neix una magnífica escalinata de pedra que condueix a una galeria d\'arcs ogivals. Actualment, aquest històric edifici és la seu de l\'Institut d\'Estudis Ilerdencs.',
    'description_es':
        'Edificio de estilo gótico-plateresco de los siglos XV y XVI, la fachada principal de los cuales se sitúa frente a la Catedral Nueva, que albergó durante muchos años un hospital. El antiguo establecimiento sanitario es una magnífica construcción de la cual destaca su patio central donde nace una magnífica escalinata de piedra que conduce a una galería de arcos ojivales. Actualmente, este histórico edificio es la sede del Instituto de Estudios Ilerdenses.',
    'description_en':
        'This Gothic-Plateresque building from the 15th and 16th centuries, whose main façade faces the New Cathedral, housed a hospital for many years. The former healthcare facility is a magnificent structure, notable for its central courtyard, from which a splendid stone staircase rises and leads to a gallery of pointed arches. Today, this historic building is the headquarters of the Institute of Ilerdian Studies.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'La Paeria',
    'latitude': 41.6145088,
    'longitude': 0.6268330,
    'altitude': 165.2429456,
    'heading': -52.1440590,
    'tilt': 48.5435980,
    'range': 127.8903776,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1150',
    'end_date': '1208',
    'description_ca':
        'El Palau de la Paeria és la seu del govern municipal de la ciutat i se situa en ple Eix Comercial. La paraula "paer" prové del llatí "paciari" que significa home de pau i té el seu origen en el privilegi atorgat pel rei Jaume I en 1264. És un edifici de doble façana: la d\'estil romànic civil dona a la Plaça Paeria, i l\'altra, d\'estil neoclàssic i remodelació neomedieval de 1929, al riu Segre.',
    'description_es':
        'El Palacio de la Paeria es la sede del gobierno municipal de la ciudad y se sitúa en pleno Eje Comercial. La palabra "paer" proviene del latín "paciari" que significa hombre de paz y tiene su origen en el privilegio otorgado por el rey Jaime I en 1264. Es un edificio de doble fachada: la de estilo románico civil en la Plaza Paeria, y la otra, de estilo neoclásico y remodelación neomedieval de 1929, en el río Segre.',
    'description_en':
        'The Palace of La Paeria is the seat of the municipal government of the city. The word paer comes from the Latin paciari, meaning man of peace, and originates from a privilege granted by King James I in 1264. It is a building with two façades: one in civil Romanesque style facing Paeria Square, and the other in Neoclassical style with a Neo-medieval renovation from 1929, facing the River Segre.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Els Camps Elisis',
    'latitude': 41.6139930,
    'longitude': 0.6315838,
    'altitude': 158.9392613,
    'heading': -77.1222984,
    'tilt': 59.0098285,
    'range': 339.7257321,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1861',
    'end_date': '1864',
    'description_ca':
        'Els Camps Elisis és un parc urbà de la ciutat de Lleida, situat a Cappont, dividit en àrees de jardins d\'estil francès i romàntic anglès, construïts sobre la base de terrenys boscosos. El Parc dels Camps Elisis de Lleida es va inaugurar el 1864. La Fira de Sant Miquel que, des del segle xiii i fins al segle xix, havia estat anual a la ciutat, tornà a celebrar-s\'hi a partir de 1954.',
    'description_es':
        'Los Campos Eliseos es un parque urbano de la ciudad de Lérida, situado a Cappont, dividido en áreas de jardines de estilo francés y romántico inglés, construidos en base a terrenos boscosos. El Parque de los Campos Eliseos de Lérida se inauguró el 1864. La Feria de San Miguel que, desde el siglo xiii y hasta el siglo xix, había estado anual en la ciudad, volvió a celebrarse a partir de 1954.',
    'description_en':
        'The Champs Elysées is an urban park in the city of Lleida, located in Cappont, divided into areas of French-style gardens and English Romantic gardens, created on former woodland terrain. The Champs Elysées Park of Lleida was inaugurated in 1864. The Saint Michael\'s Fair, which had been held annually in the city from the 13th to the 19th century, resumed in 1954.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Font del Governador',
    'latitude': 41.6172445,
    'longitude': 0.6289151,
    'altitude': 150.5636524,
    'heading': -54.0918983,
    'tilt': 57.1838627,
    'range': 66.2560997,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1789',
    'end_date': '1789',
    'description_ca':
        'La Font del Governador és una obra neoclàssica de Lleida protegida com a Bé Cultural d\'Interès Local. La font es compon de sengles pilastres avançades que emmarquen el conjunt, rematat superiorment amb un frontó d\'estil eclèctic que conté un escut de la ciutat. La font fou donada a la ciutat pel governador Blondel, d\'aquí el seu nom.',
    'description_es':
        'La Fuente del Gobernador es una obra neoclásica de Lérida protegida como Bien Cultural de Interés Local. La fuente se compone de sendas pilastras avanzadas que enmarcan el conjunto, rematado superiormente con un frontón de estilo ecléctico que contiene un escudo de la ciudad. La fuente fue dada en la ciudad por el gobernador Blondel, de aquí su nombre.',
    'description_en':
        'The Governor\'s Fountain is a Neoclassical work in Lleida, protected as a Local Cultural Heritage Site. The fountain consists of two projecting pilasters that frame the structure, topped by an eclectic-style pediment containing the city\'s coat of arms. The fountain was donated to the city by Governor Blondel, from whom it takes its name.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Font de l\'Hospital',
    'latitude': 41.6127049,
    'longitude': 0.6239804,
    'altitude': 151.3339295,
    'heading': 36.7265240,
    'tilt': 40.8225176,
    'range': 143.6571018,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1802',
    'end_date': '1802',
    'description_ca':
        'Font pública amb tractament monumentalista emmarcada per pilastres laterals i que aguanten un fris amb tríglifs. Rematat per un frontó barroc damunt d\'un ràfec que emmarca una inscripció commemorativa. Fou construïda al mateix temps que un dels afegits a l\'hospital de Santa Maria. Avui es troba recolzada a la mitgera del casal de la Joventut Republicana.',
    'description_es':
        'Fuente pública con tratamiento monumentalista enmarcada por pilastras laterales y que aguantan un friso con triglifos. Rematado por un frontón barroco encima de un alero que enmarca una inscripción conmemorativa. Fue construida al mismo tiempo que uno de los añadidos en el hospital de Santa Maria. Hoy se encuentra apoyada a la medianera del casal de la Juventud Republicana.',
    'description_en':
        'This public fountain, designed with a monumental character, is framed by lateral pilasters that support a frieze with triglyphs. It is topped by a Baroque pediment above a cornice that encloses a commemorative inscription. It was constructed at the same time as one of the additions to the Hospital of Santa Maria.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Mitjana de Lleida',
    'latitude': 41.6303731,
    'longitude': 0.6453413,
    'altitude': 150.8819445,
    'heading': 61.8580811,
    'tilt': 44.3752264,
    'range': 240.5077370,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1979',
    'end_date': '1986',
    'description_ca':
        'La Mitjana de Lleida és una zona humida del curs baix del Segre, d\'una superfície d\'unes 100 hectàrees. És un parc municipal constituït per tres illes formades pel canal de Balaguer i dos ramals del riu Segre. Declarada al BOE com a zona d\'interès natural al febrer de 1980 i inclosa al P.O.U. del 1979.',
    'description_es':
        'La Mediana de Lérida es una zona húmeda del curso bajo del Ebro, de una superficie de unas 100 hectáreas. Es un parque municipal constituido por tres islas formadas por el canal de Balaguer y dos ramales del río Ebro. Declarada al BOE como zona de interés natural en febrero de 1980 e incluida al P.O.Uno. del 1979.',
    'description_en':
        'The Mediana of Lleida is a wetland area in the lower course of the Ebro River, covering approximately 100 hectares. It is a municipal park made up of three islands formed by the Balaguer canal and two branches of the Ebro River. It was declared a natural area of interest in the Official State Gazette in February 1980.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Pilar del General',
    'latitude': 41.6152990,
    'longitude': 0.6270352,
    'altitude': 160.6338879,
    'heading': -127.0196001,
    'tilt': 40.8187734,
    'range': 133.1353292,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1573',
    'end_date': '1573',
    'description_ca':
        'Fet en Segle XVI Alterat en els segle XVIII. La representació escultòrica de l\'àngel porta la data 1759. Pilastra utilitzada fins a 1707 per a fixar bàndols o edictes de la Paheria i la Diputació del General de Catalunya. També per a Exposar a la Vindicta Pública els reus del Tribunal del cort o Vegué Real.',
    'description_es':
        'Hecho en Siglo XVI Alterado en los siglo XVIII. La representación escultórica del ángel lleva la fecha 1759. Pilastra utilizada hasta 1707 para fijar bandos o edictos de la Paheria y la Diputación del General de Cataluña. También para Exponer a la Vindicta Pública los reos del Tribunal del corte o Vegué Real.',
    'description_en':
        'Made in the 16th century and altered in the 18th century. The sculptural representation of the angel bears the date 1759. This pilaster was used until 1707 to post proclamations or edicts issued by the Paeria and the Diputació del General de Catalunya.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Suda de Lleida',
    'latitude': 41.6184337,
    'longitude': 0.6259249,
    'altitude': 238.5370090,
    'heading': 10.2599050,
    'tilt': 61.0594072,
    'range': 231.2631660,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1150',
    'end_date': '1200',
    'description_ca':
        'El castell de la Suda està situat al costat de la seu vella de Lleida. La seva existència està documentada des d\'aproximadament l\'any 883. A partir de la conquesta cristiana, el castell de la Suda va ser seu d\'alguns fets històrics remarcables. El 1150, s\'hi va celebrar el casament entre el comte Ramon Berenguer IV i Peronella, filla del rei Ramir d\'Aragó.',
    'description_es':
        'El castillo de la Suda está situado junto a la sede vieja de Lérida. Su existencia está documentada desde aproximadamente en 883. A partir de la conquista cristiana, el castillo de la Suda fue participe de algunos hechos históricos remarcables. El 1150, se celebró el casamiento entre el conde Ramon Berenguer IV y Peronella, hija del rey Ramiro de Aragón.',
    'description_en':
        'The Castle of La Suda is located next to the Old Cathedral of Lleida. Its existence is documented from around the year 883. After the Christian conquest, the Castle of La Suda became the setting for several remarkable historical events. In 1150, the marriage between Count Ramon Berenguer IV and Peronella, daughter of King Ramiro of Aragon, was celebrated here.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Plaça de Sant Joan',
    'latitude': 41.6161143,
    'longitude': 0.6274734,
    'altitude': 150.5643311,
    'heading': 29.5600771,
    'tilt': 50.7230030,
    'range': 185.0195443,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1149',
    'end_date': '1149',
    'description_ca':
        'Des del 1168, el temple ha estat anomenat Sant Joan de la Plaça, la qual ja existia el 1149. Des de l\'any 1553 al 1640 s\'hi celebraren justes, concursos i festes cortesanes. A les darreries del segle xviii, el corregidor Lluís Blondel feu construir, enmig de la plaça, la monumental font de les sirenes.',
    'description_es':
        'Desde el 1168, el templo ha sido denominado San Juan de la Plaza, la cual ya existía el 1149. Desde el año 1553 al 1640 se celebraron justas, concursos y fiestas cortesanas. A finales del siglo xviii, el corregidor Lluís Blondel feudo construir, en medio de la plaza, la monumental fuente de las sirenas.',
    'description_en':
        'Since 1168, the temple has been known as Saint John of the Square, which already existed in 1149. From 1553 to 1640, jousts, competitions, and courtly festivities were held there. At the end of the 18th century, the magistrate Lluís Blondel had the monumental Fountain of the Mermaids built in the middle of the square.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Molí de Sant Anastasi',
    'latitude': 41.6056352,
    'longitude': 0.6401909,
    'altitude': 152.9115002,
    'heading': 145.4432622,
    'tilt': 42.4346390,
    'range': 97.6353592,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1190',
    'end_date': '1210',
    'description_ca':
        'Per tal de poder moldre blat de la Bladeria Municipal, la Paeria disposava del molí de Cervià, el molí de Casa Gualda i el molí de Vilanova de l\'Horta. Aquest darrer rebrà el nom posteriorment de Sant Anastasi. El 1995 la Paeria va adquirir el molí. Després d\'obres de rehabilitació, el 2022 va obrir com a part del Museu de l\'Aigua.',
    'description_es':
        'Para poder moler trigo de la Bladeria Municipal, la Paeria disponía del molino de Cervià, el molino de Casa Gualda y el molino de Vilanova de l\'Horta. Este último recibirá el nombre posteriormente de Santo Anastasi. El 1995 la Paeria adquirió el molino. Después de obras de rehabilitación, el 2022 abrió como parte del Museo del Agua.',
    'description_en':
        'To grind wheat for the Municipal Bladery, the Paeria made use of the Cervià mill, the Casa Gualda mill, and the Vilanova de l\'Horta mill. The latter would later receive the name of Saint Anastasi. In 1995, the Paeria acquired the mill. After restoration works, the mill opened in 2022 as part of the Water Museum.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'La Cuirassa',
    'latitude': 41.6140031,
    'longitude': 0.6247865,
    'altitude': 166.2366509,
    'heading': -8.7148654,
    'tilt': 49.2163522,
    'range': 137.4751261,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1150',
    'end_date': '1391',
    'description_ca':
        'Fa 500 anys van ser expulsats els últims jueus de la Lleida medieval. Sent coneixedors que la "Cuirassa" va arribar a ser una de les comunitats jueves més importants de l\'antiga Corona d\'Aragó, amb privilegis reals equivalents i una comunitat científica amb escola de medicina pròpia. Després d\'anys de treball d\'arqueòlegs, historiadors i arquitectes, podem confirmar la presència jueva en la "Cuirassa" en forma de carrers, tallers de pergamineros i fins i tot la casa d\'un ric prohom jueu: la Casa del Pogrom.',
    'description_es':
        'Hace 500 años fueron expulsados los últimos judíos de la Lérida medieval. Siendo conocedores que la "Coraza" llegó a ser una de las comunidades judías más importantes de la antigua Corona de Aragón, con privilegios reales equivalentes y una comunidad científica con escuela de medicina propia. Después de años de trabajo de arqueólogos, historiadores y arquitectos, podemos confirmar la presencia judía en la "Coraza" en forma de calles, talleres de pergamineros e incluso la casa de un rico prohombre judío: la Casa del Pogromo.',
    'description_en':
        'Five hundred years ago, the last Jews of medieval Lleida were expelled. Although it is known that "La Coraza" became one of the most important Jewish communities in the former Crown of Aragon with royal privileges of equal standing and a scientific community that even had its own medical school. After years of work by archaeologists, historians, and architects, we can now confirm the Jewish presence in "La Coraza" through its streets, parchment-makers\' workshops, and even the house of a wealthy Jewish notable: the House of the Pogrom.',
  });

  batch.insert('places', {
    'category': 'locations',
    'name': 'Curtidurías',
    'latitude': 41.6173278,
    'longitude': 0.6295150,
    'altitude': 161.8655578,
    'heading': -49.6189215,
    'tilt': 49.5715999,
    'range': 164.7589385,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1200',
    'end_date': '1299',
    'description_ca':
        'Les Curtiduirías, situades en el número 9 de la Rambla de Ferran, són les més antigues d\'Espanya i les que millor s\'han conservat. Es tracta de dos obradors, ara restaurats, que formen part d\'un complex de set tenerías del segle XIII. Les dues que s\'han recuperat contenen encara la canalització que utilitzaven en l\'Edat mitjana, amb el curs de l\'aigua restablert.',
    'description_es':
        'Las Curtiduirías, situadas en el número 9 de la Rambla de Ferran, son las más antiguas de España y las que mejor se han conservado. Se trata de dos obradores, ahora restaurados, que forman parte de un complejo de siete tenerías del siglo XIII. Las dos que se han recuperado contienen aún la canalización que utilizaban en la Edad Media, con el curso del agua restablecido.',
    'description_en':
        'The Tanneries, located at number 9 Rambla de Ferran, are the oldest in Spain and the best preserved. They consist of two workshops, now restored, which form part of a complex of seven 13th-century tanneries. The two that have been recovered still contain the original water-channeling system used in the Middle Ages, with the water flow restored.',
  });

  // ══════════════════════════════════════════════
  // CATHEDRALS AND CHURCHES  (11 points)
  // ══════════════════════════════════════════════

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Seu Vella',
    'latitude': 41.6169416,
    'longitude': 0.6289073,
    'altitude': 190.2156989,
    'heading': -57.5445198,
    'tilt': 57.7577757,
    'range': 517.6548084,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1203',
    'end_date': '1431',
    'description_ca':
        'La Seu Vella de Lleida és la catedral més emblemàtica de la ciutat. Construïda en estil romànic amb voltes gòtiques, s\'alça al Turó de la Seu Vella, dominant Lleida i el Segrià. El claustre, amb vistes a la ciutat, es va construir entre els segles XIII i XIV. Al segle XV s\'hi afegiren el campanar i la porta dels Apòstols. El 1707, per la seva posició estratègica, l\'edifici es convertí en caserna militar.',
    'description_es':
        'La Seo Vieja de Lérida es el monumento más emblemático de la ciudad. Construida en estilo románico con bóvedas góticas, se alza en la colina de la seo Vieja, que domina Lérida y el Segriá. El claustro, con vistas a la ciudad, se construyó entre los siglos XIII y XIV. En el XV se añadieron el campanario y la puerta de los Apóstoles. En 1707, por su posición estratégica, el edificio pasó a ser cuartel militar.',
    'description_en':
        'The Old Cathedral of Lleida is the city\'s most iconic monument. Built in the Romanesque style with Gothic ribbed vaults, it stands on the Hill of the Old Cathedral, overlooking Lleida and the Segrià region. The cloister, offering views over the city, was built between the 13th and 14th centuries. In the 15th century, the bell tower and the Apostles\' Gate were added. In 1707, due to its strategic location, the cathedral became a military barracks.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Catedral Nova de Lleida',
    'latitude': 41.6128689,
    'longitude': 0.6232269,
    'altitude': 161.3370021,
    'heading': -27.3508037,
    'tilt': 61.1700882,
    'range': 246.8250003,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1761',
    'end_date': '1781',
    'description_ca':
        'Entre 1761 i 1781, va tenir lloc la construcció de la Catedral Nova gràcies a les aportacions dels lleidatans, del rei Carles III i el bisbe Joaquim Sánchez. D\'estil barroc amb gran tendència al classicisme academicista francès, se situa en ple eix comercial, enfront de l\'antic Hospital de Santa María. El temple acull la imatge de la Verge de Montserrat (la Moreneta), patrona de Catalunya.',
    'description_es':
        'Entre 1761 y 1781, tuvo lugar la construcción de la Catedral Nueva gracias a las aportaciones de los leridanos, del rey Carlos III y el obispo Joaquín Sánchez. De estilo barroco con gran tendencia al clasicismo academicista francés, se sitúa en pleno eje comercial, frente al antiguo Hospital de Santa María. El templo acoge la imagen de la Virgen de Montserrat (la Moreneta), patrona de Cataluña.',
    'description_en':
        'Between 1761 and 1781, the New Cathedral was built thanks to contributions from the people of Lleida, King Charles III, and Bishop Joaquín Sánchez. Baroque in style, with a strong tendency toward French academic classicism, it is located along the city\'s main commercial axis. The cathedral houses the image of Our Lady of Montserrat (the Moreneta), patron saint of Catalonia.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Iglesia antigua de san Martí',
    'latitude': 41.6176884,
    'longitude': 0.6218894,
    'altitude': 179.5496898,
    'heading': 60.3371300,
    'tilt': 48.2615555,
    'range': 135.7271759,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1150',
    'end_date': '1200',
    'description_ca':
        'Aquesta església és una joia del romànic situada en el centre de la ciutat. Construïda en el segle XII, aquesta església romànica es va convertir en 1300 en capella de l\'Estudi General. En 1648, durant la guerra de Els Segadors, es va convertir en caserna i en el segle XIX es va utilitzar com a presó municipal. En 1893, el bisbe Messeguer Costa va ordenar la seva restauració.',
    'description_es':
        'Esta iglesia es una joya del románico situada en el centro de la ciudad. Construida en el siglo XII, esta iglesia románica se convirtió en 1300 en capilla del Estudi General. En 1648, durante la guerra de Los Segadores, se convirtió en cuartel y en el siglo XIX se utilizó como prisión municipal. En 1893, el obispo Messeguer Costa ordenó su restauración.',
    'description_en':
        'This church is a Romanesque gem located in the heart of the city. Built in the 12th century, it became the chapel of the Estudi General in 1300. In 1648, during the Reapers\' War, it was converted into a military barracks, and in the 19th century it was used as the municipal prison. In 1893, Bishop Messeguer Costa ordered its restoration.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Iglesia de Sant Llorenç',
    'latitude': 41.6142934,
    'longitude': 0.6216245,
    'altitude': 165.0426662,
    'heading': 0.6263611,
    'tilt': 50.7212160,
    'range': 107.6817707,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1150',
    'end_date': '1400',
    'description_ca':
        'La que va ser dues vegades seu catedralícia, és una construcció d\'estil romànic, però amb ampliacions i acabats gòtics. Considerada la segona església en importància després de la Seu Vella, té tres naus de la mateixa altura, amb tres absis. L\'edifici conserva quatre importants retaules gòtics, el més gran dedicat a Sant Llorenç.',
    'description_es':
        'La que fue dos veces sede catedralicia, es una construcción de estilo románico, pero con ampliaciones y acabados góticos. Considerada la segunda iglesia en importancia después de la Sede Vieja, tiene tres naves de la misma altura, con tres ábsides. El edificio conserva cuatro importantes retablos góticos, el más grande dedicado en Sant Llorenç.',
    'description_en':
        'This church, which served twice as a cathedral, is a Romanesque structure with later Gothic additions and finishes. Considered the second most important church after the Old Cathedral, it features three naves of equal height, each ending in an apse. The building preserves four significant Gothic altarpieces: the largest dedicated to Saint Lawrence.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Iglesia de San Juan',
    'latitude': 41.6164372,
    'longitude': 0.6276271,
    'altitude': 177.4477821,
    'heading': 20.1873375,
    'tilt': 57.5123487,
    'range': 129.3266586,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1885',
    'end_date': '1895',
    'description_ca':
        'En una de les places més característiques de la ciutat trobem l\'església de Sant Joan. Aquesta construcció, d\'estil neogòtic, correspon a la fi del segle XIX i el disseny va ser obra de Juliol de Saracíbar i Celestino Capmany. De l\'interior destaquem els vitralls de Jaume Bonet, i les tres rosasses representant l\'Asunción de María, l\'Epifania i el Baptisteri de Jesús.',
    'description_es':
        'En una de las plazas más características de la ciudad encontramos la iglesia de Sant Joan. Esta construcción, de estilo neogótico, corresponde a finales del siglo XIX y el diseño fue obra de Julio de Saracíbar y Celestino Capmany. Del interior destacamos los vitrales de Jaume Bonet, y los tres rosetones representando el Asunción de María, la Epifanía y el Baptisterio de Jesús.',
    'description_en':
        'In one of the most characteristic squares of the city stands the Church of Sant John. This Neo-Gothic building dates from the late 19th century and was designed by Julio de Saracíbar and Celestino Capmany. Inside, the stained-glass windows by Jaume Bonet stand out, along with the three rose windows depicting the Assumption of Mary, the Epiphany, and the Baptism of Jesus.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Capella de Sant Jaume',
    'latitude': 41.6134541,
    'longitude': 0.6245932,
    'altitude': 160.9301414,
    'heading': -10.4450623,
    'tilt': 56.9635254,
    'range': 129.9354994,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1399',
    'end_date': '1399',
    'description_ca':
        'Aquesta petita capella, dedicada originalment a la Verge de les Neus, es va alçar en època musulmana en el que era el barri cristià i, en l\'actualitat, està dedicada al culte de l\'apòstol Santiago (Sant Jaume). És un edifici de planta quadrangular, de petites dimensions, situat en ple carrer Major. La capella va ser rehabilitada en el S. XIX gràcies al bisbe Tomàs Costa i Fornaguera.',
    'description_es':
        'Esta pequeña capilla, dedicada originalmente a la Virgen de las Nieves, se levantó en época musulmana en el que era el barrio cristiano y, en la actualidad, está dedicado al culto del apóstol Santiago (San Jaime). Es un edificio de planta cuadrangular, de pequeñas dimensiones, situado en plena calle Mayor. La capilla fue rehabilitada en el S. XIX gracias al obispo Tomás Costa y Fornaguera.',
    'description_en':
        'This small chapel, originally dedicated to Our Lady of the Snows, was built during the Muslim period in what was then the Christian quarter, and it is currently dedicated to the worship of the Apostle James (Saint James). It is a small, square-plan building located on Carrer Major. The chapel was restored in the 19th century thanks to Bishop Tomás Costa y Fornaguera.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Capella de la Sang',
    'latitude': 41.6118097,
    'longitude': 0.6213486,
    'altitude': 166.8076719,
    'heading': -37.9004623,
    'tilt': 34.0792640,
    'range': 86.0436681,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1470',
    'end_date': '1499',
    'description_ca':
        'L\'Oratori de la Sang de Lleida rep el seu nom gràcies a la congregació de la Puríssima Sang del Nostre Senyor de Jesús de la mateixa ciutat. L\'any 1876 aquesta nova seu es va transformar canviant-ne totalment l\'aspecte. Es va enderrocar l\'edifici i se\'n erigí un de nova planta que només conserva l\'antiga portalada renaixentista del segle XVI, d\'estil plateresc. L\'Oratori de la Sang és la capella des d\'on surten els passos de Setmana Santa.',
    'description_es':
        'El Oratorio de la Sangre de Lérida recibe su nombre gracias a la congregación de la Purísima Sangre de nuestro Señor de Jesús de la misma ciudad. El año 1876 esta nueva sede se transformó cambiando totalmente el aspecto. Se derrocó el edificio y se erigió uno de nueva planta que solo conserva la antigua portalada renacentista del siglo XVI, de estilo plateresco. El Oratorio de la Sangre es la capilla desde donde salen los pasos de Semana Santa.',
    'description_en':
        'The Oratory of the Blood of Lleida takes its name from the Congregation of the Most Pure Blood of Our Lord Jesus of the same city. In 1876, this new headquarters was completely transformed. The deteriorated building was demolished, and a new structure was erected, preserving only the old 16th-century Renaissance portal in Plateresque style. The Oratory of the Blood is the chapel from which the Holy Week processional floats depart.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Iglesia de Sant Pere',
    'latitude': 41.6142704,
    'longitude': 0.6261016,
    'altitude': 158.5626479,
    'heading': -131.3419865,
    'tilt': 40.7434562,
    'range': 99.2003223,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1731',
    'end_date': '1749',
    'description_ca':
        'Situada en la plaça de Sant Francesc, l\'església de Sant Pere de Lleida va néixer en 1731. Era l\'església del Convent dels Franciscans (1217), i més endavant parròquia dels militars de Lleida, raó per la qual en 1786 va ser enterrat Gaspar de Portolà, primer governador de Califòrnia i benefactor de Lleida.',
    'description_es':
        'Situada en la plaza de San Francisco, la iglesia de San Pedro de Lérida nació en 1731. Era la iglesia del Convento de los Franciscanos (1217), y más adelante parroquia de los militares de Lérida, razón por la cual en 1786 fue enterrado Gaspar de Portolà, primer gobernador de California y benefactor de Lérida.',
    'description_en':
        'Located in Saint Francis Square, the Church of Saint Peter of Lleida was founded in 1731. It originally served as the church of the Franciscan Convent (1217), and later became the parish church for Lleida\'s military personnel, which is why in 1786 Gaspar de Portolà, the first governor of California and a benefactor of Lleida, was buried there.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Ermita de Granyena',
    'latitude': 41.6419816,
    'longitude': 0.6619831,
    'altitude': 159.1002909,
    'heading': 69.8492855,
    'tilt': 33.8739617,
    'range': 90.9733986,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1300',
    'end_date': '1308',
    'description_ca':
        'És un gran edifici de planta baixa i un nivell amb una teulada de dos aiguavessos. Façana senzilla. Damunt la porta d\'entrada hi ha un ull de bou i una espadanya. Arquitectura popular d\'origen medieval, si bé la construcció actual pot ésser datada al segle xiii. Primer fou una mesquita. Esmentada ja el 1308, s\'hi venera la Mare de Déu de Granyena, patrona d\'Alcoletge.',
    'description_es':
        'Es un gran edificio de planta baja y un nivel con un tejado a dos aguas. Fachada sencilla. Encima la puerta de entrada hay un óculo y una espadaña. Arquitectura popular de origen medieval, si bien la construcción actual puede ser datada en el siglo xiii. Primero fue una mezquita. Mencionada ya el 1308, se venera la Virgen María de Granyena, patrona de Alcoletge.',
    'description_en':
        'It is a large building with a ground floor and one upper level, topped with a gabled roof. The façade is simple. Above the entrance door there is an oculus and a small bell gable. It is an example of popular architecture of medieval origin, although the current construction can be dated to the 13th century. It was originally a mosque. Already mentioned in 1308, it is the site where the Virgin Mary of Granyena, patron saint of Alcoletge, is venerated.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Convent del Roser',
    'latitude': 41.6141562,
    'longitude': 0.6239325,
    'altitude': 183.4379455,
    'heading': -129.1052058,
    'tilt': 51.0932499,
    'range': 189.0943748,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1669',
    'end_date': '1707',
    'description_ca':
        'En la Guerra dels Segadors, quan Lleida estava sota la sobirania francesa el 1642, el Roser s\'ubicava sota el turó de la Seu Vella. L\'any 1669 es va reedificar al centre de la ciutat, al carrer Cavallers, però el 12 d\'octubre de 1707, durant el Setge de Lleida de la Guerra de Successió Espanyola, el Convent fou incendiat per les tropes borbòniques dirigides per Felip V.',
    'description_es':
        'En la Guerra de los Segadores, cuando Lérida estaba bajo la soberanía francesa el 1642, el Rosal se ubicaba bajo el cerro de la Sede Vieja. El año 1669 se reedificó en el centro de la ciudad, en la calle Caballeros, pero el 12 de octubre de 1707, durante el Asedio de Lérida de la Guerra de Sucesión Española, el Convento fue incendiado por las tropas borbónicas dirigidas por Felipe V.',
    'description_en':
        'During the Reapers\' War, when Lleida was under French sovereignty in 1642, the Rosal was located beneath the hill of the Old Cathedral. In 1669 it was rebuilt in the city center, on Carrer Cavallers, but on October 12, 1707, during the Siege of Lleida in the War of the Spanish Succession, the convent was set on fire by Bourbon troops under Philip V.',
  });

  batch.insert('places', {
    'category': 'cathedrals',
    'name': 'Academia Mariana',
    'latitude': 41.6111884,
    'longitude': 0.6190161,
    'altitude': 152.5098868,
    'heading': 41.6110493,
    'tilt': 43.9054586,
    'range': 150.6513596,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1862',
    'end_date': '1871',
    'description_ca':
        'Des de la seva fundació en 1862, l\'Acadèmia Mariana ha estat un autèntic símbol per a la ciutat. El Santuari de la Patrona de Lleida conté diversos tresors artístics únics en el món. El més impactant ho constitueixen els 300 metres quadrats de pintures al fresc, que daten de 1871 i que reprodueixen la vida de la Verge. Aquest és l\'únic lloc en el món on es troba plasmada, artísticament, la vida de la Mare de Déu.',
    'description_es':
        'Desde su fundación en 1862, la Academia Mariana ha sido un auténtico símbolo para la ciudad. El Santuario de la Patrona de Lérida contiene varios tesoros artísticos únicos en el mundo. El más impactante lo constituyen los 300 metros cuadrados de pinturas al fresco, que datan de 1871 y que reproducen la vida de la Virgen. Este es el único lugar en el mundo donde se encuentra plasmada, artísticamente, la vida de la Virgen María.',
    'description_en':
        'Since its foundation in 1862, the Academia Mariana has been a true symbol of the city. The Sanctuary of the Patroness of Lleida contains several artistic treasures unique in the world. The most striking of these are the 300 square meters of fresco paintings, dating from 1871, which depict the life of the Virgin. This is the only place in the world where the life of the Virgin Mary is represented artistically in its entirety.',
  });

  // ══════════════════════════════════════════════
  // MUSEUMS  (4 points)
  // ══════════════════════════════════════════════

  batch.insert('places', {
    'category': 'museums',
    'name': 'Museu Diocesà',
    'latitude': 46.6511861,
    'longitude': 0.6209024,
    'altitude': 167.5243464,
    'heading': -12.33791485331553,
    'tilt': 64.62865720377465,
    'range': 121.3190344759463,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1893',
    'end_date': '1893',
    'description_ca':
        'El Museu de Lleida anteriorment conegut com el Museu de Lleida Diocesà i Comarcal és un consorci museístic, creat l\'1 d\'agost de 1997, integrat per la Generalitat de Catalunya, la Diputació i l\'Ajuntament de Lleida, el Consell Comarcal del Segriá i el Bisbat de Lleida. La seu definitiva del museu es va inaugurar el mes de novembre de 2007. En la tardor de l\'any 2020 el Museu i la seva col·lecció van ser declarats d\'Interès Nacional.',
    'description_es':
        'El Museo de Lérida anteriormente conocido como el Museo de Lérida Diocesano y Comarcal es un consorcio museístico, creado el 1 de agosto de 1997, integrado por la Generalidad de Cataluña, la Diputación y el Ayuntamiento de Lérida, el Consejo Comarcal del Segriá y el Obispado de Lérida. La sede definitiva del museo se inauguró el mes de noviembre de 2007. En el otoño del año 2020 el Museo y su colección fueron declarados de Interés Nacional.',
    'description_en':
        'The Museum of Lleida, formerly known as the Diocesan and County Museum of Lleida, is a museum consortium created on August 1, 1997. It is made up of the Government of Catalonia, the Provincial Council and City Council of Lleida, the County Council of Segrià, and the Diocese of Lleida. The museum\'s permanent headquarters was inaugurated in November 2007. In the autumn of 2020, the Museum and its collection were declared of National Interest.',
  });

  batch.insert('places', {
    'category': 'museums',
    'name': 'Museu de l\'Aigua',
    'latitude': 41.6032808,
    'longitude': 0.6366049,
    'altitude': 145.6419754,
    'heading': 129.7831120,
    'tilt': 54.2195189,
    'range': 348.9084421,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '2004',
    'end_date': '2004',
    'description_ca':
        'El Museu de l\'Aigua està compost de diferents espais repartits per la ciutat i l\'horta de Lleida. La seva nau central és el "Campament de la Canadenca" i li segueixen el Dipòsit del Pla de l\'Aigua, els Pous de Gel, el Molino de San Anastasi, les fonts monumentals i els canals de Piñana i Seròs. Lleida va néixer a la riba del riu Segre i ha desarrollat una extensa xarxa de canals i séquies.',
    'description_es':
        'El Museo del Agua está compuesto de diferentes espacios repartidos por la ciudad y la huerta de Lérida. Su nave central es el "Campamento de la Canadiense" y le siguen el Depósito del Plan del Agua, los Pozos de Hielo, el Molino de San Anastasi, las fuentes monumentales y los canales de Piñana y Seròs. Lérida nació a la orilla del río Ebro y ha desarrollado una extensa red de canales y acequias.',
    'description_en':
        'The Water Museum is made up of several sites distributed throughout the city and the agricultural lands of Lleida. Its central building is the "Campamento de la Canadiense", followed by the Water Plan Reservoir, the Ice Wells, the Sant Anastasi Mill, the monumental fountains, and the Piñana and Seròs canals. Lleida was founded on the banks of the Ebro River and has developed an extensive network of canals and irrigation ditches.',
  });

  batch.insert('places', {
    'category': 'museums',
    'name': 'Museu d\'Art Modern i Contemporani de Lleida',
    'latitude': 41.6176785,
    'longitude': 0.6295221,
    'altitude': 169.8676987,
    'heading': -62.3325792,
    'tilt': 49.0200300,
    'range': 284.8651193,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1914',
    'end_date': '1917',
    'description_ca':
        'El museu va néixer l\'any 1914 per iniciativa del pintor Jaume Morera i de l\'Ajuntament de Lleida. El seu objectiu inicial era dotar la ciutat d\'un espai dedicat a l\'art contemporani de l\'època. El mateix Morera va donar la seva col·lecció personal, que incloïa obres de mestres com Carlos de Haes. Després de dècades d\'itinerància per diverses seus temporals, el museu va inaugurar l\'any 2024 la seva ubicació definitiva a l\'antiga Audiència de la Rambla de Ferran.',
    'description_es':
        'El museo nació en 1914 por iniciativa del pintor Jaume Morera y el Ayuntamiento de Lleida. Su objetivo inicial fue dotar a la ciudad de un espacio dedicado al arte contemporáneo de la época. El propio Morera donó su colección personal, incluyendo obras de maestros como Carlos de Haes. Tras décadas de itinerancia por sedes temporales, el museo inauguró en 2024 su ubicación definitiva en la antigua Audiencia de la Rambla de Ferran.',
    'description_en':
        'The museum was founded in 1914 on the initiative of the painter Jaume Morera and the Lleida City Council. Its initial purpose was to provide the city with a space dedicated to the contemporary art of the time. Morera himself donated his personal collection, including works by masters such as Carlos de Haes. After decades of moving between temporary locations, the museum inaugurated its permanent home in 2024 in the former Audiencia building on Rambla de Ferran.',
  });

  batch.insert('places', {
    'category': 'museums',
    'name': 'Museu de l\'Automoció',
    'latitude': 41.6133450,
    'longitude': 0.6328090,
    'altitude': 147.3941605,
    'heading': 164.2596316,
    'tilt': 49.2550400,
    'range': 139.5996892,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '2002',
    'end_date': '2002',
    'description_ca':
        'El Museu de l\'Automoció de Lleida és un museu municipal de Lleida dedicat al món de l\'automoció en general i especialitzat en vehicles antics. Inaugurat el setembre de 2002, el projecte està vinculat a la Fundació per al Patrimoni Arqueològic Industrial. El museu està estructurat en cinc grans àmbits: Els automòbils, les motocicletes, el taller, els motors i les miniatures.',
    'description_es':
        'El Museo de la Automoción de Lérida es un museo municipal de Lérida dedicado al mundo de la automoción en general y especializado en vehículos antiguos. Inaugurado en septiembre de 2002, el proyecto va ligado a la Fundación para el Patrimonio Arqueológico Industrial. El museo está estructurado en cinco grandes ámbitos: Los automóviles, las motocicletas, el taller, los motores y las miniaturas.',
    'description_en':
        'The Lleida Automotive Museum is a municipal museum in Lleida dedicated to the world of motoring in general, with a special focus on vintage vehicles. Inaugurated in September 2002, the project is linked to the Foundation for Industrial Archaeological Heritage. The museum is organized into five main areas: Automobiles, Motorcycles, The workshop, Engines, and Miniatures.',
  });

  // ══════════════════════════════════════════════
  // HISTORICAL EVENTS  (17 points)
  // ══════════════════════════════════════════════

  batch.insert('places', {
    'category': 'events',
    'name': 'Jura de fidelitat a Jaume I',
    'latitude': 41.6180451,
    'longitude': 0.6258326,
    'altitude': 218.8290324,
    'heading': 12.4121608,
    'tilt': 0.0,
    'range': 361.1213450,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1214',
    'end_date': '1214',
    'description_ca':
        'Les Corts de Lleida de 1214 es consideren les primeres de la història catalana amb participació dels tres estaments, convocades amb urgència per jurar fidelitat al nen Jaume I i estabilitzar la Corona d\'Aragó després de la catastròfica mort de Pere el Catòlic a la batalla de Muret. Davant la minoria d\'edat del nou monarca, l\'assemblea va designar el comte Sanç de Rosselló com a procurador general per governar el territori.',
    'description_es':
        'Las Cortes de Lérida de 1214 se consideran las primeras de la historia catalana con participación de los tres estamentos, convocadas de urgencia para jurar fidelidad al niño Jaime I y estabilizar la Corona de Aragón tras la catastrófica muerte de Pedro el Católico en la batalla de Muret. Ante la minoría de edad del nuevo monarca, la asamblea designó al conde Sancho de Rosellón como procurador general para gobernar el territorio.',
    'description_en':
        'The Cortes of Lleida of 1214 are considered the first in Catalan history to include participation from the three estates. They were urgently convened to swear loyalty to the child king James I and to stabilize the Crown of Aragon after the catastrophic death of Peter the Catholic at the Battle of Muret. Given the new monarch\'s minority, the assembly appointed Count Sancho of Roussillon as general procurator to govern the territory.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Invasió musulmana',
    'latitude': 41.6180451,
    'longitude': 0.6258326,
    'altitude': 218.8290324,
    'heading': 12.4121608,
    'tilt': 0.0,
    'range': 361.1213450,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '716',
    'end_date': '719',
    'description_ca':
        'La ciutat va ser ocupada per les tropes àrabs i berbers entre els anys 716 i 719, aprofitant la ràpida descomposició del regne visigot. Sota el nom de Lārida, es va transformar en una fortalesa estratègica de la Marca Superior que protegia la frontera davant els regnes cristians del nord. Durant aquest període, els musulmans van desenvolupar un avançat sistema de regadiu a l\'horta i van erigir la Suda, una impressionant alcassaba sobre la roca sobirana.',
    'description_es':
        'La ciudad fue ocupada por las tropas árabes y bereberes entre los años 716 y 719, aprovechando la rápida descomposición del reino visigodo. Bajo el nombre de Lārida, se transformó en una fortaleza estratégica de la Marca Superior que protegía la frontera frente a los reinos cristianos del norte. Durante este periodo, los musulmanes desarrollaron un avanzado sistema de regadío en la huerta y erigieron la suda, una impresionante alcazaba sobre la roca soberana.',
    'description_en':
        'The city was occupied by Arab and Berber troops between the years 716 and 719, taking advantage of the rapid collapse of the Visigothic kingdom. Under the name Lārida, it became a strategic fortress of the Upper March, protecting the frontier against the Christian kingdoms to the north. During this period, the Muslims developed an advanced irrigation system in the surrounding farmland and built the suda, an impressive citadel standing atop the sovereign rock.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (800)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '800',
    'end_date': '800',
    'description_ca':
        'L\'any 800, les tropes carolíngies de Lluís el Pietós van assetjar Lleida amb l\'objectiu d\'expandir la Marca Hispànica cap al sud dels Pirineus. L\'exèrcit franc va devastar els voltants de la ciutat per ofegar-la econòmicament. Davant l\'assetjament, el valí de Lleida no es va rendir del tot, però va pactar una treva de tres anys i el pagament de tributs (paries) als francs.',
    'description_es':
        'En el año 800, las tropas carolingias de Luis el Piadoso sitiaron Lleida con el objetivo de expandir la Marca Hispánica hacia el sur de los Pirineos. El ejército franco devastó los alrededores de la ciudad para asfixiarla económicamente. Ante el asedio, el valí de Lleida no se rindió totalmente, pero pactó una tregua de tres años y el pago de tributos (parias) a los francos.',
    'description_en':
        'In the year 800, the Carolingian troops of Louis the Pious besieged Lleida with the aim of expanding the Hispanic March south of the Pyrenees. The Frankish army devastated the surroundings of the city to suffocate it economically. Faced with the siege, the wali of Lleida did not surrender completely, but agreed to a three-year truce and the payment of tributes (parias) to the Franks.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (884)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '884',
    'end_date': '884',
    'description_ca':
        'El comte Guifré el Pilós va atacar Lleida l\'any 884 com a resposta a la fortificació de la ciutat per part dels musulmans, que considerava una amenaça per als seus dominis. La ciutat estava governada pel valí Ismaïl ibn Mussa, membre de la poderosa família dels Banu Qasi. A diferència d\'altres incursions, l\'atac de Guifré va ser un fracàs militar. Les cròniques àrabs de l\'època parlen d\'una gran mortaldat entre les tropes catalanes.',
    'description_es':
        'El conde Wifredo el Velloso atacó Lleida en el año 884 como respuesta a la fortificación de la ciudad por parte de los musulmanes, a quienes consideraba una amenaza para sus dominios. La ciudad estaba gobernada por el valí Ismaíl ibn Musa, miembro de la poderosa familia de los Banu Qasi. A diferencia de otras incursiones, el ataque de Wifredo fue un fracaso militar.',
    'description_en':
        'Count Wilfred the Hairy attacked Lleida in the year 884 in response to the fortification of the city by the Muslims, which he considered a threat to his domains. The city was governed by the wali Ismaïl ibn Musa, a member of the powerful Banu Qasi family. Unlike other incursions, Wilfred\'s attack was a military failure.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Reconquesta Cristiana',
    'latitude': 41.6089691,
    'longitude': 0.6103237,
    'altitude': 196.8294883,
    'heading': -53.7166980,
    'tilt': 56.8415937,
    'range': 1159.2692589,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1149',
    'end_date': '1149',
    'description_ca':
        'Les hostes de Ramon Berenguer IV i Ermengol VI d\'Urgell van establir el seu campament estratègic al turó de Gardeny durant la primavera de 1149 per iniciar el setge definitiu de la ciutat. La resistència musulmana finalment es va trencar el 24 d\'octubre de 1149, quan la guarnició almoràvit va capitular. Aquesta victòria no només va suposar la presa de Lleida, sinó que va provocar la caiguda immediata de Fraga i Mequinensa.',
    'description_es':
        'Las huestes de Ramón Berenguer IV y Ermengol VI de Urgell establecieron su campamento estratégico en la colina de Gardeny durante la primavera de 1149 para iniciar el cerco definitivo a la ciudad. La resistencia musulmana finalmente se quebró el 24 de octubre de 1149, cuando la guarnición almorávide capituló. Esta victoria no solo supuso la toma de Lleida, sino que forzó la caída inmediata de Fraga y Mequinenza.',
    'description_en':
        'The forces of Ramon Berenguer IV and Ermengol VI of Urgell established their strategic camp on the hill of Gardeny during the spring of 1149 to begin the final siege of the city. Muslim resistance finally collapsed on 24 October 1149, when the Almoravid garrison surrendered. This victory not only resulted in the capture of Lleida but also triggered the immediate fall of Fraga and Mequinenza.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (1413)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1413',
    'end_date': '1414',
    'description_ca':
        'Després del Compromís de Casp, Jaume II d\'Urgell es va alçar contra el nou rei Ferran I. El juny de 1413, les tropes del comte van intentar prendre Lleida per sorpresa. Tanmateix, la ciutat es va mantenir fidel a Ferran I i les seves defenses van repel·lir l\'atac inicial. El fracàs a Lleida va deixar el comte d\'Urgell en una posició desesperada, forçant-lo a retirar-se cap a Balaguer.',
    'description_es':
        'Tras el Compromiso de Caspe, Jaime II de Urgel se alzó contra el nuevo rey Fernando I. En junio de 1413, las tropas del conde intentaron tomar Lérida por sorpresa. Sin embargo, la ciudad se mantuvo fiel a Fernando I y sus defensas repelieron el ataque inicial. El fracaso en Lérida dejó al conde de Urgel en una posición desesperada, forzándolo a retirarse hacia Balaguer.',
    'description_en':
        'After the Compromise of Caspe, James II of Urgell rose up against the new king, Ferdinand I. In June 1413, the count\'s troops attempted to seize Lleida by surprise. However, the city remained loyal to Ferdinand I, and its defenses repelled the initial attack. The failure at Lleida left the Count of Urgell in a desperate position, forcing him to retreat to Balaguer.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'La batalla de Lleida (1642)',
    'latitude': 41.6100091,
    'longitude': 0.6367412,
    'altitude': 166.3366544,
    'heading': -53.7144915,
    'tilt': 56.8480508,
    'range': 2017.0246508,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1642',
    'end_date': '1642',
    'description_ca':
        'El 7 d\'octubre de 1642, en plena Guerra dels Segadors, l\'exèrcit espanyol va intentar recuperar Lleida per frenar l\'avanç francès a Catalunya. Les tropes de la Monarquia Hispànica, dirigides pel marquès de Leganés, van topar amb l\'exèrcit franco-català del mariscal La Mothe-Houdancourt. Malgrat la seva superioritat numèrica, les forces espanyoles van patir una derrota estrepitosa.',
    'description_es':
        'El 7 de octubre de 1642, en plena Guerra de los Segadores, el ejército español intentó recuperar Lérida para frenar el avance francés en Cataluña. Las tropas de la Monarquía Hispánica, dirigidas por el marqués de Leganés, chocaron contra el ejército franco-catalán del mariscal La Mothe-Houdancourt. A pesar de su superioridad numérica, las fuerzas españolas sufrieron una derrota estrepitosa.',
    'description_en':
        'On 7 October 1642, in the midst of the Reapers\' War, the Spanish army attempted to retake Lleida in order to halt the French advance in Catalonia. The troops of the Hispanic Monarchy, led by the Marquis of Leganés, clashed with the Franco-Catalan army commanded by Marshal La Mothe-Houdancourt. Despite their numerical superiority, the Spanish forces suffered a crushing defeat.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (1644)',
    'latitude': 41.6149206,
    'longitude': 0.6204228,
    'altitude': 174.2621771,
    'heading': -52.0311874,
    'tilt': 60.5786903,
    'range': 1229.4097737,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1644',
    'end_date': '1644',
    'description_ca':
        'El maig de 1644, l\'exèrcit de Felip IV, liderat per Felip de Silva, va posar setge a la ciutat de Lleida després d\'haver recuperat Montsó. Les tropes de la Monarquia Hispànica van aconseguir derrotar l\'exèrcit francès de La Mothe-Houdancourt. La ciutat va capitular a finals de juliol de 1644, fet que va representar una de les victòries militars i estratègiques més importants per a Espanya durant la Guerra dels Segadors.',
    'description_es':
        'En mayo de 1644, el ejército de Felipe IV, liderado por Felipe de Silva, puso bajo asedio la ciudad de Lérida tras haber recuperado Monzón. Las tropas de la Monarquía Hispánica lograron derrotar al ejército francés de La Mothe-Houdancourt. La ciudad capituló a finales de julio de 1644, lo que representó una de las victorias militares y estratégicas más importantes para España en la Guerra de los Segadores.',
    'description_en':
        'In May 1644, the army of Philip IV, led by Felipe de Silva, laid siege to the city of Lleida after having retaken Monzón. The troops of the Hispanic Monarchy succeeded in defeating the French army of La Mothe-Houdancourt. The city surrendered at the end of July 1644, marking one of the most important military and strategic victories for Spain in the Reapers\' War.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (1646)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1646',
    'end_date': '1646',
    'description_ca':
        'El maig de 1646, les tropes franceses sota el comandament del comte d\'Harcourt van assetjar Lleida amb l\'objectiu de recuperar-la per al bàndol franco-català. L\'exèrcit espanyol, dirigit pel marquès de Leganés, va aconseguir trencar el setge francès mitjançant un audaciós atac sorpresa nocturn. La derrota francesa va ser tan contundent que Harcourt es va veure obligat a fugir abandonant artilleria i subministraments.',
    'description_es':
        'En mayo de 1646, las tropas francesas bajo el mando del conde de Harcourt sitiaron Lérida con el objetivo de recuperarla para el bando franco-catalán. El ejército español, dirigido por el marqués de Leganés, logró romper el cerco francés mediante un audaz ataque sorpresa nocturno. La derrota francesa fue tan contundente que Harcourt se vio obligado a huir abandonando artillería y suministros.',
    'description_en':
        'In May 1646, the French troops under the command of the Count of Harcourt laid siege to Lleida with the aim of recapturing it for the Franco-Catalan side. The Spanish army, led by the Marquis of Leganés, managed to break the French siege through a daring nighttime surprise attack. The French defeat was so overwhelming that Harcourt was forced to flee, abandoning artillery and supplies.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (1647)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1647',
    'end_date': '1647',
    'description_ca':
        'El maig de 1647, el prestigiós príncep de Condé, heroi francès de Rocroi, va iniciar un nou setge sobre Lleida amb la intenció d\'esmenar el fracàs de l\'any anterior. La defensa de la ciutat va recaure en el governador Gregorio Brito, que va resistir amb tenacitat els assalts. Davant la impossibilitat de trencar les muralles, Condé es va veure obligat a aixecar el setge al juny, patint una de les poques derrotes de la seva carrera militar.',
    'description_es':
        'En mayo de 1647, el prestigioso príncipe de Condé, héroe francés de Rocroi, inició un nuevo asedio sobre Lérida con la intención de enmendar el fracaso del año anterior. La defensa de la ciudad corrió a cargo del gobernador Gregorio Brito, quien resistió con tenacidad los asaltos. Ante la imposibilidad de romper las murallas, Condé se vio obligado a levantar el sitio en junio, sufriendo una de las pocas derrotas de su carrera militar.',
    'description_en':
        'In May 1647, the prestigious Prince of Condé, the French hero of Rocroi, launched a new siege of Lleida in an attempt to make up for the failure of the previous year. The city\'s defense was led by Governor Gregorio Brito, who tenaciously resisted the assaults. Unable to breach the walls, Condé was forced to lift the siege in June, suffering one of the few defeats of his military career.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (1707)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Modern Age',
    'start_date': '1707',
    'end_date': '1707',
    'description_ca':
        'El setembre de 1707, després de la derrota austriacista a Almansa, les tropes borbòniques del duc d\'Orleans van assetjar Lleida. Després d\'un mes d\'intensos bombardejos, els borbònics van assaltar la ciutat el 12 d\'octubre. La victòria borbònica va suposar un càstig sever per a Lleida: la ciutat va ser saquejada, va perdre els seus furs i la seva universitat fou clausurada.',
    'description_es':
        'En septiembre de 1707, tras la derrota austriacista en Almansa, las tropas borbónicas del Duque de Orleans cercaron Lérida. Tras un mes de intensos bombardeos, los borbones asaltaron la ciudad el 12 de octubre. La victoria borbónica supuso un castigo severo para Lérida: la ciudad fue saqueada, perdió sus fueros y su universidad fue clausurada.',
    'description_en':
        'In September 1707, after the Austriacist defeat at Almansa, the Bourbon troops of the Duke of Orléans laid siege to Lleida. After a month of intense bombardment, the Bourbons stormed the city on 12 October. The Bourbon victory brought severe punishment upon Lleida: the city was sacked, it lost its traditional privileges, and its university was closed.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Setge de Lleida (1810)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1810',
    'end_date': '1810',
    'description_ca':
        'El maig de 1810, durant la Guerra del Francès, les tropes napoleòniques del mariscal Suchet van assetjar Lleida després de la seva victòria a la batalla de Margalef. La guarnició espanyola, liderada pel general Jaime García-Conde, va resistir un violent bombardeig fins que els francesos van aconseguir obrir bretxes a les muralles de la ciutat. La capitulació final, el 14 de maig, va permetre als francesos controlar una plaça estratègica clau.',
    'description_es':
        'En mayo de 1810, durante la Guerra de la Independencia, las tropas napoleónicas del mariscal Suchet sitiaron Lérida tras su victoria en la batalla de Margalef. La guarnición española, liderada por el general Jaime García-Conde, resistió un violento bombardeo hasta que los franceses lograron abrir brechas en las murallas de la ciudad. La capitulación final el 14 de mayo permitió a los franceses controlar una plaza estratégica clave.',
    'description_en':
        'In May 1810, during the Peninsular War, the Napoleonic troops of Marshal Suchet laid siege to Lleida after their victory at the Battle of Margalef. The Spanish garrison, led by General Jaime García-Conde, resisted a violent bombardment until the French managed to open breaches in the city walls. The final capitulation on 14 May allowed the French to secure a key strategic stronghold.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Batalla de Lleida (1938)',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Contemporary Age',
    'start_date': '1938',
    'end_date': '1938',
    'description_ca':
        'La Batalla de Lleida, culminada el 3 d\'abril de 1938, va marcar l\'entrada definitiva de les tropes de Franco a Catalunya després de trencar el front d\'Aragó. El general Yagüe va liderar l\'assalt contra una defensa republicana que, encapçalada per "El Campesino", va resistir ferotgement al nucli urbà sota intensos bombardejos. La caiguda de Lleida va tenir un impacte polític immediat, ja que va permetre a Franco derogar l\'Estatut d\'Autonomia de Catalunya.',
    'description_es':
        'La Batalla de Lleida, culminada el 3 de abril de 1938, marcó la entrada definitiva de las tropas de Franco en Cataluña tras romper el frente de Aragón. El general Yagüe lideró el asalto contra una defensa republicana que, encabezada por "El Campesino", resistió ferozmente en el casco urbano bajo intensos bombardeos. La caída de Lleida tuvo un peso político inmediato, ya que permitió a Franco derogar el Estatuto de Autonomía de Cataluña.',
    'description_en':
        'The Battle of Lleida, which culminated on 3 April 1938, marked the definitive entry of Franco\'s troops into Catalonia after breaking through the Aragon front. General Yagüe led the assault against a Republican defense that, under the command of "El Campesino," fought fiercely in the urban center under heavy bombardment. The fall of Lleida had an immediate political impact, as it allowed Franco to abolish Catalonia\'s Statute of Autonomy.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Batalla de Ilerda',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Ancient Age',
    'start_date': '49 aC',
    'end_date': '49 aC',
    'description_ca':
        'La Batalla d\'Ilerda (49 aC) va ser un enfrontament magistral de la Segona Guerra Civil romana en què Juli Cèsar va derrotar els generals de Pompeu, Afrani i Petreu, als voltants de l\'actual Lleida. Malgrat quedar aïllat i sense subministraments per una gran crescuda del riu Segre, Cèsar va capgirar la situació amb una brillant maniobra d\'enginyeria. En lloc de buscar una massacre, Cèsar va optar per una estratègia de desgast que va envoltar les legions pompeianes.',
    'description_es':
        'La Batalla de Ilerda (49 a. C.) fue un enfrentamiento magistral de la Segunda Guerra Civil romana donde Julio César derrotó a los generales de Pompeyo, Afranio y Petreyo, en los alrededores de la actual Lleida. A pesar de quedar aislado y sin suministros por una gran crecida del río Segre, César dio la vuelta a la situación con una brillante maniobra de ingeniería. En lugar de buscar una masacre, César optó por una estrategia de desgaste.',
    'description_en':
        'The Battle of Ilerda (49 BC) was a masterful engagement of the Second Roman Civil War in which Julius Caesar defeated Pompey\'s generals Afranius and Petreius in the area surrounding present-day Lleida. Despite being isolated and cut off from supplies after a major flood of the Segre River, Caesar reversed the situation through a brilliant engineering maneuver. Instead of seeking a massacre, Caesar chose a strategy of attrition.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Unió del regne de Aragó i comtat de Barcelona',
    'latitude': 41.6167910,
    'longitude': 0.6254991,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1150',
    'end_date': '1150',
    'description_ca':
        'A l\'agost de 1150, el Castell de la Suda de Lleida va acollir el casament entre Peronella d\'Aragó i Ramon Berenguer IV. La reina tenia 14 anys, complint així el compromís pactat quan era un nadó. Aquest enllaç va ser l\'acte fundacional de la Corona d\'Aragó. Va unir el Regne d\'Aragó amb el Comtat de Barcelona, creant una potència política que respectava les lleis i els furs de cada territori.',
    'description_es':
        'En agosto de 1150, el Castell de la Suda en Lérida acogió la boda entre Petronila de Aragón y Ramón Berenguer IV. La reina tenía 14 años, cumpliendo así el compromiso pactado cuando era un bebé. Este enlace fue el acto fundacional de la Corona de Aragón. Unió el Reino de Aragón con el Condado de Barcelona, creando una potencia política que respetaba las leyes y fueros de cada territorio.',
    'description_en':
        'In August 1150, the Castell de la Suda in Lleida hosted the wedding between Petronila of Aragon and Ramon Berenguer IV. The queen was 14 years old, thus fulfilling the marriage pact arranged when she was an infant. This union was the foundational act of the Crown of Aragon. It joined the Kingdom of Aragon with the County of Barcelona, creating a political power that respected the laws and privileges of each territory.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Primera universitat del regne d\'Aragó',
    'latitude': 41.6146803,
    'longitude': 0.6198760,
    'altitude': 178.7109539,
    'heading': -70.5474710,
    'tilt': 47.3537403,
    'range': 270.1415493,
    'altitude_mode': 'relativeToGround',
    'era': 'Middle Ages',
    'start_date': '1300',
    'end_date': '1300',
    'description_ca':
        'Fundat l\'any 1300 per Jaume II després d\'una butlla papal de 1297, l\'Estudi General de Lleida va ser la primera universitat de Catalunya i de la Corona d\'Aragó. Durant segles va destacar com a centre de referència en Dret, Medicina i Filosofia, seguint el prestigiós model organitzatiu de la Universitat de Bolonya. L\'any 1717, Felip V va clausurar la institució mitjançant el Decret de Nova Planta. La Universitat de Lleida actual es va refundar el 1991.',
    'description_es':
        'Fundado en 1300 por Jaime II tras una bula papal de 1297, el Estudi General de Lleida fue la primera universidad de Cataluña y de la Corona de Aragón. Durante siglos destacó como centro de referencia en Derecho, Medicina y Filosofía, siguiendo el prestigioso modelo organizativo de la Universidad de Bolonia. En 1717, Felipe V clausuró la institución mediante el Decreto de Nueva Planta. La actual Universidad de Lleida se refundó en 1991.',
    'description_en':
        'Founded in 1300 by James II following a papal bull issued in 1297, the Estudi General of Lleida was the first university in Catalonia and in the Crown of Aragon. For centuries it stood out as a leading center in Law, Medicine, and Philosophy, following the prestigious organizational model of the University of Bologna. In 1717, Philip V closed the institution through the Nueva Planta Decree. The modern University of Lleida was re-established in 1991.',
  });

  batch.insert('places', {
    'category': 'events',
    'name': 'Revolta d\'Indíbil i Mandoni',
    'latitude': 41.6191230,
    'longitude': 0.6232056,
    'altitude': 188.3243688,
    'heading': -25.2592959,
    'tilt': 65.4480268,
    'range': 1480.5909806,
    'altitude_mode': 'relativeToGround',
    'era': 'Ancient Age',
    'start_date': '206 aC',
    'end_date': '205 aC',
    'description_ca':
        'Indíbil i Mandonio, líders ibers, es van rebel·lar contra Roma en comprendre que Escipió no portaria la independència, sinó una nova ocupació. L\'any 205 aC, van formar una gran coalició de pobles de la vall de l\'Ebre per expulsar els invasors. Tanmateix, es van enfrontar a la superioritat tàctica de les legions en una batalla decisiva. Indíbil va morir en combat lluitant heroicament, cosa que va desmuntar la resistència de les seves tropes.',
    'description_es':
        'Indíbil y Mandonio, líderes íberos, se rebelaron contra Roma al comprender que Escipión no traería la independencia, sino una nueva ocupación. En el 205 a.C., formaron una gran coalición de pueblos del valle del Ebro para expulsar a los invasores. Sin embargo, se enfrentaron a la superioridad táctica de las legiones en una batalla definitiva. Indíbil murió en combate luchando heroicamente, lo que desmoronó la resistencia de sus tropas.',
    'description_en':
        'Indibilis and Mandonius, Iberian leaders, rebelled against Rome when they realized that Scipio would not bring independence but a new occupation. In 205 BC, they formed a large coalition of peoples from the Ebro Valley to expel the invaders. However, they faced the tactical superiority of the legions in a decisive battle. Indibilis died in combat fighting heroically, which shattered the resistance of his troops.',
  });

  await batch.commit(noResult: true);
}
