import '../models/tracks.dart';

class TracksEvent{}

class AddTracksEvent extends TracksEvent {
  final Tracks tracks;

  AddTracksEvent(this.tracks);
}

class RemoveTracksEvent extends TracksEvent {
  final Tracks tracks;

  RemoveTracksEvent(this.tracks);
}