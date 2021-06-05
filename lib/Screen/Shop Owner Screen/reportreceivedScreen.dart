import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/reportReceive.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/reportDetailScreen.dart';

class ReportReceiveScreen extends StatefulWidget {
  @override
  _ReportReceiveScreenState createState() => _ReportReceiveScreenState();
}

class _ReportReceiveScreenState extends State<ReportReceiveScreen> {
  double screenWidth;
  double screenHeight;
  List _issueList;
  String _titlecenter = "Loading...";
  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    _loadIssues();
  }

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
          "Reported Issues",
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
                child: _issueList == null
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
                                  List.generate(_issueList.length, (index) {
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
                                                        _issueList[index]
                                                                ["first_name"] +
                                                            " " +
                                                            _issueList[index]
                                                                ["last_name"],
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                    Text(_issueList[index]
                                                        ["email"]),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        df.format(DateTime
                                                            .parse(_issueList[
                                                                    index][
                                                                "date_report"])),
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                  ]),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(checkIssue(
                                                      _issueList[index]
                                                          ["issue"])),
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
                                                        _deleteIssue(index);
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

  void _loadIssues() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadReport.php"),
        body: {}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No Issue Reported";
        _issueList = null;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _issueList = jsondata["issues"];
        setState(() {});
        print(_issueList);
      }
    });
  }

  String checkIssue(String issue) {
    if (issue.length < 45) {
      return issue;
    } else {
      return issue.substring(0, 45) + "...";
    }
  }

  void _deleteIssue(int index) {
    String reportId = _issueList[index]["report_id"];
    print(reportId);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/deleteIssue.php"),
        body: {
          "report_id": reportId,
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
                  child: Text("Issue deleted successfully"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _loadIssues();
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
                  child: Text("Issue delete failed. Please try again"),
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
                        _deleteIssue(index);
                      })
                ],
              );
            });
      }
    });
  }

  void seeDetails(int index) {
    ReportReceive reportreceive = new ReportReceive(
      report_id: _issueList[index]["report_id"],
      first_name: _issueList[index]["first_name"],
      last_name: _issueList[index]["last_name"],
      email: _issueList[index]["email"],
      issue: _issueList[index]["issue"],
      date_report: _issueList[index]["date_report"],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) =>
                ReportDetailScreen(reportReceive: reportreceive)));
  }
}
