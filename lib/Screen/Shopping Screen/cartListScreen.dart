import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/checkoutScreen.dart';

class CartListScreen extends StatefulWidget {
  final User user;

  const CartListScreen({Key key, this.user}) : super(key: key);
  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  double screenWidth;
  double screenHeight;
  List _cartList;
  String _titlecenter = "Loading...";
  TextEditingController _qtyController = new TextEditingController();
  int qty = 1;
  String grandtotal;
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  @override
  void initState() {
    super.initState();
    _loadcart();
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
            "Shopping Cart",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                child: _cartList == null
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
                                (screenWidth / screenHeight) / 0.2,
                            children: List.generate(_cartList.length, (index) {
                              grandtotal =
                                  _cartList[_cartList.length - 1]["grandtotal"];
                              _qtyController = new TextEditingController(
                                  text: _cartList[index]["c_quantity"]);
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
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "https://hubbuddies.com/270607/snackeverywhere/images/product/${_cartList[index]['product_id']}.png")),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Container(
                                                width: screenWidth / 1.64,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              checkProductName(
                                                                  _cartList[
                                                                          index]
                                                                      [
                                                                      'product_name']),
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Text(
                                                                _cartList[index]
                                                                    [
                                                                    'product_size'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0),
                                                              child: Row(
                                                                children: [
                                                                  Text("RM",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14)),
                                                                  Text(
                                                                    _cartList[
                                                                            index]
                                                                        [
                                                                        'product_price'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors.amber[
                                                                            800],
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "RM" +
                                                              _cartList[index][
                                                                  "totalprice"],
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              color: Colors
                                                                  .amber[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          MaterialButton(
                                                            height: 25.0,
                                                            minWidth: 25.0,
                                                            color: Colors.amber,
                                                            textColor:
                                                                Colors.black,
                                                            child: new Icon(
                                                                Icons.remove,
                                                                size: 20),
                                                            onPressed: () {
                                                              setState(() {
                                                                _qtyController =
                                                                    new TextEditingController(
                                                                        text: _cartList[index]
                                                                            [
                                                                            "c_quantity"]);
                                                                print("this");
                                                                print(_qtyController
                                                                    .text
                                                                    .toString());
                                                                qty = int.parse(
                                                                        _qtyController
                                                                            .text
                                                                            .toString()) -
                                                                    1;
                                                                _qtyController
                                                                        .text =
                                                                    qty.toString();
                                                                _updateCart(
                                                                    index,
                                                                    _qtyController
                                                                        .text
                                                                        .toString());
                                                              });
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .backgroundColor,
                                                                    borderRadius: BorderRadius.all(Radius
                                                                        .circular(
                                                                            10))),
                                                                width: 60,
                                                                height: 30,
                                                                child:
                                                                    TextField(
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        controller:
                                                                            _qtyController,
                                                                        cursorColor:
                                                                            Theme.of(context)
                                                                                .primaryColorDark,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                          border:
                                                                              OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                        ))),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child:
                                                                MaterialButton(
                                                              height: 25.0,
                                                              minWidth: 25.0,
                                                              color:
                                                                  Colors.amber,
                                                              textColor:
                                                                  Colors.black,
                                                              child: new Icon(
                                                                  Icons.add,
                                                                  size: 20),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _qtyController =
                                                                      new TextEditingController(
                                                                          text: _cartList[index]
                                                                              [
                                                                              "c_quantity"]);
                                                                  print("this");
                                                                  print(_qtyController
                                                                      .text
                                                                      .toString());
                                                                  qty = int.parse(_qtyController
                                                                          .text
                                                                          .toString()) +
                                                                      1;
                                                                  _qtyController
                                                                          .text =
                                                                      qty.toString();
                                                                  _updateCart(
                                                                      index,
                                                                      _qtyController
                                                                          .text
                                                                          .toString());
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
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
                                              builder: (BuildContext context) {
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
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                    TextButton(
                                                        child: Text("Confirm",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          _deleteProduct(index);
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
                      ))),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("RM", style: TextStyle(fontSize: 20)),
                Text((grandtotal == null) ? "0.00" : grandtotal,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800])),
              ],
            ),
            Container(
              width: 150,
              child: FloatingActionButton(
                backgroundColor: Colors.amber[800],
                onPressed: () {
                  
                  if (_cartList != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) =>
                                CheckOutScreen(user: widget.user)));
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please select at least an item",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text("Check Out", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String checkProductName(String productName) {
    if (productName.length < 13) {
      return productName;
    } else {
      return productName.substring(0, 13) + "...";
    }
  }

  void _deleteProduct(int index) {}

  void _loadcart() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadCart.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "Cart Empty") {
        _titlecenter = "Cart Empty";
        _cartList = null;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _cartList = jsondata["cart"];
        setState(() {});
        print(_cartList);
      }
    });
  }

  void _updateCart(int index, String qty) {
    String quantity = qty;
    print(index);
    print("new qty");
    print(quantity);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/editCart.php"),
        body: {
          "email": widget.user.email,
          "product_id": _cartList[index]["product_id"],
          "product_price": _cartList[index]["product_price"],
          "quantity": qty
        }).then((response) {
      print(response.body);
      if (response.body == "Success") {
        setState(() {
          _loadcart();
        });
      } else {
        Fluttertoast.showToast(
            msg: "Fail to update cart...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }
}
