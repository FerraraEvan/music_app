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
    stream = db.collection("user").snapshots();
  }
  Future<void> addUser(String name){
    return db.collection("user").add({
      'name': name,
    });
  }
  Future<void> addToPlaylist(String url, String name, String artist, String trackName,String id){
    return db.collection("track").add({
      'url': url,
      'name': name,
      'artist': artist, 
      'trackName': trackName,
      'like':0,
      'id': id,
    });
  }
  Future<bool> isInDb(String name) async {
    return db.collection('user').where('name', isEqualTo: name).get().then((value) => value.docs.isNotEmpty);
  }

  Future<String> getLike(String name) async {
    return db.collection('track').where('name', isEqualTo: name).get().then((value) => value.docs.first.data()['like']);
  }

  Future<void> addLike(String name,String trackName,String id) async {
    return db.collection('track')
    .where('name', isEqualTo: name)
    .where('trackName', isEqualTo: trackName)
    .where('id', isEqualTo: id)
    .get().then((value) => value.docs.first.reference.update({'like': value.docs.first.data()['like']+1}));
  }
  Future<void> removeLike(String name,String trackName,String id) async {
    return db.collection('track')
    .where('name', isEqualTo: name)
    .where('trackName', isEqualTo: trackName)
    .where('id', isEqualTo: id)
    .get().then((value) => value.docs.first.reference.update({'like': value.docs.first.data()['like']-1}));
  }
}