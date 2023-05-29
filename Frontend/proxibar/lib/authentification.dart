import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final int id;
  final String name;
  final String surname;
  final String email;
  // Ajoutez d'autres propriétés d'utilisateur en fonction de votre API

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    // Initialisez les autres propriétés ici
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      // Décodez et initialisez les autres propriétés ici
    );
  }
}

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _currentUser;

  bool get isLoggedIn => _isLoggedIn;
  User? getCurrentUser() {
    // Logique pour récupérer l'utilisateur actuel
    // à partir de votre système d'authentification
    // Retournez l'utilisateur ou null s'il n'est pas connecté

    // Exemple de logique de récupération de l'utilisateur actuellement connecté
    if (_isLoggedIn) {
      // Remplacez cette partie par votre logique spécifique pour récupérer l'utilisateur connecté
      print(_currentUser!.name);
      return _currentUser;
    } else {
      return null;
    }
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    _isLoggedIn = true;
    notifyListeners();
  }

  updateUser(newName, newSurname) {
    //On envoie une requête post pour mettre à jour les informations de l'utilisateur
    const url = 'https://40d2-185-223-151-250.ngrok-free.app/users/update';

    http.post(
      Uri.parse(url),
      body: {
        "id": _currentUser!.id.toString(),
        "name": newName,
        "surname": newSurname,
      },
    );

    //Si la requête est réussie, on déconnecte l'utilisateur
    logout();
  }

  Future<void> login(String userEmail, String password) async {
    // Effectuez ici la logique d'authentification en envoyant une requête POST à l'API
    // pour vérifier les informations d'identification de l'utilisateur.
    // Remplacez "API_ENDPOINT" par l'URL réelle de votre API.

    const url = 'https://40d2-185-223-151-250.ngrok-free.app/users/login';

    final response = await http.post(
      Uri.parse(url),
      body: {
        "name": userEmail,
        "password": password,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body == 'false') {
        // Erreur de connexion
      } else {
        // Connexion réussie
        print(response.body);
        final userData = jsonDecode(response.body);
        final user = User.fromJson(userData);
        setCurrentUser(user); // Définir l'utilisateur actuel
        _isLoggedIn = true;
        notifyListeners();
      }
    } else {
      // Erreur de connexion
      throw Exception('Erreur de connexion');
    }
  }

  void logout() {
    _isLoggedIn = false;
    _currentUser =
        null; // Réinitialisez l'utilisateur actuellement connecté lors de la déconnexion
    notifyListeners();
  }
}
