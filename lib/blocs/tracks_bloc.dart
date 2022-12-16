import 'package:music_app/blocs/tracks_events.dart';
import 'package:music_app/blocs/tracks_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/tracks.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  TracksBloc(List<Tracks> tracks) : super(TracksState(tracks)){
    on<AddTracksEvent>((event, emit) {
      final List<Tracks> tracks = state.tracks;
      tracks.add(event.tracks);
      emit(TracksState(tracks));
    });
    on<RemoveTracksEvent>((event, emit) {
      final List<Tracks> tracks = state.tracks;
      tracks.remove(event.tracks);
      emit(TracksState(tracks));
    });
  }
}