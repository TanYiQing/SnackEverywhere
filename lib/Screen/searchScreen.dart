import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Class/product.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/productScreen.dart';

class SearchScreen extends StatefulWidget {
  final User user;

  const SearchScreen({Key key, this.user}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = new TextEditingController();
  String _titlecenter = "Search Something Here...";
  List _searchList;
  double screenWidth;
  double screenHeight;
  var _screenRatio = 2;
  bool _isgridview = true;

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
        title: Container(
            height: 40,
            child: TextField(
              controller: _searchController,
              style: TextStyle(fontSize: 18),
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: "Search"),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _searchItem();
                  });
                },
                color: Colors.amber[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text("Search", style: TextStyle(fontSize: 16))),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                child: _searchList == null
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
                                crossAxisCount: _screenRatio,
                                childAspectRatio:
                                    (screenWidth / screenHeight) / 0.65, //0.61,
                                children:
                                    List.generate(_searchList.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _viewProduct(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: (_isgridview == true)
                                                    ? screenHeight / 5
                                                    : screenHeight / 2,
                                                width: double.infinity,
                                                child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        "https://hubbuddies.com/270607/snackeverywhere/images/product/${_searchList[index]['product_id']}.png")),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Text(
                                                  checkProductName(
                                                      _searchList[index]
                                                          ['product_name']),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: (_searchList[index][
                                                              'instock_qtysmall'] ==
                                                          "0" &&
                                                      _searchList[index][
                                                              'instock_qtylarge'] ==
                                                          "0")
                                                  ? Text("SOLD OUT",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.amber[800],
                                                          fontWeight:
                                                              FontWeight.bold))
                                                  : Row(
                                                      children: [
                                                        Text("RM ",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        Text(
                                                          _searchList[index][
                                                              'product_small_price'],
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .amber[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        (_searchList[index][
                                                                    'product_large_price'] ==
                                                                "0.00")
                                                            ? Text("")
                                                            : Row(
                                                                children: [
                                                                  Text(" ~ "),
                                                                  Text("RM ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12)),
                                                                  Text(
                                                                      _searchList[
                                                                              index]
                                                                          [
                                                                          'product_large_price'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color: Colors.amber[
                                                                              800],
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              )
                                                      ],
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })))))
          ],
        ),
      ),
    );
  }

  void _searchItem() {
    String searchItem = _searchController.text.toString();
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadProductsCategory.php"),
        body: {"product_name": searchItem}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "Product Not Found";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _searchList = jsondata["products"];
        setState(() {});
        print(_searchList);
      }
    });
  }

  void _viewProduct(int index) {
    Product product = new Product(
      product_id: _searchList[index]["product_id"],
      product_name: _searchList[index]["product_name"],
      product_desc: _searchList[index]["product_desc"],
      product_small_price: _searchList[index]["product_small_price"],
      product_small_qty: _searchList[index]["product_small_qty"],
      product_large_price: _searchList[index]["product_large_price"],
      product_large_qty: _searchList[index]["product_large_qty"],
      product_cat: _searchList[index]["product_cat"],
      instock_qtysmall: _searchList[index]["instock_qtysmall"],
      instock_qtylarge: _searchList[index]["instock_qtylarge"],
      datePublished: _searchList[index]["datePublished"],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) =>
                ProductScreen(product: product, user: widget.user)));
  }

  String checkProductName(String productName) {
    if (productName.length < 15) {
      return productName;
    } else {
      return productName.substring(0, 15) + "...";
    }
  }
}
