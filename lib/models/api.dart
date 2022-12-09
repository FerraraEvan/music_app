import 'dart:convert';

import 'package:http/http.dart';
import 'package:music_app/blocs/tracks_bloc.dart';
import 'package:music_app/models/tracks.dart';


class Api{
  TracksBloc _bloc = TracksBloc(List<Tracks>.empty());

Future<void> getMusic() async{
  String url = 'http://localhost:4000/music?search=16';
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
      //_bloc.add(AddTracksEvent(tracks));
    }
  }
  
  Future<TracksBloc> getTracks() async{
    return _bloc;
    }

    void setTracks(TracksBloc bloc) {
      print("test");
      _bloc = bloc;
    }
  }
