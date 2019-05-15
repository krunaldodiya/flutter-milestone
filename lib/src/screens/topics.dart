import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone/src/blocs/user/bloc.dart';
import 'package:milestone/src/blocs/user/state.dart';
import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/models/category.dart';
import 'package:milestone/src/screens/topic_card.dart';
import 'package:milestone/src/screens/videos.dart';

class TopicsPage extends StatefulWidget {
  final Category category;

  TopicsPage({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _TopicsPage createState() => _TopicsPage();
}

class _TopicsPage extends State<TopicsPage> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocBuilder(
        bloc: userBloc,
        builder: (context, UserState state) {
          if (state.loaded == false) {
            return Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  expandedHeight: 240.0,
                  backgroundColor: primaryColor,
                  title: Text(widget.category.name),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: widget.category.id,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.dstATop,
                            ),
                            image: NetworkImage(
                              "$baseUrl/storage/${widget.category.image}",
                            ),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(getTopics()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> getTopics() {
    List<Widget> data = [];

    data.add(topicLabel());

    if (widget.category.topics.length == 0) {
      data.add(noTopics());
    } else {
      for (var topic in widget.category.topics) {
        data.add(
          getTopicCard(topic, () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return VideosPage(
                topic: topic,
                video: topic.videos.length > 0 ? topic.videos[0] : null,
              );
            }));
          }),
        );
      }
    }

    return data;
  }

  Container topicLabel() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
      child: Text(
        "Topics".toUpperCase(),
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
        "No topics added yet.",
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
