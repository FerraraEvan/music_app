import 'package:flutter/material.dart';
import 'package:music_app/pages/search_page.dart';


void main() {

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const ConnexionPage(title: 'Music App'),
    );
  }
}

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key, required this.title});
  final String title;

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text(
                "Entrez votre pseudo",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            SizedBox(
              height:   100,
              width: 500,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pseudo',
                ),
                onSubmitted: (String value) {
                  if(value != "") {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchMusicView(value)),
                    ); 
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
