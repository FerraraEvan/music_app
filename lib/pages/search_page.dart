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

  @override
  void initState() {
    super.initState();
    _bloc = TracksBloc(List<Tracks>.empty());
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
            TextField(onSubmitted: (value) async =>await api.getMusic()),
            BlocBuilder<TracksBloc, TracksState>(
              builder: (context, state) {
                return Text(state.tracks.length.toString());
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