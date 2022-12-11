import 'package:flutter/material.dart';
import 'package:music_app/pages/connexion_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  //FireBaseService fireBaseService = FireBaseService();
  //fireBaseService.initializeApp();
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

