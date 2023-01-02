import 'package:flutter/material.dart';
import 'package:music_app/pages/search_page.dart';
import '../firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key, required this.title});
  final String title;

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  FireBaseService fireBaseService = FireBaseService();

  bool isCreating = false;
  bool isLoggin = false;
  bool success = false;
  late String userEmail;
  late String userPassword;
  late String userConfirmPassword;
  late String userPseudo;

  @override
  Widget build(BuildContext context) {
    fireBaseService.initializeDb();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: const Text(
              "Enter your e-mail and password",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: 500,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 20),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'e-mail',
                ),
                onChanged: (value) => userEmail = value,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: isCreating
                ? TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pseudo',
                    ),
                    onChanged: (value) => userPseudo = value,
                  )
                : const SizedBox(height: 0, width: 0),
          ),
          SizedBox(
            height: 100,
            width: 500,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 20),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                onChanged: (value) => userPassword = value,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: isCreating
                ? TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirmate Password',
                    ),
                    onChanged: (value) => userConfirmPassword = value,
                  )
                : const SizedBox(height: 0, width: 0),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
                onTap: () {
                  setState(() {
                    isCreating = true;
                    isLoggin = false;
                  });
                },
                child: isCreating
                    ? const SizedBox(height: 0, width: 0)
                    : const Text(
                        "Create an account",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      )),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  isCreating = false;
                  isLoggin = true;
                });
              },
              child: isLoggin
                  ? const SizedBox(height: 0, width: 0)
                  : const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    )),
          isCreating
              ? ElevatedButton(
                  onPressed: createAccount,
                  child: const Text("Create an account"))
              : ElevatedButton(
                  onPressed: loginToFirebase, child: const Text("Login")),
        ]),
      ),
    );
  }

  Future<void> loginToFirebase() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail, password: userPassword);
    goToSearchView(userPseudo, userEmail);
  }

  Future<void> createAccount() async {
    if (userPassword == userConfirmPassword) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      goToSearchView(userPseudo, userEmail);
    } else {
      const snackBar = SnackBar(content: Text('Passwords are not the same'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void goToSearchView(String pseudo, String email) {
    fireBaseService.addUser(pseudo, email);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchMusicView(userPseudo)));
  }
}
