import 'package:flutter/material.dart';
import 'package:music_app/exception/exception.dart';
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
  ExceptionService exceptionService = ExceptionService();

  bool isCreating = false;
  bool isLoggin = false;
  bool success = false;
  String userEmail = "";
  String userPassword = "";
  String userConfirmPassword = "";
  String userPseudo = "";

  @override
  Widget build(BuildContext context) {
    fireBaseService.initializeDb();
    exceptionService.setContext(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Enter your e-mail and password",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100,
            width: 500,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
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
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
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
              : const SizedBox(height: 0, width: 0),
          isLoggin
              ? ElevatedButton(
                  onPressed: loginToFirebase, child: const Text("Login"))
              : const SizedBox(height: 0, width: 0),
        ]),
      ),
    );
  }

  Future<void> loginToFirebase() async {
    if (userEmail != "" && userPassword != "") {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: userEmail, password: userPassword);
        userPseudo = await fireBaseService.getPseudo(userEmail);
        goToSearchView(userPseudo, userEmail);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          exceptionService.showUserNotFoundException();
        }
        if (e.code == 'wrong-password') {
          exceptionService.showWrongPasswordException();
        }
        if (e.code == 'invalid-email') {
          exceptionService.showInvalidEmailException;
        }
      }
    } else {
      exceptionService.showEmptyFieldException;
    }
  }

  Future<void> createAccount() async {
    try {
      if (userPassword == userConfirmPassword &&
          await fireBaseService.checkIfPseudoExist(userPseudo) == false) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);
        goToSearchView(userPseudo, userEmail);
      } else {
        exceptionService.showPasswordNotMatchException;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        exceptionService.showWeakPasswordException;
      } else if (e.code == 'email-already-in-use') {
        exceptionService.showEmailAlreadyInUseException;
      }
      if (await fireBaseService.checkIfPseudoExist(userPseudo)) {
        exceptionService.showPseudoAlreadyExistException;
      }
    }
  }

  void goToSearchView(String pseudo, String email) {
    fireBaseService.addUser(pseudo, email);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchMusicView(userPseudo)));
  }
}
