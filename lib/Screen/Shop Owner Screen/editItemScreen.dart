import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/product.dart';
import 'package:snackeverywhere/Screen/Shop%20Owner%20Screen/editItemDetailsScreen.dart';

class EditItemScreen extends StatefulWidget {
  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
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
            "Edit Item",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: screenWidth / 1.05,
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
                                  (screenWidth / screenHeight) / 0.11,
                              children:
                                  List.generate(_productList.length, (index) {
                                return Padding(
                                  padding: EdgeInsets.all(5),
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
                                    child: Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.30,
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
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Container(
                                                  width: screenWidth / 1.35,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                checkProductName(
                                                                  _productList[
                                                                          index]
                                                                      [
                                                                      "product_name"],
                                                                ),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18)),
                                                            Text(
                                                                df.format(DateTime.parse(
                                                                    _productList[
                                                                            index]
                                                                        [
                                                                        "datePublished"])),
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
                                                                "Small Item Price:"),
                                                            Text(_productList[
                                                                    index][
                                                                "product_small_price"]),
                                                            Text(
                                                                "    Small Item Qty:"),
                                                            Text(_productList[
                                                                    index][
                                                                "product_small_qty"]),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Large Item Price:"),
                                                            Text(_productList[
                                                                    index][
                                                                "product_large_price"]),
                                                            Text(
                                                                "    Large Item Qty:"),
                                                            Text(_productList[
                                                                    index][
                                                                "product_large_qty"]),
                                                          ],
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Edit',
                                          color: Colors.black45,
                                          icon: Icons.edit,
                                          onTap: () {
                                            _editItem(index);
                                          },
                                        ),
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
                                                          child: Text("Cancel",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }),
                                                      TextButton(
                                                          child: Text("Confirm",
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
                                );
                              })),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  Widget category(String title) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Center(
          child: Text(title,
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight, fontSize: 18))),
    );
  }

  String checkProductName(String productName) {
    if (productName.length < 15) {
      return productName;
    } else {
      return productName.substring(0, 15) + "...";
    }
  }

  void _loadproducts(String productCat) {
    if (productCat == "") {
      print(productCat);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/loadProducts.php"),
          body: {}).then((response) {
        print(response.body);
        if (response.body == "nodata") {
          _titlecenter = "No Product";
          _productList = null;
          setState(() {});
          return;
        } else {
          var jsondata = json.decode(response.body);
          _productList = jsondata["products"];
          setState(() {
            productCat = "";
          });
          print(_productList);
        }
      });
    } else {
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
  }

  void _deleteProduct(int index) {
    String productId = _productList[index]["product_id"];
    print(productId);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/deleteProduct.php"),
        body: {
          "product_id": productId,
        }).then((response) {
      print(response.body);
      if (response.body == "Success") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Container(
                        height: 25,
                        width: 25,
                        child: Image.asset("assets/images/Logo.png")),
                    Container(child: Text("Deleted")),
                  ],
                ),
                content: Container(
                  height: 25,
                  child: Text("Product deleted successfully"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _loadproducts("");
                        });
                      }),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    Container(
                        height: 25,
                        width: 25,
                        child: Image.asset("assets/images/Logo.png")),
                    Container(child: Text("Opps...")),
                  ],
                ),
                content: Container(
                  height: 70,
                  child: Text("Product delete failed. Please try again"),
                ),
                actions: [
                  TextButton(
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child:
                          Text("Retry", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        _deleteProduct(index);
                      })
                ],
              );
            });
      }
    });
  }

  void _editItem(int index) {
    Product product = new Product(
      product_id: _productList[index]["product_id"],
      product_name: _productList[index]["product_name"],
      product_desc: _productList[index]["product_desc"],
      product_small_price: _productList[index]["product_small_price"],
      product_small_qty: _productList[index]["product_small_qty"],
      product_large_price: _productList[index]["product_large_price"],
      product_large_qty: _productList[index]["product_large_qty"],
      product_cat: _productList[index]["product_cat"],
      instock_qtysmall: _productList[index]["instock_qtysmall"],
      instock_qtylarge: _productList[index]["instock_qtylarge"],
      datePublished: _productList[index]["datePublished"],
    );

    print(_productList[index]["product_id"]);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => EditItemDetailsScreen(product: product)));
  }
}
