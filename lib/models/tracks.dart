class Tracks{
  final String? trackName;
  final String? trackUrl;
  final String? trackArtist;
  final String? id;
  bool? isSelected=false;
  bool isPlaying = false;

  Tracks({this.trackName, this.trackUrl, this.trackArtist,this.isSelected, this.id});

  factory Tracks.fromJson(Map<String, dynamic> json){
    return Tracks(
      trackName: json[0]['trackName'],
      trackUrl: json[0]['trackUrl'],
      trackArtist: json[0]['artistName'],  
    );
  }

  setSelected(bool? isSelected){
    this.isSelected = isSelected;
  }

  get getSelected{
    return isSelected;
  } 

  get getIsPlaying {
    return isPlaying;
  }

  setIsPlaying(bool isPlaying) {
    this.isPlaying = isPlaying;
  }
}