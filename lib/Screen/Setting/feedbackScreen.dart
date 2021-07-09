import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;

class FeedBackScreen extends StatefulWidget {
  final User user;

  const FeedBackScreen({Key key, this.user}) : super(key: key);

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
  static int feedbackId = 00000;
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController _feedbackController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary]),
            ),
          ),
          title: Text(
            "Feedback",
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
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Do you have any feedback to us?",
                          style:
                              TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Container(
                  child: Image.asset("assets/images/feedback.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[800],
                          offset: Offset(5.0, 8.0),
                          blurRadius: 6.0,
                        ),
                      ],
                      color: Theme.of(context).cardColor,
                    ),
                    child: TextField(
                      
                      controller: _feedbackController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Tell us more...",
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      maxLength: 150,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 100,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.orange[800],
                            onPressed: () {
                              _onSend();
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Send",style:TextStyle(color: Colors.white)),
                                  SizedBox(width: 10),
                                  Icon(Icons.send_sharp,color: Colors.white)
                                ]),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSend() {
    String firstname = widget.user.first_name;
    String lastname = widget.user.last_name;
    String email = widget.user.email;
    String feedback = _feedbackController.text.toString();
    print(firstname);
    print(lastname);
    print(email);
    print(feedback);

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/feedback.php"),
        body: {
          "firstName": firstname,
          "lastName": lastname,
          "email": email,
          "feedback": feedback
        }).then((response) {
      print(response.body);
      if (response.body == "Success") {}
    });
  }
}
