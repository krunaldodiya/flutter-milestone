import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:milestone/src/blocs/player/event.dart';
import 'package:milestone/src/blocs/player/state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  void setVideo(video) {
    dispatch(SetVideo(video: video));
  }

  @override
  PlayerState get initialState => PlayerState.initial();

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is SetVideo) {
      if (currentState.loaded == true) {
        yield currentState.copyWith(autoplay: true);
      }

      yield currentState.copyWith(
        loaded: true,
        loading: false,
        video: event.video,
      );
    }
  }
}
