import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/creditcardScreen.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Class/usercard.dart';

class CardListScreen extends StatefulWidget {
  final User user;

  const CardListScreen({Key key, this.user}) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  double screenHeight;
  double screenWidth;
  List _cardList;
  String _titlecenter = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadCard();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _addCard();
                },
              ),
            ],
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
              "Cards",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )),
        body: Center(
            child: Container(
                child: Column(children: [
          _cardList == null
              ? Flexible(
                  child: Center(
                      child: Container(
                  height: 20.0,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(_titlecenter,
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColorDark))
                    ],
                    isRepeatingAnimation: true,
                  ),
                )))
              : Flexible(
                  child: Center(
                    child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: (screenWidth / screenHeight) / 0.08,
                        children: List.generate(_cardList.length, (index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[800],
                                    offset: Offset(5.0, 10.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.30,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.credit_card_rounded),
                                          Text(
                                            _cardList[index]["card_number"],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ]),
                                  ),
                                ),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Edit',
                                    color: Colors.black45,
                                    icon: Icons.edit,
                                    onTap: () {
                                      _editCard(index);
                                    },
                                  ),
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Row(
                                                children: [
                                                  Container(
                                                      height: 25,
                                                      width: 25,
                                                      child: Image.asset(
                                                          "assets/images/Logo.png")),
                                                  Container(
                                                      child: Text(
                                                          "Confirm delete?")),
                                                ],
                                              ),
                                              content: Container(
                                                height: 70,
                                                child: Text(
                                                    "Are you sure to delete this?"),
                                              ),
                                              actions: [
                                                TextButton(
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blue)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                TextButton(
                                                    child: Text("Confirm",
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _deleteCard(index);
                                                    })
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                ),
        ]))));
  }

  void _loadCard() {
    String email = widget.user.email;
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadCard.php"),
        body: {
          "email": email,
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No Cards";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _cardList = jsondata["cards"];
        setState(() {});
      }
    });
  }

  void _deleteCard(int index) {
    String card_id = _cardList[index]["card_id"];// ignore: non_constant_identifier_names

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/deleteCard.php"),
        body: {
          "card_id": card_id,
        }).then((response) {
      print(response.body);
      if (response.body == "Success") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Container(
                        height: 25,
                        width: 25,
                        child: Image.asset("assets/images/Logo.png")),
                    Container(child: Text("Deleted")),
                  ],
                ),
                content: Container(
                  height: 25,
                  child: Text("Card deleted successfully"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _loadCard();
                        });
                      }),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Container(
                        height: 25,
                        width: 25,
                        child: Image.asset("assets/images/Logo.png")),
                    Container(child: Text("Opps...")),
                  ],
                ),
                content: Container(
                  height: 70,
                  child: Text("Card delete failed. Please try again"),
                ),
                actions: [
                  TextButton(
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child:
                          Text("Retry", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        _deleteCard(index);
                      })
                ],
              );
            });
      }
    });
  }

  void _editCard(index) {
    UserCard usercard = new UserCard(
      email: widget.user.email,
      card_id: _cardList[index]["card_id"],
      card_number: _cardList[index]["card_number"],
      card_holder: _cardList[index]["card_holder"],
      cvv: _cardList[index]["cvv"],
      month: _cardList[index]["month"],
      year: _cardList[index]["year"],
    );

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => CreditCardScreen(usercard: usercard)));
  }

  void _addCard() {
    UserCard usercard = new UserCard(
      email: widget.user.email,
      card_id: "",
      card_number: "",
      card_holder: "",
      cvv: "",
      month: "",
      year: "",
    );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => CreditCardScreen(usercard: usercard)));
  }
}
