import 'package:flutter/material.dart';
import 'package:snackeverywhere/Widget/bottombar.dart';
import 'package:snackeverywhere/Class/user.dart';

class PointScreen extends StatefulWidget {
  final User user;

  const PointScreen({Key key, this.user}) : super(key: key);
  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ]),
            ),
          ),
          title: Text(
            "Points",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Stack(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Container(
                  height: 220,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple[900], Colors.deepPurple]),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/celebrate1.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Container(
                            height: 70,
                            width: 130,
                            child: Image.asset("assets/images/celebrate.png"),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/profilepic.jpg")),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.user.first_name +
                                        " " +
                                        widget.user.last_name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Text(
                                "Your Balance:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                        "assets/images/trophy.png")),
                                Text(
                                  "256pts",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 50),
              Container(width: double.infinity, height: 300, child: tabpoints())
            ]),
          )
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget tabpoints() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepPurple[900],
            title: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rewards",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.trending_up_rounded)
                    ],
                  ),
                ),
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Recent Activities",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.history)
                  ],
                ))
              ],
            ),
          ),
          body: TabBarView(children: [
            Container(
              child: Text("Rewards"),
              height: 100,
              color: Colors.black,
            ),
            Container(child: Text("Recents"))
          ]),
        ));
  }
}
