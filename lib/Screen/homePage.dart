import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snackeverywhere/Screen/Category/nutsScreen.dart';
import 'package:snackeverywhere/Screen/searchScreen.dart';
import 'package:snackeverywhere/Screen/Category/candiesScreen.dart';
import 'package:snackeverywhere/Widget/drawer.dart';
import 'package:snackeverywhere/Screen/Category/plumsScreen.dart';
import 'package:snackeverywhere/Widget/searchBar.dart';
import 'package:snackeverywhere/Screen/Category/snackScreen.dart';
import 'package:snackeverywhere/Screen/Category/toysScreen.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:flip_card/flip_card.dart';
import 'package:animate_do/animate_do.dart';
import 'Category/allitemScreen.dart';
import 'Category/drinksScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

var scaffoldKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();
  List _cartList;
  double screenWidth;
  double screenHeight;

  @override
  void initState() {
    super.initState();
    _loadcart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: SlidingDrawer(user: widget.user),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ]),
          ),
        ),
        actions: [
          IconButton(
            icon: ClipOval(
              child: Container(
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
            ),
            onPressed: () {
              scaffoldKey.currentState.openEndDrawer();
            },
          )
        ],
        title: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => SearchScreen(user: widget.user)));
            },
            child: SearchBar()),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
        bottom: PreferredSize(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" Hey,", style: TextStyle(fontSize: 40)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "  " +
                            widget.user.first_name +
                            " " +
                            widget.user.last_name,
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            preferredSize: Size.fromHeight(70)),
      ),
      body: Center(
          child: StaggeredGridView.count(
        crossAxisCount: 6,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: EdgeInsets.all(8.0),
        staggeredTiles: [
          StaggeredTile.count(6, 0.5),
          StaggeredTile.count(6, 1),
          StaggeredTile.count(1, 1),
          StaggeredTile.count(1, 1),
          StaggeredTile.count(1, 1),
          StaggeredTile.count(1, 1),
          StaggeredTile.count(1, 1),
          StaggeredTile.count(1, 1),
          StaggeredTile.count(6, 0.5),
          StaggeredTile.count(6, 0.5),
          StaggeredTile.count(6, 4),
          StaggeredTile.count(6, 0.5),
          StaggeredTile.count(6, 4.5),
          StaggeredTile.count(6, 4.5),
          StaggeredTile.count(6, 4.5),
        ],
        children: <Widget>[
          Row(
            children: [
              Container(
                  child: Text("Categories",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Icon(Icons.clear_all_rounded)
            ],
          ),
          FadeInDown(
            child: GestureDetector(
              child: myImageButton(
                "assets/images/allitems.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) =>
                            AllItemScreen(user: widget.user)));
              },
            ),
          ),
          FadeInLeft(
            child: GestureDetector(
              child: myImageButton(
                "assets/images/chip.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => SnackScreen(user: widget.user)));
              },
            ),
          ),
          FadeInLeft(
            child: GestureDetector(
              child: myImageButton(
                "assets/images/toys.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ToysScreen(user: widget.user)));
              },
            ),
          ),
          FadeInLeft(
            child: GestureDetector(
              child: myImageButton(
                "assets/images/plum.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => PlumsScreen(user: widget.user)));
              },
            ),
          ),
          FadeInRight(
            child: GestureDetector(
              child: myImageButton(
                "assets/images/peanuts.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => NutsScreen(user: widget.user)));
              },
            ),
          ),
          FadeInRight(
            child: GestureDetector(
              child: myImageButton(
                "assets/images/soda.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => DrinksScreen(user: widget.user)));
              },
            ),
          ),
          FadeInRight(
            child: GestureDetector(
              child: myImageButton(
                "assets/images/lollipop.png",
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) =>
                            CandiesScreen(user: widget.user)));
              },
            ),
          ),
          Container(),
          Row(
            children: [
              Container(
                  child: Text("Special for YOU",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Icon(Icons.local_offer_outlined)
            ],
          ),
          CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Stack(children: [
                      Image.asset("assets/images/delivery.jpg",
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                            height: 80,
                            color: Colors.white.withOpacity(0.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Enjoy FREE delivery",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).focusColor)),
                                Text("for purchasing over RM200!",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).focusColor))
                              ],
                            )),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Stack(children: [
                      Image.asset("assets/images/raya.jpg",
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                            height: 80,
                            color: Colors.white.withOpacity(0.7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Enjoy 5% discount",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).focusColor)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("with promocode ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Theme.of(context).focusColor)),
                                    Text(
                                      "'RAYAFEST'",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Theme.of(context).focusColor),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                    ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Stack(children: [
                      Image.asset("assets/images/stayhome.jpg",
                          fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                            height: 80,
                            color: Colors.white.withOpacity(0.7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("It's dangerous outside...",
                                    style: TextStyle(
                                        fontSize: screenWidth / 20,
                                        color: Theme.of(context).focusColor)),
                                Container(
                                  width: screenWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("STAY at HOME, ",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).focusColor,
                                              fontSize: screenWidth / 30)),
                                      Text(
                                        "We DELIVER for YOU",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).focusColor,
                                            fontSize: screenWidth / 20),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ]),
                  ),
                ),
              ]),
          Row(
            children: [
              Container(
                  child: Text("Latest Information",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Icon(Icons.new_releases_outlined)
            ],
          ),
          FlipCard(
            direction: FlipDirection.VERTICAL,
            front: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800],
                        offset: Offset(5.0, 8.0),
                        blurRadius: 6.0,
                      ),
                    ], borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 280,
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/nowopen.jpg",
                          fit: BoxFit.cover,
                        ))),
                Positioned(
                    bottom: 280 / 2,
                    right: MediaQuery.of(context).size.width / 6,
                    child: Column(
                      children: [
                        Container(
                            color: Theme.of(context).primaryColor,
                            child: Text("Our Operating Hour",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ))
              ],
            ),
            back: Stack(children: [
              Container(
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800],
                        offset: Offset(5.0, 8.0),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.yellow[50],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Center(
                  child: Container(
                      height: 270,
                      width: 350,
                      child: Image.asset("assets/images/sell.png",
                          fit: BoxFit.cover))),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 80,
                        width: 80,
                        child: Image.asset("assets/images/Logo.png")),
                    Text("Operating Hours:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight)),
                    Text("Monday - Saturday",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColorLight)),
                    Text("8:00am - 6:00pm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColorLight)),
                  ],
                ),
              )
            ]),
          ),
          FlipCard(
            direction: FlipDirection.VERTICAL,
            front: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800],
                        offset: Offset(5.0, 8.0),
                        blurRadius: 6.0,
                      ),
                    ], borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 280,
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/covid.jpg",
                          fit: BoxFit.cover,
                        ))),
                Positioned(
                    bottom: 280 / 2,
                    right: MediaQuery.of(context).size.width / 10,
                    child: Column(
                      children: [
                        Container(
                            color: Theme.of(context).primaryColor,
                            child: Text("Getting Our SOPs RIGHT",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ))
              ],
            ),
            back: Stack(children: [
              Container(
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800],
                        offset: Offset(5.0, 8.0),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.yellow[50],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Center(
                  child: Column(
                children: [
                  SizedBox(height: 70),
                  Container(
                      height: 200,
                      width: 350,
                      child: Image.asset("assets/images/sop.png")),
                ],
              )),
              Center(
                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 80,
                          width: 80,
                          child: Image.asset("assets/images/Logo.png")),
                      Text("We practices the RIGHT SOPs",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorLight)),
                      Text("1. Scan QR Code with My Sejahtera",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorLight)),
                      Text("2. Measure body temperature",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorLight)),
                      Text("3. Sanitize hand",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorLight)),
                    ],
                  ),
                ),
              )
            ]),
          ),
          FlipCard(
            direction: FlipDirection.VERTICAL,
            front: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800],
                        offset: Offset(5.0, 8.0),
                        blurRadius: 6.0,
                      ),
                    ], borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 280,
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/map.jpeg",
                          fit: BoxFit.cover,
                        ))),
                Positioned(
                    bottom: 280 / 2,
                    right: MediaQuery.of(context).size.width / 4,
                    child: Column(
                      children: [
                        Container(
                            color: Theme.of(context).primaryColor,
                            child: Text("We are HERE",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ))
              ],
            ),
            back: Stack(children: [
              Container(
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800],
                        offset: Offset(5.0, 8.0),
                        blurRadius: 6.0,
                      ),
                    ],
                    color: Colors.yellow[50],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Center(
                  child: Container(
                      height: 270,
                      width: 350,
                      child: Image.asset("assets/images/location.png"))),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 80,
                        width: 80,
                        child: Image.asset("assets/images/Logo.png")),
                    Text("Our Location",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight)),
                    Text("95, Jalan Bunga Raya",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColorLight)),
                    Text("14000 Bukit Mertajam,",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColorLight)),
                    Text("Penang, Malaysia",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColorLight)),
                    Text("Contact Us",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight)),
                    Text("017-4308473",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColorLight)),
                  ],
                ),
              )
            ]),
          ),
        ],
      )),
    );
  }

  Widget myImageButton(source) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[800],
                offset: Offset(5.0, 8.0),
                blurRadius: 6.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(child: Image.asset(source)));
  }

  void _loadcart() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadCart.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "Cart Empty") {
        _cartList = null;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _cartList = jsondata["cart"];
        setState(() {});
        print(_cartList);
      }
    });
  }
}
