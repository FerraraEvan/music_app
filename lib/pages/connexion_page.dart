import 'package:flutter/material.dart';
import 'package:music_app/pages/search_page.dart';
import '../firebase/firebase.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key, required this.title});
  final String title;

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
FireBaseService fireBaseService = FireBaseService();

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
                padding:const EdgeInsets.only(bottom: 20),
                child: const Text(
                  "Enter your pseudo",
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
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pseudo',
                  ),
                  onSubmitted: (String value) {
                    if(value != ""){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchMusicView(value)),
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pseudo non valide'),
                        ),
                      );
                    }
                  }
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
