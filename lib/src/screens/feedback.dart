import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:milestone/src/helpers/vars.dart';

class FeedbackPage extends StatefulWidget {
  final userId;

  FeedbackPage({@required this.userId});

  @override
  _FeedbackPage createState() => _FeedbackPage();
}

class _FeedbackPage extends State<FeedbackPage>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Feedback"),
      ),
      url: "$baseUrl/feedback?userId=${widget.userId}",
      scrollBar: true,
    );
  }
}
