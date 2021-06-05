import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/product.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/addtocartScreen.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  final User user;

  const ProductScreen({Key key, this.product, this.user}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  double screenWidth;
  double screenHeight;
  List<bool> isSelected = [true, false];

  var controller;
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
          widget.product.product_name,
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        actions: [
           Stack(children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined)),
            Positioned(
              right: 6.0,
              bottom: 6.0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                    child: Text(
                  widget.user.c_qty,
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ]),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Column(
                children: [
                  Container(
                      height: screenHeight / 2.5,
                      width: double.infinity,
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              "https://hubbuddies.com/270607/snackeverywhere/images/product/${widget.product.product_id}.png")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (widget.product.instock_qtysmall == "0" &&
                          widget.product.instock_qtylarge == "0")
                      ? Text("SOLD OUT",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.amber[800],
                              fontWeight: FontWeight.bold))
                      : Row(
                          children: [
                            Text("RM ", style: TextStyle(fontSize: 12)),
                            Text(widget.product.product_small_price,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.amber[800],
                                    fontWeight: FontWeight.bold)),
                            (widget.product.product_large_price == "0.00")
                                ? Text("")
                                : Row(
                                    children: [
                                      Text(" ~ "),
                                      Text("RM ",
                                          style: TextStyle(fontSize: 12)),
                                      Text(widget.product.product_large_price,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.amber[800],
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                          ],
                        ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border_rounded))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.product_name,
                  style: TextStyle(fontSize: 20)),
            ),
            Divider(thickness: 10, color: Theme.of(context).cardColor),
            GestureDetector(
              onTap: () {
                _collectMethod();
              },
              child: Container(
                  width: double.infinity,
                  height: screenHeight / 13,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Collect Method",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        IconButton(
                            onPressed: () {
                              _collectMethod();
                            },
                            icon: Icon(Icons.navigate_next_rounded))
                      ],
                    ),
                  )),
            ),
            Divider(thickness: 10, color: Theme.of(context).cardColor),
            GestureDetector(
              onTap: () {
                _service();
              },
              child: Container(
                  width: double.infinity,
                  height: screenHeight / 13,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Service",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        IconButton(
                            onPressed: () {
                              _service();
                            },
                            icon: Icon(Icons.navigate_next_rounded))
                      ],
                    ),
                  )),
            ),
            Divider(thickness: 10, color: Theme.of(context).cardColor),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ratings & Reviews",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      TextButton(
                        onPressed: () {
                          _service();
                        },
                        child: Text(
                          "View All>",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      )
                    ],
                  ),
                )),
            Divider(thickness: 1, color: Theme.of(context).cardColor),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Username",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(_checkReview("1 This is a demo review")),
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Username",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(_checkReview("2 This is a demo review")),
                    ],
                  ),
                )),
            Divider(thickness: 10, color: Theme.of(context).cardColor),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Description",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      TextButton(
                        onPressed: () {
                          _desc();
                        },
                        child: Text(
                          "View All>",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: screenHeight / 3,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.product.product_desc))),
            Divider(thickness: 10, color: Theme.of(context).cardColor),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Category",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      Text(widget.product.product_cat,
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                )),
            Divider(thickness: 10, color: Theme.of(context).cardColor),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product Pricing",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            (widget.product.instock_qtysmall == "0" &&
                                    widget.product.instock_qtylarge == "0")
                                ? Text("Small: Sold Out")
                                : Text("Small: RM" +
                                    widget.product.product_small_price +
                                    " x " +
                                    widget.product.product_small_qty +
                                    " pcs"),
                          ],
                        ),
                        Row(
                          children: [
                            (widget.product.instock_qtylarge == "0")
                                ? Text("Large: Not Available")
                                : Text("Large: RM" +
                                    widget.product.product_large_price +
                                    " x " +
                                    widget.product.product_large_qty +
                                    " pcs"),
                          ],
                        ),
                      ],
                    ))),
            Divider(thickness: 10, color: Theme.of(context).cardColor),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Available Quantity",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: screenHeight / 13,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Small: " +
                                widget.product.instock_qtysmall +
                                " pcs"),
                          ],
                        ),
                        Row(
                          children: [
                            (widget.product.instock_qtylarge == "0")
                                ? Text("Large: Not Available")
                                : Text("Large: " +
                                    widget.product.instock_qtylarge +
                                    " pcs"),
                          ],
                        ),
                      ],
                    ))),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
              height: 40,
              width: screenWidth / 4.0,
              child: FloatingActionButton(
                backgroundColor: Colors.amber,
                heroTag: "buybtn",
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {},
                child: Text("Buy Now"),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
                height: 40,
                width: screenWidth / 4.0,
                child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  heroTag: "addbtn",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => AddToCartScreen(
                                product: widget.product, user: widget.user)));
                  },
                  child: Text("Add to Cart"),
                )),
          )
        ]),
      ),
    );
  }

  void _collectMethod() {
    final snackBar = SnackBar(
        duration: Duration(minutes: 1),
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        content: Container(
            height: screenHeight / 2,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Collect Item Method",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pick Up",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18)),
                    Text("RM0.00",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18)),
                    Text("RM5.00",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Service",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18)),
                    Text("Seller's Own Fleet",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18))
                  ],
                ),
              ),
            ])));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _service() {
    final snackBar = SnackBar(
        duration: Duration(minutes: 1),
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        content: Container(
            height: screenHeight / 2,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Service",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.refresh),
                    Text("14 days easy return",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).cardColor,
                      height: 100,
                      width: 320,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: new SingleChildScrollView(
                              child: RichText(
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontSize: 12.0,
                                      ),
                                      text:
                                          "You may directly raise a return request to the Seller within 14 days of receiving the item, however, good solds are not returnable and refundable.")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _desc() {
    final snackBar = SnackBar(
        duration: Duration(minutes: 1),
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        content: Container(
            height: screenHeight / 2,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Description",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Theme.of(context).cardColor,
                      height: 100,
                      width: 320,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: new SingleChildScrollView(
                              child: RichText(
                                  softWrap: true,
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontSize: 12.0,
                                      ),
                                      text: widget.product.product_desc)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _checkReview(String text) {
    if (text.length < 15) {
      return text;
    } else {
      return text.substring(0, 15) + "...";
    }
  }
}
