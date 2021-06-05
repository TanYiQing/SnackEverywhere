import 'package:flutter/material.dart';
import 'package:snackeverywhere/Screen/Setting/HelpCentre/contactusScreen.dart';
import 'package:snackeverywhere/Screen/Setting/HelpCentre/reportissueScreen.dart';
import 'package:snackeverywhere/Widget/bottombar.dart';
import 'package:snackeverywhere/Screen/Setting/HelpCentre/faqScreen.dart';

import 'package:snackeverywhere/Class/user.dart';

class HelpCenterScreen extends StatefulWidget {
  final User user;
  const HelpCenterScreen({Key key, this.user}) : super(key: key);
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
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
            "Help Center",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Stack(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary]),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                Container(
                  child: Text(
                      "   Hey, " +
                          widget.user.first_name +
                          " " +
                          widget.user.last_name,
                      style: TextStyle(fontSize: 20)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("How can we help you?",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    child: Image.asset("assets/images/customerservice.png"),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            height: 120,
                            minWidth: 120,
                            elevation: 10,
                            color: Colors.pinkAccent,
                            child: Column(
                              children: [
                                Container(child: Icon(Icons.forum_rounded,color: Theme.of(context).primaryColorLight)),
                                Text("FAQ",style: TextStyle(color:Theme.of(context).primaryColorLight))
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => FAQScreen()));
                            }),
                        SizedBox(width: 30),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            height: 120,
                            minWidth: 120,
                            elevation: 10,
                            color: Colors.blueAccent,
                            child: Column(
                              children: [
                                Container(child: Icon(Icons.report,color: Theme.of(context).primaryColorLight)),
                                Text("Report Issues",style: TextStyle(color:Theme.of(context).primaryColorLight))
                              ],
                            ),
                            onPressed: () { Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => ReportIssueScreen(user:widget.user)));}),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(  
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            height: 120,
                            minWidth: 120,
                            elevation: 10,
                            color: Colors.blue[900],
                            child: Column(
                              children: [
                                Container(child: Icon(Icons.phone,color: Theme.of(context).primaryColorLight)),
                                Text("Contact Us",style: TextStyle(color:Theme.of(context).primaryColorLight))
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => ContactUsScreen()));
                            }),
                        
                        
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
