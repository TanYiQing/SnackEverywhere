import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/userprofileScreen.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/cartListScreen.dart';
import 'package:snackeverywhere/Screen/homePage.dart';

class BottomBar extends StatefulWidget {
  final User user;

  const BottomBar({Key key, this.user}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  List<Widget> list;

  @override
  void initState() {
    list = [
      HomePage(
        user: widget.user,
      ),
      CartListScreen(
        user: widget.user,
      ),
      UserProfileScreen(
        user: widget.user,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: list.elementAt(currentIndex),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).accentColor,
        color: Theme.of(context).primaryColorDark,
        items: [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(icon: Icons.shopping_cart, title: 'Cart'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 0, //optional, default as 0
        onTap: onTabTapped,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
