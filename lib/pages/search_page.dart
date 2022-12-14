import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/blocs/tracks_bloc.dart';
import 'package:music_app/exception/exception.dart';
import 'package:music_app/firebase/firebase.dart';
import 'package:music_app/models/tracks.dart';
import 'package:music_app/pages/placement_page.dart';
import 'package:file_picker/file_picker.dart';
import '../blocs/tracks_states.dart';
import '../models/file.dart';

class SearchMusicView extends StatefulWidget {
  final String _username;
  const SearchMusicView(this._username, {Key? key}) : super(key: key);
  @override
  State<SearchMusicView> createState() => _SearchMusicViewState();
}

class _SearchMusicViewState extends State<SearchMusicView> {
  FileStorage api = FileStorage();
  late TracksBloc _bloc;
  AudioPlayer player = AudioPlayer();
  List<Tracks> trackList = [];
  bool isSelected = false;
  bool isPlaying = false;
  late String music;
  late String artist;
  late String name;
  late String username;
  late String id;
  FireBaseService fireBaseService = FireBaseService();
  ExceptionService exceptionService = ExceptionService();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    _bloc = TracksBloc(trackList);
    api.setTracks(_bloc);
    exceptionService.setContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TracksBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Music'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search Music',
                  ),
                  onChanged: (value) async => await api.getMusic(value)),
            ),
            BlocBuilder<TracksBloc, TracksState>(
              builder: (context, state) {
                if (state.tracks.isNotEmpty) {
                  return getListTracks(state);
                } else {
                  player.pause();
                  return Container(
                      padding: const EdgeInsets.only(top: 50),
                      child: const Text("Search a song..."));
                }
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Visibility(
                  visible: isSelected,
                  child: ElevatedButton(
                      onPressed: () async {
                        fireBaseService.initializeApp();
                        fireBaseService.initializeDb();
                        fireBaseService.addToPlaylist(music, widget._username, artist, name, id);
                        exceptionService.showSnackBar("Added to playlist");
                        },
                      child: const Text('Add to playlist'))),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: () {
                    player.pause();
                    goToPlacementPage(context);
                  },
                  child: const Text('Go to playlist')),
            ),
            const ElevatedButton(
                onPressed: uploadFile, child: Text("Upload file"))
          ],
        ),
      ),
    );
  }

  Future<dynamic> goToPlacementPage(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlacementMusicView(widget._username)));
  }

  Expanded getListTracks(TracksState state) {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: state.tracks.length,
          itemBuilder: (context, index) {
            return ListTile(
                tileColor: state.tracks[index].getSelected
                    ? Colors.blue
                    : Colors.white,
                title: Text(state.tracks[index].trackName!),
                subtitle: Text(state.tracks[index].trackArtist!),
                trailing: state.tracks[index].getIsPlaying
                    ? IconButton(
                        icon: const Icon(Icons.pause),
                        onPressed: () {
                          setState(() {
                            state.tracks[index].setIsPlaying(false);
                          });
                          player.pause();
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () {
                          setState(() {
                            state.tracks[index].setIsPlaying(true);

                            for (int i = 0; i < state.tracks.length; i++) {
                              if (state.tracks[i] != state.tracks[index]) {
                                state.tracks[i].setIsPlaying(false);
                              }
                            }
                          });
                          playMusic(state, index);
                        }),
                onTap: () => setState(() {
                      setCurrentInfo(state, index);
                      isSelected = true;
                      for (int i = 0; i < state.tracks.length; i++) {
                        if (state.tracks[i] != state.tracks[index]) {
                          state.tracks[i].setSelected(false);
                        }
                      }
                    }));
          },
        ),
      ),
    );
  }

  void setCurrentInfo(TracksState state, int index) {
    state.tracks[index].setSelected(!state.tracks[index].isSelected!);
    music = state.tracks[index].trackUrl!;
    artist = state.tracks[index].trackArtist!;
    name = state.tracks[index].trackName!;
    id = state.tracks[index].id!;
    isSelected = !isSelected;
  }

  Future<void> playMusic(TracksState state, int index) async {
    await player.setAudioSource(
        AudioSource.uri(Uri.parse(state.tracks[index].trackUrl!)));
    await player.load();
    await player.setClip(
        start: const Duration(seconds: 60), end: const Duration(seconds: 70));
    await player.play();
  }
}

Future<void> uploadFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['mp3'],
  );
  if (result != null) {
    String trackName = result.files.single.name.split('.').first;
    File file = File(result.files.single.path!);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(trackName);
    ref.putFile(file);
  }
}
