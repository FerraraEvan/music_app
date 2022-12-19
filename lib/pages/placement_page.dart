

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/firebase.dart';
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
        stream: FirebaseFirestore.instance.collection('track').orderBy('userLiked', descending: true).snapshots(),
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
      itemBuilder: (context, index) {
        checkIfLiked(snapshot, index);
      return ListTile(
        leading: Text(index.toString()),
        title: Text(snapshot.data.docs[index]['trackName']+" - "+snapshot.data.docs[index]['artist']),
        subtitle: Text("Ajouté par "+snapshot.data.docs[index]['name']),
        trailing: SizedBox(
          child: Wrap(
            children: [
              initializeIconButton(snapshot, index),
              Text(snapshot.data.docs[index]['userLiked'].length.toString()),
          ]),
        ),
      );
      },
    );
  }

  IconButton initializeIconButton(AsyncSnapshot<dynamic> snapshot, int index) {
    return isLiked ?  IconButton(
            icon: const Icon(Icons.favorite,color: Colors.red,),
            onPressed: () async {
              fireBaseService.removeLike(snapshot.data.docs[index]['name'], snapshot.data.docs[index]['trackName'], snapshot.data.docs[index]['id'], widget._username );
            setState(() {
              isLiked = !isLiked;
            }
      );
    },
  ) :  IconButton(
    icon: const Icon(Icons.favorite),
    onPressed: () async {
              fireBaseService.addLike(snapshot.data.docs[index]['name'], snapshot.data.docs[index]['trackName'], snapshot.data.docs[index]['id'], widget._username);
            setState(() {
              isLiked = !isLiked;
            });
    }
  );
  }

  Future<void> checkIfLiked(AsyncSnapshot<dynamic> snapshot, int index)async {
    if(snapshot.data.docs[index]['userLiked'].contains(widget._username)){
     isLiked = true;
  }
  else{
    isLiked = false;
  }
}
}


