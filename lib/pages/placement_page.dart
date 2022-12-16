import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase/firebase.dart';
import '../firebase_options.dart';

class PlacementMusicView extends StatefulWidget {
  final String _username; 
  const PlacementMusicView(this._username,{Key? key}): super(key: key);
  @override
  State<PlacementMusicView> createState() => _PlacementMusicViewState();
} 

class _PlacementMusicViewState extends State<PlacementMusicView> {
  bool isLiked = false;
  late int numberLike;
  FireBaseService fireBaseService = FireBaseService();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    fireBaseService.initializeDb();
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
          return getList(snapshot);
          }
        },
      )
    );
  }

  ListView getList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) => 
      ListTile(
        leading: Text(index.toString()),
        title: Text(snapshot.data.docs[index]['trackName']+" - "+snapshot.data.docs[index]['artist']),
        subtitle: Text("Ajouté par "+snapshot.data.docs[index]['name']),
        trailing: SizedBox(
          child: Wrap(
            children: [
              initializeIconButton(snapshot, index),
              Text(fireBaseService.getLike(snapshot.data.docs[index]['name']).toString()),
            ],
          ),
        ),
            ),
    );
  }

  IconButton initializeIconButton(AsyncSnapshot<dynamic> snapshot, int index) {
    return isLiked ?  IconButton(
            icon: const Icon(Icons.favorite,color: Colors.red,),
            onPressed: () async {
              fireBaseService.removeLike(snapshot.data.docs[index]['name'], snapshot.data.docs[index]['trackName']);
            setState(() {
              isLiked = !isLiked;
            });
    },
  ) :  IconButton(
    icon: const Icon(Icons.favorite),
    onPressed: () async {
            setState(() {
              fireBaseService.addLike(snapshot.data.docs[index]['name'], snapshot.data.docs[index]['trackName']);
              isLiked = !isLiked;
            });
    }
  );
  }
}


