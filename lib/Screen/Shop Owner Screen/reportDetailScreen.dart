import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/reportReceive.dart';

class ReportDetailScreen extends StatefulWidget {
  final ReportReceive reportReceive;

  const ReportDetailScreen({Key key, this.reportReceive}) : super(key: key);

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
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
              "Issue Details",
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
                              widget.reportReceive.first_name +
                              "" +
                              widget.reportReceive.last_name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColorDark),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sender Email: " + widget.reportReceive.email,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColorDark),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Report Date: " +
                              df.format(DateTime.parse(
                                  widget.reportReceive.date_report)),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColorDark),
                      Text(
                        "Issue: ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            color: Theme.of(context).cardColor,
                            child: Container(
                              width: 400,
                              height: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.reportReceive.issue),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((content) =>
                                                  DetailScreen(
                                                      reportReceive: widget
                                                          .reportReceive))));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Hero(
                                            tag: 'imageHero',
                                            child: Container(
                                                height: 50,
                                                width: 50,
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "https://hubbuddies.com/270607/snackeverywhere/images/report_issue/${widget.reportReceive.report_id}.png")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
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

class DetailScreen extends StatefulWidget {
  final ReportReceive reportReceive;

  const DetailScreen({Key key, this.reportReceive}) : super(key: key);
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
              tag: 'imageHero',
              child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl:
                      "https://hubbuddies.com/270607/snackeverywhere/images/report_issue/${widget.reportReceive.report_id}.png")),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
