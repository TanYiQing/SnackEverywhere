import 'package:flutter/material.dart';
import 'package:snackeverywhere/Data/advanced_tile.dart';
import 'package:snackeverywhere/Screen/Setting/HelpCentre/contactusScreen.dart';
import 'package:snackeverywhere/Widget/bottombar.dart';
import 'package:snackeverywhere/Widget/advanced_tile.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
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
            "FAQ",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList.radio(
                children: advancedTiles
                    .map((tile) => ExpansionPanelRadio(
                        value: tile.title,
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) => buildTile(tile),
                        body: Column(
                          children: tile.tiles.map(buildTile).toList(),
                        )))
                    .toList()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/images/notsolve.png"),
                ),
                Row(
                  children: [
                    Text(
                      "Not solving your problem? You can ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (content)=>ContactUsScreen()));},
                          child:
                              Text("contact us", style: TextStyle(fontSize: 18,color:Colors.blue))),
                    ),
                  ],
                ),
                Text(
                  "for more support. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget buildTile(AdvancedTile tile) => ListTile(
        title: Text(
          tile.title,
          textAlign: TextAlign.justify,
        ),
      );
}
