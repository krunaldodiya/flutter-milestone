import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final VideoPlayerController controller;

  Player({
    Key key,
    @required this.controller,
  }) : super(key: key);

  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController: widget.controller,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      showControls: true,
      autoInitialize: true,
      allowedScreenSleep: false,
      allowFullScreen: true,
      allowMuting: true,
      fullScreenByDefault: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
    );

    return Chewie(
      controller: chewieController,
    );
  }
}
