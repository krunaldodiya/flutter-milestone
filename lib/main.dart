import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone/src/blocs/category/bloc.dart';
import 'package:milestone/src/blocs/player/bloc.dart';
import 'package:milestone/src/blocs/register/bloc.dart';
import 'package:milestone/src/blocs/school/bloc.dart';
import 'package:milestone/src/blocs/user/bloc.dart';
import 'package:milestone/src/screens/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authToken = prefs.getString("authToken");
  // prefs.remove("authToken");

  runApp(
    BlocProviderTree(
      blocProviders: [
        BlocProvider<PlayerBloc>(bloc: PlayerBloc()),
        BlocProvider<UserBloc>(bloc: UserBloc()),
        BlocProvider<RegisterBloc>(bloc: RegisterBloc()),
        BlocProvider<SchoolBloc>(bloc: SchoolBloc()),
        BlocProvider<CategoryBloc>(bloc: CategoryBloc()),
      ],
      child: MyApp(authToken: authToken),
    ),
  );
}
