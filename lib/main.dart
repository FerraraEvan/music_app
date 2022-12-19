import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:music_app/firebase_options.dart';
import 'package:music_app/pages/connexion_page.dart';

late FirebaseFirestore db;
late Stream<QuerySnapshot> stream;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const ConnexionPage(title: 'Music App'),
    );
  }
}

