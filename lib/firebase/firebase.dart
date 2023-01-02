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
    stream = db.collection("track").snapshots();
  }

  Future<void> addToPlaylist(String url, String name, String artist, String trackName,String id){
    return db.collection("track").add({
      'url': url,
      'name': name,
      'artist': artist, 
      'trackName': trackName,
      'id': id,
      'userLiked':[],
    });
  }
    Future<void> addUser(String pseudo, String email){
    return db.collection("user").add({
      'pseudo': pseudo,
      'email': email,
    });
  }
  Future<bool> isInDb(String name) async {
    return db.collection('user').where('name', isEqualTo: name).get().then((value) => value.docs.isNotEmpty);
  }

  Future<String> getLike(String name) async {
    return db.collection('track').where('name', isEqualTo: name).get().then((value) => value.docs.first.data()['like']);
  }

  Future<void> addLike(String name,String trackName,String id, String username) async {
    return db.collection("track")
    .where('name', isEqualTo: name) 
    .where('trackName', isEqualTo: trackName)
    .where('id', isEqualTo: id)
    .get().then((value) => value.docs.first.reference.update({'userLiked': FieldValue.arrayUnion([username])}));
    }

    Future<void> removeLike(String name,String trackName,String id, String username) async {
    return db.collection('track')
    .where('name', isEqualTo: name)
    .where('trackName', isEqualTo: trackName)
    .where('id', isEqualTo: id)
    .get().then((value) => value.docs.first.reference.update({'userLiked': FieldValue.arrayRemove([username])}));
  }

  Future<String> getPseudo(String email) async {
    return db.collection('user').where('email', isEqualTo: email).get().then((value) => value.docs.first.data()['pseudo']);
  }

  Future<bool> isCreated(String email) async {
    return db.collection('user').where('email', isEqualTo: email).get().then((value) => value.docs.isNotEmpty);
  }
}