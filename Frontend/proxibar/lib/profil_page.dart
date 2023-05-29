import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'Profile',
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
          isLoggedIn
              ? _buildProfileWidget(context)
              : _buildLoginWidget(context),
        ],
      ),
    );
  }

  Widget _buildLoginWidget(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Please login to view your profile',
          style: TextStyle(fontSize: 18),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () {
            final String userEmail = emailController.text;
            final String password = passwordController.text;

            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            authProvider.login(
              userEmail,
              password,
            ); // Appel de la méthode de connexion

            // Effacer les champs de texte après la tentative de connexion
            emailController.clear();
            passwordController.clear();
          },
          child: Text('Login'),
        ),
      ],
    );
  }

  Widget _buildProfileWidget(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user =
        authProvider.getCurrentUser(); // Obtenir l'utilisateur connecté

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${user?.name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Surname: ${user?.surname}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to "Mes commentaires" page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentPage(
                            userEmail: user!.email,
                          ),
                        ),
                      );
                    },
                    child: Text('Mes commentaires'),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModifierMesDonneesPage(),
                        ),
                      );
                    },
                    child: Text('Modifier mes données'),
                  ),
                  // Contenu de la section "Modifier mes données"
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              authProvider.logout(); // Déconnexion de l'utilisateur
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String bar;
  final String date;
  final int rating;
  final String comment;

  Comment({
    required this.bar,
    required this.date,
    required this.rating,
    required this.comment,
  });
}

class CommentPage extends StatefulWidget {
  final String userEmail;

  CommentPage({required this.userEmail});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    final url = 'https://40d2-185-223-151-250.ngrok-free.app/commentaire/getByUser';

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'userEmail': widget.userEmail});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data);
        final List<Comment> comments = data
            .map((item) => Comment(
                  bar: item['barName'],
                  date: item['date'],
                  rating: item['note'],
                  comment: item['commentaire'],
                ))
            .toList();

        setState(() {
          _comments = comments;
        });
      } else {
        print('Failed to fetch comments. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to fetch comments. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes commentaires'),
      ),
      body: ListView.builder(
        itemCount: _comments.length,
        itemBuilder: (context, index) {
          final comment = _comments[index];

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.bar,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text('Date: ${comment.date}'),
                Text('Note: ${comment.rating}'),
                Text('Commentaire: ${comment.comment}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ModifierMesDonneesPage extends StatefulWidget {
  @override
  _ModifierMesDonneesPageState createState() => _ModifierMesDonneesPageState();
}

class _ModifierMesDonneesPageState extends State<ModifierMesDonneesPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.getCurrentUser();

    nameController.text = user?.name ?? '';
    surnameController.text = user?.surname ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier mes données'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Modifier mes données',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(
                labelText: 'Surname',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);

                final newName = nameController.text;
                final newSurname = surnameController.text;

                // Mettre à jour les données de l'utilisateur dans la base de données avec l'id, le nom et le prénom
                authProvider.updateUser(
                  newName,
                  newSurname,
                );

                // Naviguer en arrière après la mise à jour des données
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
