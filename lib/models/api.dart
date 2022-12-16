import 'dart:convert';

import 'package:http/http.dart';
import 'package:music_app/blocs/tracks_bloc.dart';
import 'package:music_app/models/tracks.dart';

import '../blocs/tracks_events.dart';


class Api{
  late TracksBloc _bloc;
  List<Tracks> trackList=[];

Future<void> getMusic(String term) async{
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
        isLiked: false
      );
      _bloc.add(AddTracksEvent(tracks)); 
    }
  }

    void setTracks(TracksBloc bloc) {
      _bloc = bloc;
    }
  }
