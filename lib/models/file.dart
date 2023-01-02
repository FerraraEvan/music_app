import 'package:firebase_storage/firebase_storage.dart';
import 'package:music_app/blocs/tracks_bloc.dart';
import 'package:music_app/models/tracks.dart';
import 'package:uuid/uuid.dart';
import '../blocs/tracks_events.dart';


class FileStorage{
  late TracksBloc _bloc;
  List<Tracks> trackList=[];
  Uuid uuid = const Uuid();


  void setTracks(TracksBloc bloc) {
    _bloc = bloc;
  }

    Future<void> getMusic(String term) async {
    _bloc.add(ClearTracksEvent());

    if (term != '') {
      final storageRef = FirebaseStorage.instance.ref();
      final listResult = await storageRef.listAll();

      listResult.items.forEach((element) async {
        if (element.name.contains(term)) {
          final url = await element.getDownloadURL();
          final name = element.name;
          createTracks(url, name);
        }
      });
    }
  }

    Future<void> createTracks(String url, String name) async{
      final artist = name.split('-')[0];
      final trackName = name.split('-')[1];
      Tracks tracks = Tracks(
        trackName: trackName,
        trackUrl: url,
        trackArtist: artist,
        isSelected: false,
        id: uuid.v4()
      );
      _bloc.add(AddTracksEvent(tracks)); 
    }

    Future<void> uploadFile (String path) async{

    }
  }
