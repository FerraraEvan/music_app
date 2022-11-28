import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class FireBaseService{

  late FirebaseFirestore db;
  late Stream<QuerySnapshot> stream;

  Future<FirebaseApp> initializeApp() async {
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  Future<void> initializeDb() async {
    db = FirebaseFirestore.instance;
    stream = db.collection("users").snapshots();
  }
  Future<void> addUser(String name){
    return db.collection("users").add({
      'name': name,
    });
  }
  Future<bool> isInDb(String name) async {
    return db.collection('users').where('name', isEqualTo: name).get().then((value) => value.docs.isNotEmpty);
  }
}