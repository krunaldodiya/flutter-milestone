import 'package:flutter/material.dart';
import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/models/user.dart';
import 'package:milestone/src/screens/about.dart';
import 'package:milestone/src/screens/feedback.dart';

class DrawerPage extends StatelessWidget {
  final User user;

  const DrawerPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.name),
            accountEmail: Text(user.email),
            currentAccountPicture: Container(
              child: ClipOval(
                child: Image.network(
                  "$baseUrl/users/${user.avatar}",
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background.png"),
              ),
            ),
          ),
          ListTile(
            title: Text(
              appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              "About",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onTap: () async {
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AboutPage();
              }));
            },
          ),
          ListTile(
            title: Text(
              "Feedback",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.mail,
              color: Colors.white,
            ),
            onTap: () {
              // Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FeedbackPage(userId: user.id);
              }));
            },
          )
        ],
      ),
    );
  }
}
