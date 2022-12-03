class Tracks{
  final String? trackName;
  final String? trackUrl;
  final String? trackArtist;

  Tracks({this.trackName, this.trackUrl, this.trackArtist});

  factory Tracks.fromJson(Map<String, dynamic> json){
    return Tracks(
      trackName: json[0]['trackName'],
      trackUrl: json[0]['trackUrl'],
      trackArtist: json[0]['artistName'],  
    );
  }
}