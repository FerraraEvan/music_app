import 'dart:convert';

import 'package:http/http.dart';
import 'package:music_app/models/tracks.dart';

class Itunes{

  List<Tracks> tracksList = [];

Future<void> getMusic(String term) async{
  String url = 'https://itunes.apple.com/search?term=$term&entity=song&limit=25&attribute=artistTerm';
  final Response response = await get(Uri.parse(url));
  final Map<String, dynamic> data = jsonDecode(response.body);
  createTracks(data);
  }
  
  Future<void> createTracks(Map<String, dynamic> data) async{
    for(int i =0; i < data['resultCount']; i++){
      Tracks tracks = Tracks(
        trackName: data['results'][i]['trackName'],
        trackUrl: data['results'][i]['trackViewUrl'],
        trackImage: data['results'][i]['artworkUrl30'],
        trackArtist: data['results'][i]['artistName'],
        trackAlbum: data['results'][i]['collectionViewUrl'],
        trackDuration: data['results'][i]['trackTimeMillis'].toString(),
      );
      tracksList.add(tracks);
    }
  }
  Future<List<Tracks>> getTracks() async{
    return tracksList;
  }
}
