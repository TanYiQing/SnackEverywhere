import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: Theme.of(context).cardColor),
      height: 40,
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [Icon(Icons.search), Text("Search")],
        ),
      ),
    );
  }
}
