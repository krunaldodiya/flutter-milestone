import 'package:meta/meta.dart';
import 'package:milestone/src/models/video.dart';

@immutable
class PlayerState {
  final bool loading;
  final bool loaded;
  final Map error;
  final Video video;
  final bool autoplay;

  PlayerState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.video,
    @required this.autoplay,
  });

  factory PlayerState.initial() {
    return PlayerState(
      loading: false,
      loaded: false,
      error: null,
      video: null,
      autoplay: false,
    );
  }

  PlayerState copyWith({
    bool loading,
    bool loaded,
    Map error,
    Video video,
    bool autoplay,
  }) {
    return PlayerState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      video: video ?? this.video,
      autoplay: autoplay ?? this.autoplay,
    );
  }
}
