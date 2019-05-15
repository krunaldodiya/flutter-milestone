import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone/src/blocs/player/bloc.dart';
import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/models/topic.dart';
import 'package:milestone/src/models/video.dart';
import 'package:milestone/src/screens/video_card.dart';
import 'package:video_player/video_player.dart';

class VideosPage extends StatefulWidget {
  final Topic topic;
  final Video video;

  VideosPage({
    Key key,
    @required this.topic,
    @required this.video,
  }) : super(key: key);

  @override
  _VideosPage createState() => _VideosPage();
}

class _VideosPage extends State<VideosPage> {
  PlayerBloc playerBloc;
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    setState(() {
      playerBloc = BlocProvider.of<PlayerBloc>(context);

      if (widget.video != null) {
        controller = VideoPlayerController.network(widget.video.url);
      }
    });
  }

  @override
  void dispose() {
    setPortrait();

    if (widget.video != null) {
      controller.dispose();
    }

    super.dispose();
  }

  setPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ChewieController getChewieController = chewieController();

    getChewieController.addListener(() {
      if (getChewieController.isFullScreen) {
        setLandscape();
      } else {
        setPortrait();
      }
    });

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(widget.topic.name),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: widget.video == null
            ? Center(
                child: Text(
                  "No videos yet.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: "TitilliumWeb-SemiBold",
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Chewie(controller: getChewieController),
                  topicLabel(),
                  Expanded(
                    child: ListView(
                      children: getTopics(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  ChewieController chewieController() {
    return ChewieController(
      videoPlayerController: controller,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      autoPlay: true,
      showControls: true,
      allowedScreenSleep: false,
      placeholder: Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  List<Widget> getTopics() {
    List<Widget> data = [];

    if (widget.topic.videos.length == 0) {
      data.add(noTopics());
    } else {
      for (var video in widget.topic.videos) {
        data.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return VideosPage(
                      topic: widget.topic,
                      video: video,
                    );
                  },
                ),
              );
            },
            child: getVideoCard(
              video,
              video.id == widget.video.id,
            ),
          ),
        );
      }
    }

    return data;
  }

  Container topicLabel() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
      child: Text(
        "Videos".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-SemiBold",
        ),
      ),
    );
  }

  Container noTopics() {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Text(
        "No videos added yet.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-Regular",
        ),
      ),
    );
  }
}
