import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../firebase_options.dart';

class PlacementMusicView extends StatefulWidget {
  const PlacementMusicView({super.key});


  @override
  State<PlacementMusicView> createState() => _PlacementMusicViewState();
} 

class _PlacementMusicViewState extends State<PlacementMusicView> {
  bool isLiked = false;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placement Music'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) 
        {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          else{
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) => 
            ListTile(
              leading: Text(index.toString()),
              title: Text(snapshot.data.docs[index]['trackName']+" - "+snapshot.data.docs[index]['artist']),
              subtitle: Text("Ajouté par "+snapshot.data.docs[index]['name']),
              trailing: isLiked ?  IconButton(
            icon: const Icon(Icons.favorite,color: Colors.red,),
            onPressed: (){
              setState(() {
                isLiked = !isLiked;
              });
            },
          ) :  IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: (){
              setState(() {
                isLiked = !isLiked;
              });
            }
          ),
        ),
          );
          }
        },
      )
    );
  }
}

void getData() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}