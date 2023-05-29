import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'boisson_page.dart';
import 'accueil_page.dart';
import 'annuaire_page.dart';
import 'profil_page.dart';
import 'authentification.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PROXI'BAR",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // Ajoutez ici vos pages pour chaque onglet
    AccueilPage(),
    AnnuairePage(),
    BoissonPage(),
    ProfilePage()
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proxi'BAR"),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.red,
        color: Colors.white, // Couleur de fond de la barre de navigation
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 15),
          Icon(Icons.list, size: 15),
          Icon(Icons.search, size: 15),
          Icon(Icons.person, size: 15),
        ],
        onTap: _onTabSelected,
      ),
    );
  }
}
