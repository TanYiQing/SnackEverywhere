import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/order.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Screen/Setting/viewOrderScreen.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/orderDetailScreen.dart';

class PointScreen extends StatefulWidget {
  final User user;

  const PointScreen({Key key, this.user}) : super(key: key);
  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  String _titlecenter = "Loading...";
  List _orderList;
  double screenWidth;
  double screenHeight;
  final df = new DateFormat("smH");
  final df1 = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    _loadOrder();
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
            "Points",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              Container(
                  height: 220,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple[900], Colors.deepPurple]),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/celebrate1.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Container(
                            height: 70,
                            width: 130,
                            child: Image.asset("assets/images/celebrate.png"),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/user.png")),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.user.first_name +
                                        " " +
                                        widget.user.last_name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Text(
                                "Your Balance:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                        "assets/images/trophy.png")),
                                Text(
                                  _orderList == null
                                      ? "0 pts"
                                      : calculatePoint().toString() + "pts",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 50),
              Container(width: double.infinity, height: 400, child: tabpoints())
            ]),
          )
        ],
      ),
    );
  }

  Widget tabpoints() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepPurple[900],
            title: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rewards",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.trending_up_rounded)
                    ],
                  ),
                ),
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Recent Activities",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.history)
                  ],
                ))
              ],
            ),
          ),
          body: TabBarView(children: [
            Container(
                child: ListView(children: [
              Container(
                height: 80,
                color: Theme.of(context).backgroundColor,
                child: Row(children: [
                  Container(
                      height: 80,
                      width: 80,
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "FREE SHIPPING",
                          style: TextStyle(
                              fontSize: 13.5, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Min. Spend RM 100"),
                  )
                ]),
              ),
              Divider(),
              Container(
                height: 80,
                color: Theme.of(context).backgroundColor,
                child: Row(children: [
                  Container(
                      height: 80,
                      width: 80,
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "DISCOUNT 20%",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No Min. Spend"),
                  )
                ]),
              ),
            ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                      child: _orderList == null
                          ? Flexible(
                              child: Center(
                                  child: Container(
                                height: 20.0,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    WavyAnimatedText(_titlecenter,
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .primaryColorDark))
                                  ],
                                  isRepeatingAnimation: true,
                                ),
                              )),
                            )
                          : Flexible(
                              child: Center(
                                  child: GridView.count(
                                crossAxisCount: 1,
                                childAspectRatio: 7,
                                children:
                                    List.generate(_orderList.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      _viewDetails(index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    df1.format(DateTime.parse(
                                                      _orderList[index]
                                                          ["date_order"],
                                                    )),
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    "RM " +
                                                        _orderList[index]
                                                            ["product_price"],
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                  _orderList[index]
                                                          ["status"],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: ( _orderList[index]
                                                          ["status"]=="Order Completed")?Colors.grey:Colors.green)),
                                              Text(
                                                  "+" +
                                                      _orderList[index]
                                                          ["product_price"] +
                                                      "pts",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.green))
                                            ]),
                                      ),
                                    ),
                                  );
                                }),
                              )),
                            )),
                ],
              ),
            )
          ]),
        ));
  }

  void _loadOrder() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadOrder.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No Order";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _orderList = jsondata["orders"];
        setState(() {});
        print(_orderList);
      }
    });
  }

  void _viewDetails(index) {
    Order order = new Order(
        invoice_id: _orderList[index]["email"] +
            df.format(DateTime.parse(_orderList[index]["date_order"])),
        order_id: _orderList[index]["order_id"],
        email: _orderList[index]["email"],
        product_id: _orderList[index]["product_id"],
        product_name: _orderList[index]["product_name"],
        product_size: _orderList[index]["product_size"],
        product_price: _orderList[index]["product_price"],
        o_quantity: _orderList[index]["o_quantity"],
        date_order: _orderList[index]["date_order"],
        collect_option: _orderList[index]["collect_option"],
        collect_date: _orderList[index]["collect_date"],
        payment_option: _orderList[index]["payment_option"],
        status: _orderList[index]["status"],
        receiptid: _orderList[index]["receipt_id"],
        view:"false");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => ViewOrderScreen(order: order)));
  }

  double calculatePoint() {
    double totalPoint = 0;
    double point = 0;
    for (int i = 0; i < _orderList.length; i++) {
      point = double.parse(_orderList[i]["product_price"]);
      totalPoint += point;
    }
    return totalPoint;
  }
}
