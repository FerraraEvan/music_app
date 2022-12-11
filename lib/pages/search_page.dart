import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/blocs/tracks_bloc.dart';
import 'package:music_app/models/tracks.dart';

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
  List<Tracks> trackList=[];
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
            TextField(onChanged: (value) async =>await api.getMusic(value)),
            BlocBuilder<TracksBloc, TracksState>(
              builder: (context, state) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.tracks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.tracks[index].trackName!),
                      subtitle: Text(state.tracks[index].trackArtist!),
                      trailing: IconButton(icon: const Icon(Icons.play_arrow),
                      onPressed: () {  },),);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*class TracksListView extends StatelessWidget {
  const TracksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Api api = Api();
    
  }
}*/