import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/order.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/orderDetailScreen.dart';

class OrderReceivedScreen extends StatefulWidget {
  @override
  _OrderReceivedScreenState createState() => _OrderReceivedScreenState();
}

class _OrderReceivedScreenState extends State<OrderReceivedScreen> {
  String _titlecenter = "Loading...";
  List _orderList;
  double screenWidth;
  double screenHeight;
  int index = 0;
  final df = new DateFormat("smH");
  final df1 = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
            "Order Received",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
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
                                      color:
                                          Theme.of(context).primaryColorDark))
                            ],
                            isRepeatingAnimation: true,
                          ),
                        )),
                      )
                    : Flexible(
                        child: Center(
                          child: GridView.count(
                              crossAxisCount: 1,
                              childAspectRatio:
                                  (screenWidth / screenHeight) / 0.31,
                              children:
                                  List.generate(_orderList.length, (index) {
                                return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).backgroundColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[800],
                                          offset: Offset(5.0, 10.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _status(index);
                                      },
                                      child: Slidable(
                                        actionPane: SlidableDrawerActionPane(),
                                        actionExtentRatio: 0.30,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    width: screenWidth / 1.17,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  "Invoice ID: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                              Text(
                                                                  _orderList[index]
                                                                          [
                                                                          "email"] +
                                                                      df.format(DateTime.parse(
                                                                          _orderList[index]
                                                                              [
                                                                              "date_order"])),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  "#" +
                                                                      _orderList[
                                                                              index]
                                                                          [
                                                                          "order_id"],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                          Text(
                                                              _orderList[index]
                                                                  ["email"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Product ID: " +
                                                                      _orderList[
                                                                              index]
                                                                          [
                                                                          "product_id"],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14)),
                                                            ],
                                                          ),
                                                          Text(
                                                              "Product Name: " +
                                                                  _orderList[
                                                                          index]
                                                                      [
                                                                      "product_name"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "Size: " +
                                                                  _orderList[
                                                                          index]
                                                                      [
                                                                      "product_size"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "Quantity: " +
                                                                  _orderList[
                                                                          index]
                                                                      [
                                                                      "o_quantity"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "RM " +
                                                                  _orderList[
                                                                          index]
                                                                      [
                                                                      "product_price"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "Collect Method: " +
                                                                  _orderList[
                                                                          index]
                                                                      [
                                                                      "collect_option"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "Collect Date: " +
                                                                  _orderList[
                                                                          index]
                                                                      [
                                                                      "collect_date"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "Payment Option: " +
                                                                  _orderList[
                                                                          index]
                                                                      [
                                                                      "payment_option"],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "Order Date: " +
                                                                  df1.format(DateTime.parse(
                                                                      _orderList[
                                                                              index]
                                                                          [
                                                                          "date_order"])),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                        ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryActions: <Widget>[
                                          IconSlideAction(
                                            caption: 'Delete',
                                            color: Colors.red,
                                            icon: Icons.delete,
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Row(
                                                        children: [
                                                          Container(
                                                              height: 25,
                                                              width: 25,
                                                              child: Image.asset(
                                                                  "assets/images/Logo.png")),
                                                          Container(
                                                              child: Text(
                                                                  "Confirm delete?")),
                                                        ],
                                                      ),
                                                      content: Container(
                                                        child: Text(
                                                            "Are you sure to delete this?"),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            child: Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                        TextButton(
                                                            child: Text(
                                                                "Confirm",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              _deleteProduct(
                                                                  index);
                                                            })
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                      ))
          ])),
    );
  }

  void _loadOrder() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadOrder.php"),
        body: {}).then((response) {
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

  void _deleteProduct(int index) {}

  void _status(int index) {
    Order order = new Order(
      invoice_id: _orderList[index]["email"]+df.format(DateTime.parse(_orderList[index]["date_order"])),
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
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => OrderDetailScreen(order: order)));
  }
}
