import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // ignore: unused_field
  Future<void> _launched;
  String _phone = "0174308473";
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
            "Contact Us",
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
                      child: Text("Drop us a message",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    child: Image.asset("assets/images/contactus.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[800],
                            offset: Offset(5.0, 8.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _launched = _makePhoneCall('tel:$_phone');
                                });
                              },
                              icon: Icon(Icons.phone)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _launched = _makePhoneCall('tel:$_phone');
                              });
                            },
                            child: Text(
                              "017-4308473",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 20),
                          IconButton(
                              onPressed: () {
                                launch(_emailLaunchUri.toString());
                              },
                              icon: Icon(Icons.email)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                launch(_emailLaunchUri.toString());
                              },
                              child: Text(
                                "	snackeverywhere@hubbuddies.com",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'snackeverywhere@hubbuddies.com',
      queryParameters: {'subject': 'Contact Us @ SnackEverywhere'});
}
