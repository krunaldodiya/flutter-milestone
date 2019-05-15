import 'package:flutter/material.dart';

class NoNetwork extends StatefulWidget {
  @override
  _NoNetwork createState() => _NoNetwork();
}

class _NoNetwork extends State<NoNetwork> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003333),
      body: SafeArea(
        child: Center(
          child: Text(
            "No Internet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontFamily: "TitilliumWeb-Regular",
            ),
          ),
        ),
      ),
    );
  }
}
