import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snackeverywhere/Widget/theme.dart';

class AppearanceScreen extends StatefulWidget {
  @override
  _AppearanceScreenState createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
            ),
          ),
          title: Text(
            "Appearance",
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Choose your preferred appearance theme.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Container(height: 20),
                Center(
                  child: Container(
                    height: 230,
                    width: 230,
                    child: Image.asset("assets/images/theme.png"),
                  ),
                ),
                Container(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<ThemeNotifier>(
                          builder: (context, notifier, child) => MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              height: 120,
                              minWidth: 120,
                              elevation: 10,
                              color: Colors.blue[200],
                              child: Column(
                                children: [
                                  Container(
                                      child: Icon(Icons.wb_sunny,
                                          color: Colors.orange[900])),
                                  Text("Light Mode",
                                      style:
                                          TextStyle(color: Colors.orange[900]))
                                ],
                              ),
                              onPressed: () {
                                notifier.toggleTheme1();
                              }),
                        ),
                        SizedBox(width: 30),
                        Consumer<ThemeNotifier>(
                          builder: (context, notifier, child) => MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              height: 120,
                              minWidth: 120,
                              elevation: 10,
                              color: Colors.blue[900],
                              child: Column(
                                children: [
                                  Container(
                                      child: Icon(
                                    Icons.nightlight_round,
                                    color: Colors.yellow,
                                  )),
                                  Text("Dark Mode",
                                      style: TextStyle(color: Colors.yellow))
                                ],
                              ),
                              onPressed: () {
                                notifier.toggleTheme();
                              }),
                        ),
                        
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
     
    );
  }
}
