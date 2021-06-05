import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/feedbackReceive.dart';

class FeedbackDetailScreen extends StatefulWidget {
  final FeedbackReceive feedbackReceive;

  const FeedbackDetailScreen({Key key, this.feedbackReceive}) : super(key: key);

  @override
  _FeedbackDetailScreenState createState() => _FeedbackDetailScreenState();
}

class _FeedbackDetailScreenState extends State<FeedbackDetailScreen> {
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
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
              "Feedback Details",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Theme.of(context).backgroundColor,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sender: " +
                              widget.feedbackReceive.first_name +
                              "" +
                              widget.feedbackReceive.last_name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColorDark),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sender Email: " + widget.feedbackReceive.email,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColorDark),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Feedback Date: " +
                              df.format(DateTime.parse(
                                  widget.feedbackReceive.date_feedback)),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColorDark),
                      Text(
                        "Feedback: ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            color: Theme.of(context).cardColor,
                            child: Container(
                              width: 400,
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.feedbackReceive.feedback),
                              ),
                            )),
                      )
                    ]),
              ),
            ),
          ),
        ));
  }
}
