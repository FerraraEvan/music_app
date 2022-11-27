import 'package:flutter/material.dart';
import 'package:music_app/models/itunes.dart';
import 'package:music_app/pages/placement_page.dart';


class SearchMusicView extends StatefulWidget {
  final String _username; 
  const SearchMusicView(this._username, {Key? key}) : super(key: key);
  @override
  State<SearchMusicView> createState() => _SearchMusicViewState();
}

class _SearchMusicViewState extends State<SearchMusicView> {
  Itunes itunes = Itunes();

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
              onChanged: (value) => itunes.getMusic(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search Music',
              ),
            ),
            Expanded(child: FutureBuilder( //le ptoblème est ici
              future: itunes.getTracks(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].trackName),
                        subtitle: Text(snapshot.data[index].artistName),
                      );
                    },
                  );
                } else {
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