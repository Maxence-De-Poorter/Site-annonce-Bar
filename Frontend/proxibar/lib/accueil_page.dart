import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Bar {
  final int id;
  final String name;
  final String adresse;
  final String image;
  final String distance;

  Bar({
    required this.id,
    required this.name,
    required this.adresse,
    required this.image,
    required this.distance,
  });

  factory Bar.fromJson(Map<dynamic, dynamic> json) {
    return Bar(
      distance: json['distance'],
      //Le reste des informations sont dans le tableau bar
      id: json['bar']['id'],
      name: json['bar']['name'],
      adresse: json['bar']['adresse'],
      image: json['bar']['image'],
    );
  }
}

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  String boissonName = '';
  List<Bar> nearestBars = [];

  Future<void> fetchNearestBars() async {
    const url = 'https://40d2-185-223-151-250.ngrok-free.app/scrapping/nearest';

    final response = await http.post(
      Uri.parse(url),
      body: {
        "latitude": "50.634204",
        "longitude": "3.04876",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      //Clear la liste
      nearestBars.clear();
      // Récupérer les informations de la réponse JSON
      for (var i = 0; i < data.length; i++) {
        //on ajoute les bars dans la liste
        nearestBars.add(Bar.fromJson(data[i]));
      }
      setState(() {
        // Mettre à jour l'état pour déclencher la reconstruction du widget
        // avec les nouveaux éléments de la liste bars
      });
    } else {
      print('Erreur lors de la requête : ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNearestBars();
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              "PROXI'BAR",
              style: TextStyle(
                fontSize: 50,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
                letterSpacing: 2,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Le site qui vous permet de trouver le bar qui vous correspond !",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemCount: nearestBars.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            nearestBars[index].image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          dense: false,
                          title: Text(
                            nearestBars[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                nearestBars[index].adresse,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Distance: ${nearestBars[index].distance} mètres',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          // Afficher d'autres informations du bar si nécessaire
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}