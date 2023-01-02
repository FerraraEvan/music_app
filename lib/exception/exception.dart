import 'package:flutter/material.dart';

class ExceptionService {
  late BuildContext context;

  setContext(BuildContext context) {
    this.context = context;
  }

  void showUserNotFoundException() {
    const snackBar = SnackBar(content: Text('No user found for that email.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showInvalidEmailException() {
    const snackBar =
        SnackBar(content: Text('The account already exists for that email.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showWeakPasswordException() {
    const snackBar =
        SnackBar(content: Text('The password provided is too weak.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showPasswordNotMatchException() {
    const snackBar =
        SnackBar(content: Text('The password provided is not the same'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showWrongPasswordException() {
    const snackBar =
        SnackBar(content: Text('Wrong password provided for that user.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showEmailAlreadyInUseException() {
    const snackBar =
        SnackBar(content: Text('The email address is badly formatted.'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showAddedToPlayList() {
    const snackBar = SnackBar(content: Text('Added to playlist'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
