import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:milestone/src/helpers/vars.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("About Us"),
      ),
      url: "$baseUrl/about",
      scrollBar: true,
    );
  }
}
