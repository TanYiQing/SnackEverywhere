import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/addItemScreen.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/editItemScreen.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/feedbackReceivedScreen.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/orderreceivedScreen.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/reportreceivedScreen.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/stockScreen.dart';
import 'package:snackeverywhere/Widget/bottombar.dart';
import 'package:snackeverywhere/Widget/pieChartSections.dart';
import 'package:snackeverywhere/Widget/searchBar.dart';
import 'package:fl_chart/fl_chart.dart';

class ShopOwnerHomePage extends StatefulWidget {
  final User user;

  const ShopOwnerHomePage({Key key, this.user}) : super(key: key);
  @override
  _ShopOwnerHomePageState createState() => _ShopOwnerHomePageState();
}

class _ShopOwnerHomePageState extends State<ShopOwnerHomePage> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ]),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => BottomBar(user: widget.user)));
            },
          )
        ],
        title: SearchBar(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
        bottom: PreferredSize(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(" Hey,", style: TextStyle(fontSize: 40)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "  " +
                            widget.user.first_name +
                            " " +
                            widget.user.last_name,
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            preferredSize: Size.fromHeight(70)),
      ),
      body: Center(
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          padding: EdgeInsets.all(8.0),
          staggeredTiles: [
            StaggeredTile.count(4, 0.5),
            StaggeredTile.count(2, 2), //pie
            StaggeredTile.count(2, 2), //legend
            StaggeredTile.count(2, 2), //add
            StaggeredTile.count(2, 2), //edit
            StaggeredTile.count(2, 2), //stock
            StaggeredTile.count(2, 2), //order
            StaggeredTile.count(2, 2), //report
            StaggeredTile.count(2, 2), //feedback
          ],
          children: <Widget>[
            Row(
              children: [
                Container(
                    child: Text("Dashboard",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                Icon(Icons.apps_sharp)
              ],
            ),
            PieChart(PieChartData(
              centerSpaceRadius: 40,
              pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                setState(() {
                  final desiredTouch =
                      pieTouchResponse.touchInput is! PointerExitEvent &&
                          pieTouchResponse.touchInput is! PointerUpEvent;
                  if (desiredTouch && pieTouchResponse.touchedSection != null) {
                    touchedIndex =
                        pieTouchResponse.touchedSection.touchedSectionIndex;
                  } else {
                    touchedIndex = -1;
                  }
                });
              }),
              sections: getSections(touchedIndex),
            )),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(height: 8, width: 8, color: Colors.pink[600]),
                    SizedBox(width: 5),
                    Text("Candies")
                  ],
                ),
                Row(
                  children: [
                    Container(height: 8, width: 8, color: Colors.orange[400]),
                    SizedBox(width: 5),
                    Text("Drinks")
                  ],
                ),
                Row(
                  children: [
                    Container(height: 8, width: 8, color: Colors.teal[400]),
                    SizedBox(width: 5),
                    Text("Nuts")
                  ],
                ),
                Row(
                  children: [
                    Container(height: 8, width: 8, color: Colors.indigo[600]),
                    SizedBox(width: 5),
                    Text("Plums")
                  ],
                ),
                Row(
                  children: [
                    Container(height: 8, width: 8, color: Colors.purple),
                    SizedBox(width: 5),
                    Text("Snacks")
                  ],
                ),
                Row(
                  children: [
                    Container(height: 8, width: 8, color: Colors.black),
                    SizedBox(width: 5),
                    Text("Toys")
                  ],
                ),
              ],
            )),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) => AddItemScreen()));
              },
              child: Material(
                color: Theme.of(context).backgroundColor,
                elevation: 20,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/images/additem.png")),
                      Text("Add Product", style: TextStyle(fontSize: 20))
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) => EditItemScreen()));
              },
              child: Material(
                color: Theme.of(context).backgroundColor,
                elevation: 20,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/images/edititem.png")),
                      Text("Edit Product", style: TextStyle(fontSize: 20))
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) => StockScreen()));
              },
              child: Material(
                color: Theme.of(context).backgroundColor,
                elevation: 20,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/images/stock.png")),
                      Text("Stock", style: TextStyle(fontSize: 20))
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => OrderReceivedScreen()));
              },
              child: Material(
                color: Theme.of(context).backgroundColor,
                elevation: 20,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/images/orderlist.png")),
                      Text("Order Received", style: TextStyle(fontSize: 20))
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ReportReceiveScreen()));
              },
              child: Material(
                color: Theme.of(context).backgroundColor,
                elevation: 20,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child:
                              Image.asset("assets/images/reportedissue.png")),
                      Text("Reported Issues", style: TextStyle(fontSize: 20))
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => FeedbackReceivedScreen()));
              },
              child: Material(
                color: Theme.of(context).backgroundColor,
                elevation: 20,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                              "assets/images/feedbackreceived.png")),
                      Text("Feedback Received", style: TextStyle(fontSize: 20))
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
