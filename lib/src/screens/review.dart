import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone/src/blocs/user/bloc.dart';
import 'package:milestone/src/blocs/user/state.dart';
import 'package:milestone/src/helpers/vars.dart';

class Review extends StatefulWidget {
  @override
  _Review createState() => _Review();
}

class _Review extends State<Review> with SingleTickerProviderStateMixin {
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
      backgroundColor: Color(0xff003333),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Request Pending".toUpperCase()),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder(
                bloc: userBloc,
                builder: (context, UserState state) {
                  return Text(
                    "Hello, ${state.user?.name}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                      fontFamily: "TitilliumWeb-SemiBold",
                    ),
                  );
                },
              ),
              Container(height: 30.0),
              Text(
                "Your account is being review by our team, please, wait for few hours.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontFamily: "TitilliumWeb-Regular",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
