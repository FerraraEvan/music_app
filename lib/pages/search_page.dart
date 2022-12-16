import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/blocs/tracks_bloc.dart';
import 'package:music_app/firebase/firebase.dart';
import 'package:music_app/models/tracks.dart';
import 'package:music_app/pages/placement_page.dart';

import '../blocs/tracks_states.dart';
import '../models/api.dart';


class SearchMusicView extends StatefulWidget {
  final String _username; 
  const SearchMusicView(this._username, {Key? key}) : super(key: key);
  @override
  State<SearchMusicView> createState() => _SearchMusicViewState();
}

class _SearchMusicViewState extends State<SearchMusicView> {
  Api api = Api();
  late TracksBloc _bloc;
  AudioPlayer player = AudioPlayer();
  List<Tracks> trackList=[];
  bool isSelected = false;
  bool isPlaying = false;
  late String music;
  late String artist;
  late String name;
  late String username;
  late String id;
  FireBaseService fireBaseService = FireBaseService();
  
  
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    _bloc = TracksBloc(trackList);
    api.setTracks(_bloc);
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
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search Music',
              ),
              onChanged: (value) async =>await api.getMusic(value)),
            BlocBuilder<TracksBloc, TracksState>(
              builder: (context, state) {
                if(state.tracks.isNotEmpty){
                return getListTracks(state);
                }
                else{
                  return Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: const Text("Search a song..."));
                }
              }
              ,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Visibility(visible: isSelected, child: ElevatedButton(
                onPressed: () async {
                  fireBaseService.initializeApp();
                  fireBaseService.initializeDb();
                  fireBaseService.addToPlaylist(music, widget._username, artist, name,id);
                }, 
                child: const Text('Add to playlist')
              )),
            ),
            Container(
              padding: const  EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: ()=>
                goToPlacementPage(context),
              child: const Text('Go to playlist')
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> goToPlacementPage(BuildContext context) {
    return Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlacementMusicView(widget._username)));
  }

  ListView getListTracks(TracksState state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.tracks.length,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: state.tracks[index].getLiked ? Colors.blue : Colors.white,
          title: Text(state.tracks[index].trackName!),
          subtitle: Text(state.tracks[index].trackArtist!),
          trailing: isPlaying ?  IconButton(
            icon: const Icon(Icons.pause),
            onPressed: (){
              setState(() {
                isPlaying = !isPlaying;
              });
            player.pause();
            },
          ) :  IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: (){
              setState(() {
                isPlaying = !isPlaying;
              });
              player.setUrl(state.tracks[index].trackUrl!);
              player.play();
            }
          ),
          onTap: () => setState(() {
            state.tracks[index].setLiked(!state.tracks[index].isLiked!);
            music = state.tracks[index].trackUrl!;
            artist = state.tracks[index].trackArtist!;
            name = state.tracks[index].trackName!;
            id=state.tracks[index].id!;
            isSelected = !isSelected;
          }
        )
        );
      },
    );
  }
}