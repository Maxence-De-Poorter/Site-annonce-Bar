import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'authentification.dart';
import 'bar.dart';

class Comment {
  final String barName;
  final String userName;
  final String date;
  final int note;
  final String commentaire;

  Comment({
    required this.barName,
    required this.userName,
    required this.date,
    required this.note,
    required this.commentaire,
  });
}

class BarDetailsPage extends StatelessWidget {
  final Bar bar;

  BarDetailsPage({required this.bar});

  double calculateAverageRating(List<Comment> comments) {
    if (comments.isEmpty) {
      return 0.0;
    }

    int totalRating = 0;
    for (Comment comment in comments) {
      totalRating += comment.note;
    }

    double averageRating = totalRating / comments.length;
    return averageRating;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(bar.name),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    bar.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    bar.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 16,
                  endIndent: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Adresse:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    bar.adresse,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Téléphone:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    bar.telephone,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 16,
                  endIndent: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Horaire:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    bar.horaire,
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 16,
                  endIndent: 16,
                ),
                ExpansionTile(
                    title: Text(
                      'Carte',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          bar.carte,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ]),
                Divider(
                  thickness: 2,
                  indent: 16,
                  endIndent: 16,
                ),
                ExpansionTile(
                  title: Row(
                    children: [
                      Text(
                        'Commentaires',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      FutureBuilder<List<Comment>>(
                        future: fetchComments(bar.name),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Comment> comments = snapshot.data!;
                            double averageRating =
                                calculateAverageRating(comments);
                            return Text(
                              'Note: ${averageRating.toStringAsFixed(1)}/5',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                  children: [
                    FutureBuilder<List<Comment>>(
                      future: fetchComments(bar.name),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Comment> comments = snapshot.data!;
                          if (comments.isEmpty) {
                            return Text('Aucun commentaire pour le moment');
                          }
                          return ListView.builder(
                            itemCount: comments.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              Comment comment = comments[index];
                              return ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.userName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Date: ${comment.date}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Note: ${comment.note}/5',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      comment.commentaire,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Une erreur s\'est produite');
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    SizedBox(height: 16),
                    CommentForm(barName: bar.name),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentForm extends StatefulWidget {
  final String barName; // Add barName parameter

  CommentForm({required this.barName});

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _commentController;
  late int _rating;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _rating = 1;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void submitComment() async {
    String barName = widget.barName; // Access barName from the widget
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final currentUser = authProvider.getCurrentUser();

      if (currentUser != null) {
        // Prepare the comment data
        final String userName = currentUser.name;
        final String userEmail = currentUser.email;
        final String commentText = _commentController.text;

        // Prepare the request body
        final Map<String, dynamic> requestBody = {
          'barName': barName,
          'userName': userName,
          'userEmail': userEmail,
          'commentaire': commentText,
          'note': _rating,
          'date': DateTime.now().toString(),
        };

        // Send the comment to the API
        final url =
            'https://40d2-185-223-151-250.ngrok-free.app/commentaire/create'; // Replace with the actual API endpoint
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode(requestBody),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Comment successfully submitted
          // Reset the form
          _formKey.currentState!.reset();
          _rating = 1;
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content:
                    Text('Failed to submit the comment. Please try again.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Vous devez être connecté pour commenter.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ajouter un commentaire:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Saisissez votre commentaire',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir un commentaire';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            Text(
              'Note:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = i;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      color: i <= _rating ? Colors.orange : Colors.grey,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => submitComment(), // Pass bar.name as an argument
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Comment>> fetchComments(String barName) async {
  final url =
      'https://40d2-185-223-151-250.ngrok-free.app/commentaire/getAll'; // Remplacez l'URL par l'URL réelle de l'API

  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode({'barName': barName}),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    // La requête a réussi, analyser la réponse JSON et renvoyer les commentaires
    final List<dynamic> data = jsonDecode(response.body);
    List<Comment> comments = [];
    print(data);
    data.forEach((comment) {
      Comment newComment = Comment(
        barName: comment['barName'],
        userName: comment['userName'],
        date: comment['date'],
        note: comment['note'],
        commentaire: comment['commentaire'],
      );
      comments.add(newComment);
    });
    return comments;
  } else {
    // La requête a échoué, lancer une exception ou renvoyer une valeur par défaut
    throw Exception('Échec de la requête POST');
  }
}
