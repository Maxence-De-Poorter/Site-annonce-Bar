class Bar {
  final int id;
  final String name;
  final String adresse;
  final String horaire;
  final String telephone;
  final String image;
  final String latitude;
  final String longitude;
  final String carte;
  final String distance;

  Bar(
      {required this.id,
      required this.name,
      required this.adresse,
      required this.horaire,
      required this.telephone,
      required this.image,
      required this.latitude,
      required this.longitude,
      required this.carte,
      required this.distance});

  factory Bar.fromJson(Map<dynamic, dynamic> json) {
    return Bar(
        id: json['bar']['id'],
        name: json['bar']['name'],
        adresse: json['bar']['adresse'],
        horaire: json['bar']['horaire'],
        telephone: json['bar']['telephone'],
        image: json['bar']['image'],
        latitude: json['bar']['latitude'],
        longitude: json['bar']['longitude'],
        carte: json['bar']['carte'],
        distance: json['distance']);
  }
}
