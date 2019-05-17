import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:milestone/src/blocs/user/bloc.dart';
import 'package:milestone/src/helpers/initial_screen.dart';
import 'package:milestone/src/helpers/validation.dart';
import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/models/school.dart';
import 'package:milestone/src/screens/review.dart';
import 'package:milestone/src/screens/users/editable.dart';
import 'package:milestone/src/screens/users/profile/gender.dart';
import 'package:milestone/src/screens/users/profile/school.dart';
import 'package:milestone/src/screens/users/tappable.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class EditProfilePage extends StatefulWidget {
  final bool shouldPop;

  EditProfilePage({Key key, @required this.shouldPop}) : super(key: key);

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  UserBloc userBloc;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController educationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      userBloc = BlocProvider.of<UserBloc>(context);
    });

    nameController.text = userBloc.currentState.user.name;
    emailController.text = userBloc.currentState.user.email;
    dobController.text = userBloc.currentState.user.dob;
    genderController.text = userBloc.currentState.user.gender;
    schoolController.text = userBloc.currentState.user.school.name;
    educationController.text = userBloc.currentState.user.education;
  }

  Widget getLeadingIcon() {
    if (widget.shouldPop == true) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }

    return Icon(Icons.person);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003333),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Edit Profile"),
        leading: getLeadingIcon(),
        actions: <Widget>[
          BlocBuilder(
            bloc: userBloc,
            builder: (context, state) {
              return FlatButton(
                onPressed: () => onSubmit(state),
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'TitilliumWeb-SemiBold',
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(height: 20.0),
              BlocBuilder(
                bloc: userBloc,
                builder: (context, state) {
                  return EditableFormField(
                    controller: nameController,
                    labelText: "Full Name",
                    errorText: getErrorText(state, 'name'),
                    onChanged: (name) {
                      userBloc.updateState("name", name);
                    },
                  );
                },
              ),
              BlocBuilder(
                bloc: userBloc,
                builder: (context, state) {
                  return EditableFormField(
                    controller: emailController,
                    labelText: "Email Address",
                    errorText: getErrorText(state, 'email'),
                    onChanged: (email) {
                      userBloc.updateState("email", email);
                    },
                  );
                },
              ),
              GestureDetector(
                onTap: () async {
                  final String userDob = userBloc.currentState.user.dob;
                  List dateList = userDob.split("-");
                  DateTime intialDob = DateTime(
                    int.parse(dateList[2]),
                    int.parse(dateList[1]),
                    int.parse(dateList[0]),
                  );

                  final DateTime dob = await showDatePicker(
                    initialDatePickerMode: DatePickerMode.day,
                    context: context,
                    initialDate: intialDob,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (dob != null) {
                    String formattedDob = DateFormat('dd-MM-yyyy').format(dob);
                    setState(() => dobController.text = formattedDob);
                    userBloc.updateState("dob", formattedDob);
                  }
                },
                child: BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    return TappableFormField(
                      controller: dobController,
                      labelText: "Date of Birth",
                      errorText: getErrorText(state, "dob"),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final String gender = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return ChooseGender();
                    }),
                  );

                  setState(() {
                    genderController.text = gender;
                  });
                },
                child: BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    return TappableFormField(
                      controller: genderController,
                      labelText: "Gender",
                      errorText: getErrorText(state, "gender"),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final School school = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return ChooseSchool();
                    }),
                  );

                  if (school != null) {
                    setState(() {
                      schoolController.text = school.name;
                    });
                  }
                },
                child: BlocBuilder(
                  bloc: userBloc,
                  builder: (context, state) {
                    return TappableFormField(
                      controller: schoolController,
                      labelText: "School",
                      errorText: getErrorText(state, "school_id"),
                    );
                  },
                ),
              ),
              BlocBuilder(
                bloc: userBloc,
                builder: (context, state) {
                  return EditableFormField(
                    controller: educationController,
                    labelText: "Education",
                    errorText: getErrorText(state, 'education'),
                    onChanged: (education) {
                      userBloc.updateState("education", education);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit(state) {
    XsProgressHud.show(context);

    userBloc.updateProfile((success) {
      XsProgressHud.hide();

      if (success == true) {
        if (widget.shouldPop == true) {
          return Navigator.of(context).pop();
        }

        Widget screen = state.user.accountStatus == "Pending"
            ? Review()
            : getInitialScreen(true, state);

        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => screen),
        );
      }
    });
  }
}
