import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  double screenWidth;
  double screenHeight;
  String _titlecenter = "Loading...";
  List _productList;
  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    _loadproducts("");
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
            "Stock",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: screenWidth / 1.2,
                  height: 40,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        GestureDetector(
                            onTap: () {
                              _loadproducts("");
                            },
                            child: category("All Items")),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _loadproducts("Candy");
                            },
                            child: category("Candy")),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _loadproducts("Drink");
                            },
                            child: category("Drink")),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _loadproducts("Nut");
                            },
                            child: category("Nut")),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _loadproducts("Plum");
                            },
                            child: category("Plum")),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _loadproducts("Snack");
                            },
                            child: category("Snack")),
                        SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _loadproducts("Toy");
                            },
                            child: category("Toy"))
                      ]))),
              IconButton(
                icon: Icon(Icons.filter_alt_outlined),
                onPressed: () {},
              )
            ],
          ),
          Container(
            child: _productList == null
                ? Flexible(
                    child: Center(
                      child: Container(
                        height: 20.0,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText(_titlecenter,
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColorDark))
                          ],
                          isRepeatingAnimation: true,
                        ),
                      ),
                    ),
                  )
                : Flexible(
                    child: Center(
                      child: ListView(
                          children: List.generate(_productList.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 5, right: 5,top:1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                        height: 50,
                                        width: 50,
                                        child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                "https://hubbuddies.com/270607/snackeverywhere/images/product/${_productList[index]['product_id']}.png")),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Container(
                                        width: screenWidth / 1.35,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      checkProductName(
                                                        _productList[index]
                                                            ["product_name"],
                                                      ),
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text("Small Item Qty:"),
                                                  Text(
                                                    _productList[index]
                                                        ["instock_qtysmall"],
                                                    style: TextStyle(
                                                        color: (double.parse(
                                                                    _productList[
                                                                            index]
                                                                        [
                                                                        "instock_qtysmall"]) <
                                                                5)
                                                            ? Colors.red
                                                            : Colors.green,
                                                        fontWeight: (double.parse(
                                                                    _productList[
                                                                            index]
                                                                        [
                                                                        "instock_qtysmall"]) <
                                                                5)
                                                            ? FontWeight.bold
                                                            : FontWeight
                                                                .normal),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      df.format(DateTime.parse(
                                                          _productList[index][
                                                              "datePublished"])),
                                                      style: TextStyle(
                                                          fontSize: 10)),
                                                  Row(
                                                    children: [
                                                      Text("Large Item Qty:"),
                                                      Text(
                                                        _productList[index][
                                                            "instock_qtylarge"],
                                                        style: TextStyle(
                                                            color: (double.parse(
                                                                        _productList[index]
                                                                            [
                                                                            "instock_qtylarge"]) <
                                                                    5)
                                                                ? Colors.red
                                                                : Colors.green,
                                                            fontWeight: (double.parse(
                                                                        _productList[index]
                                                                            [
                                                                            "instock_qtylarge"]) <
                                                                    5)
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                    ),
                  ),
          )
        ]),
      ),
    );
  }

  Widget category(String category) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
          child: Text(category,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight, fontSize: 18))),
    );
  }

  void _loadproducts(String productCat) {
   if(productCat==""){
        productCat="All";
      }
      print(productCat);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/loadProductsCategory.php"),
          body: {"product_cat": productCat}).then((response) {
        print(response.body);
        if (response.body == "nodata") {
          _titlecenter = "No Product";
          _productList = null;
          setState(() {});
          return;
        } else {
          var jsondata = json.decode(response.body);
          _productList = jsondata["products"];
          setState(() {});
          print(_productList);
        }
      });
  }

  String checkProductName(String productName) {
    if (productName.length < 15) {
      return productName;
    } else {
      return productName.substring(0, 15) + "...";
    }
  }
}
