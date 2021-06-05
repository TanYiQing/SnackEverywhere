import 'package:flutter/material.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/userprofileScreen.dart';
import 'package:snackeverywhere/Screen/Setting/appearanceScreen.dart';
import 'package:snackeverywhere/Screen/Setting/feedbackScreen.dart';
import 'package:snackeverywhere/Screen/Setting/HelpCentre/helpcenterScreen.dart';
import 'package:snackeverywhere/Screen/Setting/pointScreen.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/shopownerhomePage.dart';

import '../Screen/loginScreen.dart';

class SlidingDrawer extends StatefulWidget {
  final User user;
  const SlidingDrawer({Key key, this.user}) : super(key: key);

  @override
  _SlidingDrawerState createState() => _SlidingDrawerState();
}

class _SlidingDrawerState extends State<SlidingDrawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: Drawer(
            child: Container(
          color: Colors.transparent,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: Container(
                      height: 200,
                      width: 200,
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/user.png"),
                                  fit: BoxFit.cover)),
                        ),
                      )),
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image:
                              new ExactAssetImage("assets/images/cover.jpg"))),
                  accountName: Text(
                      widget.user.first_name + " " + widget.user.last_name,
                      style: TextStyle(color: Colors.white)),
                  accountEmail: Text(widget.user.email,
                      style: TextStyle(color: Colors.white))),
              Container(
                  color: Colors.yellow[700],
                  child: ListTile(
                    title: Text("Profile",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    leading: Icon(Icons.perm_identity,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  UserProfileScreen(user: widget.user)));
                    },
                  )),
              SizedBox(height: 5),
              Container(
                  color: Colors.yellow[600],
                  child: ListTile(
                    title: Text(
                      "Point(s)",
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                    leading: Icon(Icons.assistant_photo_outlined,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  PointScreen(user: widget.user)));
                    },
                  )),
              SizedBox(height: 5),
              Container(
                  color: Colors.yellow,
                  child: ListTile(
                    title: Text("Appearance",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    leading: Icon(Icons.phone_android_rounded,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => AppearanceScreen()));
                    },
                  )),
              SizedBox(height: 5),
              Container(
                  color: Colors.yellow[400],
                  child: ListTile(
                    title: Text("Help Center",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    leading: Icon(Icons.help_outline_sharp,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  HelpCenterScreen(user: widget.user)));
                    },
                  )),
              SizedBox(height: 5),
              Container(
                  color: Colors.yellow[300],
                  child: ListTile(
                    title: Text("About Us",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    leading: Icon(Icons.supervised_user_circle_outlined,
                        color: Theme.of(context).primaryColorLight),
                  )),
              SizedBox(height: 5),
              Container(
                  color: Colors.yellow[200],
                  child: ListTile(
                    title: Text("Feedback",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    leading: Icon(Icons.feedback_outlined,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  FeedBackScreen(user: widget.user)));
                    },
                  )),
              SizedBox(height: 5),
              Container(
                  color: Colors.yellow[100],
                  child: ListTile(
                    title: Text("Sign in as show owner",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    leading: Icon(Icons.login,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => ShopOwnerHomePage(user: widget.user)));
                    },
                  )),
              SizedBox(height: 5),
              Container(
                  color: Colors.red,
                  child: ListTile(
                    title: Text("Log Out",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight)),
                    leading: Icon(Icons.logout,
                        color: Theme.of(context).primaryColorLight),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => LoginScreen()));
                    },
                  )),
            ],
          ),
        )));
  }
}
