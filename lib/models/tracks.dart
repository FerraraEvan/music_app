class Tracks{
  final String? trackName;
  final String? trackUrl;
  final String? trackImage;
  final String? trackArtist;
  final String? trackAlbum;
  final String? trackDuration;

  Tracks({this.trackName, this.trackUrl, this.trackImage, this.trackArtist, this.trackAlbum, this.trackDuration});

  factory Tracks.fromJson(Map<String, dynamic> json){
    return Tracks(
      trackName: json['results'][0]['trackName'],
      trackUrl: json['results'][0]['trackViewUrl'],
      trackImage: json['results'][0]['artworkUrl30'],
      trackArtist: json['results'][0]['artistName'],
      trackAlbum: json['results'][0]['collectionViewUrl'],
      trackDuration: json['results'][0]['trackTimeMillis'].toString(),
    );
  }
}