import 'package:flutter/material.dart';
import 'package:music_app/pages/placement_page.dart';

import '../models/api.dart';


class SearchMusicView extends StatefulWidget {
  final String _username; 
  const SearchMusicView(this._username, {Key? key}) : super(key: key);
  @override
  State<SearchMusicView> createState() => _SearchMusicViewState();
}

class _SearchMusicViewState extends State<SearchMusicView> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Music'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            Text(
              widget._username,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
             TextField(
              onChanged: (value) => api.getMusic(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search Music',
              ),
            ),
            Expanded(child: FutureBuilder(
              future: api.getTracks(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        title: Text(snapshot.data[index].trackName),
                        subtitle: Text(snapshot.data[index].trackArtist),
                      );
                    },
                  );
                }else{
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
            Container(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PlacementMusicView()),
                    );
              }, child: const Text('Voir le classement'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}