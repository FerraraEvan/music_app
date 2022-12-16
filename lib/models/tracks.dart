import 'package:uuid/uuid.dart';

class Tracks{
  final String? trackName;
  final String? trackUrl;
  final String? trackArtist;
  final String? id;
  bool? isLiked=false;
  Tracks({this.trackName, this.trackUrl, this.trackArtist,this.isLiked, this.id});

  factory Tracks.fromJson(Map<String, dynamic> json){
    return Tracks(
      trackName: json[0]['trackName'],
      trackUrl: json[0]['trackUrl'],
      trackArtist: json[0]['artistName'],  
      isLiked: false
    );
  }

  setLiked(bool? isLiked){
    this.isLiked = isLiked;
  }

  get getLiked{
    return isLiked;
  } 
}