import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/feedbackReceive.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/feedbackDetailScreen.dart';

class FeedbackReceivedScreen extends StatefulWidget {
  @override
  _FeedbackReceivedScreenState createState() => _FeedbackReceivedScreenState();
}

class _FeedbackReceivedScreenState extends State<FeedbackReceivedScreen> {
  double screenWidth;
  double screenHeight;
  List _feedbackList;
  String _titlecenter = "Loading...";
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  @override
  void initState() {
    super.initState();
    _loadFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
          "Feedback Received",
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: _feedbackList == null
                    ? Flexible(
                        child: Center(
                          child: Container(
                            height: 20.0,
                            child: AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText(_titlecenter,
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Theme.of(context).primaryColorDark))
                              ],
                              isRepeatingAnimation: true,
                            ),
                          ),
                        ),
                      )
                    : Flexible(
                        child: Center(
                          child: ListView(
                              children:
                                  List.generate(_feedbackList.length, (index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 5, right: 5, top: 1),
                              child: GestureDetector(
                                onTap: () {
                                  seeDetails(index);
                                },
                                child: Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 50,
                                          child: Column(
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        _feedbackList[index]
                                                                ["first_name"] +
                                                            " " +
                                                            _feedbackList[index]
                                                                ["last_name"],
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                    Text(_feedbackList[index]
                                                        ["email"]),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        df.format(DateTime.parse(
                                                            _feedbackList[index]
                                                                [
                                                                "date_feedback"])),
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                  ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(checkFeedback(
                                                      _feedbackList[index]
                                                          ["feedback"])),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red,
                                      icon: Icons.edit,
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
                                                              color:
                                                                  Colors.red)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        _deleteFeedback(index);
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
              )
            ],
          )),
    );
  }

  void _loadFeedbacks() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadFeedback.php"),
        body: {}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No Feedback";
        _feedbackList = null;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _feedbackList = jsondata["feedbacks"];
        setState(() {});
        print(_feedbackList);
      }
    });
  }

  String checkFeedback(String feedback) {
    if (feedback.length < 45) {
      return feedback;
    } else {
      return feedback.substring(0, 45) + "...";
    }
  }

  void seeDetails(int index) {
    FeedbackReceive feedbackreceive = new FeedbackReceive(
      feedback_id: _feedbackList[index]["feedback_id"],
      first_name: _feedbackList[index]["first_name"],
      last_name: _feedbackList[index]["last_name"],
      email: _feedbackList[index]["email"],
      feedback: _feedbackList[index]["feedback"],
      date_feedback: _feedbackList[index]["date_feedback"],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) =>
                FeedbackDetailScreen(feedbackReceive: feedbackreceive)));
  }

  void _deleteFeedback(int index) {
    String feedbackId = _feedbackList[index]["feedback_id"];
    print(feedbackId);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/deleteFeedback.php"),
        body: {
          "feedback_id": feedbackId,
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
                  child: Text("Feedback deleted successfully"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _loadFeedbacks();
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
                  child: Text("Feedback delete failed. Please try again"),
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
                        _deleteFeedback(index);
                      })
                ],
              );
            });
      }
    });
  }
}
