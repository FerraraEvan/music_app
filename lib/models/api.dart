import 'dart:convert';

import 'package:http/http.dart';
import 'package:music_app/models/tracks.dart';

class Api{

  List<Tracks> tracksList = [];

Future<void> getMusic(String term) async{
  tracksList.clear();
  String url = 'http://localhost:4000/music?search=$term';
  final Response response = await get(Uri.parse(url));
  final List<dynamic> data = jsonDecode(response.body);
  createTracks(data);
  }
  
  Future<void> createTracks(List<dynamic> data) async{
    for(int i =0; i < data.length; i++){
      Tracks tracks = Tracks(
        trackName: data[i]['trackName'],
        trackUrl: data[i]['trackUrl'],
        trackArtist: data[i]['artistName'],
      );
      tracksList.add(tracks);
    }
  }
  
  Future<List<Tracks>> getTracks() async{
    print(tracksList.length);
    return tracksList;
    }
  }
