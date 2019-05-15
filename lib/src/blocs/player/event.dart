import 'package:milestone/src/models/video.dart';

abstract class PlayerEvent {}

class SetVideo extends PlayerEvent {
  final Video video;

  SetVideo({this.video});
}
