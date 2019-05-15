import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milestone/src/blocs/user/bloc.dart';
import 'package:milestone/src/blocs/user/state.dart';
import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/resources/api.dart';
import 'package:milestone/src/screens/users/edit_profile.dart';
import 'package:multipart_request/multipart_request.dart';

class ViewProfilePage extends StatefulWidget {
  ViewProfilePage({Key key}) : super(key: key);

  @override
  _ViewProfilePage createState() => _ViewProfilePage();
}

class _ViewProfilePage extends State<ViewProfilePage> {
  ApiProvider apiProvider = ApiProvider();
  UserBloc userBloc;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: userBloc,
      builder: (context, UserState state) {
        if (state.loaded == false) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(state.user.name),
            actions: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    return Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return EditProfilePage(shouldPop: true);
                      }),
                    );
                  },
                ),
                margin: EdgeInsets.only(right: 10.0),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: 'profile-image',
                      child: GestureDetector(
                        onTap: uploadImage,
                        child: Container(
                          child: ClipOval(
                            child: loading == true
                                ? CircularProgressIndicator()
                                : Image.network(
                                    "$baseUrl/users/${state.user.avatar}",
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${state.user.name.toUpperCase()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.0,
                            fontFamily: "TitilliumWeb-Regular",
                          ),
                        ),
                        Container(height: 5.0),
                        Text(
                          "${state.user.email}",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 18.0,
                            fontFamily: "TitilliumWeb-Regular",
                          ),
                        ),
                        Container(height: 20.0),
                        Text(
                          "${state.user.dob}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: "TitilliumWeb-Regular",
                          ),
                        ),
                        Container(height: 5.0),
                        Text(
                          "${state.user.gender}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontFamily: "TitilliumWeb-Regular",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      loading = true;
    });

    final Response response = await apiProvider.uploadAvatar(file);

    response.onError = () {
      setState(() {
        loading = false;
      });
    };

    response.onComplete = (response) {
      Map data = json.decode(response);
      userBloc.setAuthUser(data['user']);

      setState(() {
        loading = false;
      });
    };

    response.progress.listen((int progress) {
      print("progress from response object " + progress.toString());
    });
  }
}
