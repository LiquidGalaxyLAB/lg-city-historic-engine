class Lloc {
  final int? id;
  final String categoria;     // 'ubicacions', 'catedrals', 'museus', 'fets'
  final String nom;
  final double latitud;
  final double longitud;
  final double altitud;
  final double heading;
  final double tilt;
  final double range;
  final String altitudeMode;
  final String epoca;
  final String? fechaInici;
  final String? fechaFi;
  final String descripcioCa;  // Català
  final String descripcioEs;  // Español
  final String descripcioEn;  // English

  Lloc({
    this.id,
    required this.categoria,
    required this.nom,
    required this.latitud,
    required this.longitud,
    required this.altitud,
    required this.heading,
    required this.tilt,
    required this.range,
    required this.altitudeMode,
    required this.epoca,
    this.fechaInici,
    this.fechaFi,
    required this.descripcioCa,
    required this.descripcioEs,
    required this.descripcioEn,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'categoria': categoria,
    'nom': nom,
    'latitud': latitud,
    'longitud': longitud,
    'altitud': altitud,
    'heading': heading,
    'tilt': tilt,
    'range': range,
    'altitude_mode': altitudeMode,
    'epoca': epoca,
    'fecha_inici': fechaInici,
    'fecha_fi': fechaFi,
    'descripcio_ca': descripcioCa,
    'descripcio_es': descripcioEs,
    'descripcio_en': descripcioEn,
  };

  factory Lloc.fromMap(Map<String, dynamic> m) => Lloc(
    id: m['id'],
    categoria: m['categoria'],
    nom: m['nom'],
    latitud: m['latitud'],
    longitud: m['longitud'],
    altitud: m['altitud'],
    heading: m['heading'],
    tilt: m['tilt'],
    range: m['range'],
    altitudeMode: m['altitude_mode'],
    epoca: m['epoca'],
    fechaInici: m['fecha_inici'],
    fechaFi: m['fecha_fi'],
    descripcioCA: m['descripcio_ca'],
    descripcioEs: m['descripcio_es'],
    descripcioEn: m['descripcio_en'],
  );
}