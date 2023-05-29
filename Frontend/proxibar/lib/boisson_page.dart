import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'bar_details_page.dart';
import 'bar.dart';

class BoissonPage extends StatefulWidget {
  @override
  _BoissonPageState createState() => _BoissonPageState();
}

class _BoissonPageState extends State<BoissonPage> {
  String boissonName = '';
  List<Bar> bars = [];

  Future<void> rechercherBoisson() async {
    const url = 'https://40d2-185-223-151-250.ngrok-free.app/scrapping/getBoisson';

    final response = await http.post(
      Uri.parse(url),
      body: {
        "latitude": "50.634204",
        "longitude": "3.04876",
        "boisson": boissonName,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      //Clear la liste
      bars.clear();
      // Récupérer les informations de la réponse JSON
      for (var i = 0; i < data.length; i++) {
        //on ajoute les bars dans la liste
        bars.add(Bar.fromJson(data[i]));
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recherche ta boisson',
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
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  boissonName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nom de la boisson',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                rechercherBoisson();
              },
              child: Text('Rechercher'),
            ),
            SizedBox(height: 20),
            Text(
              'Les bars contenant votre boisson :',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: bars.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarDetailsPage(
                            bar: bars[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            child: Image.network(
                              bars[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              bars[index].name,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              bars[index].adresse,
                              style: TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
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
