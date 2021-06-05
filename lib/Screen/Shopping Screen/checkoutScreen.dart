import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Class/user.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/selectaddressScreen.dart';

class CheckOutScreen extends StatefulWidget {
  final User user;
  // ignore: non_constant_identifier_names

  final int data;
  const CheckOutScreen({
    Key key,
    this.user,
    this.data,
    passedindex,
  }) : super(key: key);
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool hasbeenPressed = true;
  bool hasbeenPressed1 = false;
  int _optionValue = 0;
  String option;
  String paymentoption = "Cash";
  String _titlecenter = "Loading...";
  List _cartList;
  List _shippingAddressList;
  double screenWidth;
  double screenHeight;
  String grandtotal;
  String deliverycharge = "0.00";
  String promodiscount = "0.00";
  String collectDate;

  TextEditingController _promoController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _timeController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadcart();
    _loadShippingAddress();
    _loadCart();
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
            "Check Out",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (_cartList == null)
              ? Expanded(
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
                  )),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: _cartList == null ? 1 : _cartList.length + 4,
                      itemBuilder: (context, index) {
                        if (index == _cartList.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => SelectAddressScreen(
                                          user: widget.user)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  height: screenHeight / 5.5,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[800],
                                          offset: Offset(5.0, 8.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Theme.of(context).primaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.location_on,
                                            color: Colors.red),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _shippingAddressList == null
                                                ? Text("No Address")
                                                : Text(
                                                    widget.data == null
                                                        ? _shippingAddressList[
                                                            index]["s_name"]
                                                        : _shippingAddressList[
                                                                widget.data]
                                                            ["s_name"],
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                            _shippingAddressList == null
                                                ? Text("No Address")
                                                : Text(
                                                    widget.data == null
                                                        ? _shippingAddressList[
                                                            index]["email"]
                                                        : _shippingAddressList[
                                                                widget.data]
                                                            ["email"],
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                            _shippingAddressList == null
                                                ? Text("No Address")
                                                : Text(
                                                    widget.data == null
                                                        ? _shippingAddressList[
                                                            index]["s_phone"]
                                                        : _shippingAddressList[
                                                                widget.data]
                                                            ["s_phone"],
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                            Row(
                                              children: [
                                                _shippingAddressList == null
                                                    ? Text("No Address")
                                                    : Text(
                                                        widget.data == null
                                                            ? _shippingAddressList[
                                                                        index][
                                                                    "s_address1"] +
                                                                ","
                                                            : _shippingAddressList[
                                                                        widget
                                                                            .data]
                                                                    [
                                                                    "s_address1"] +
                                                                ",",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                _shippingAddressList == null
                                                    ? Text("No Address")
                                                    : Text(
                                                        widget.data == null
                                                            ? _shippingAddressList[
                                                                        index][
                                                                    "s_address2"] +
                                                                ","
                                                            : _shippingAddressList[
                                                                        widget
                                                                            .data]
                                                                    [
                                                                    "s_address2"] +
                                                                ",",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                              ],
                                            ),
                                            _shippingAddressList == null
                                                ? Text("No Address")
                                                : Text(
                                                    widget.data == null
                                                        ? _shippingAddressList[
                                                                    index]
                                                                ["s_address3"] +
                                                            " "
                                                        : _shippingAddressList[
                                                                    widget.data]
                                                                ["s_address3"] +
                                                            " ",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                            Row(
                                              children: [
                                                _shippingAddressList == null
                                                    ? Text("No Address")
                                                    : Text(
                                                        widget.data == null
                                                            ? _shippingAddressList[
                                                                        index]
                                                                    ["s_zip"] +
                                                                " "
                                                            : _shippingAddressList[
                                                                        widget
                                                                            .data]
                                                                    ["s_zip"] +
                                                                " ",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                _shippingAddressList == null
                                                    ? Text("No Address")
                                                    : Text(
                                                        widget.data == null
                                                            ? _shippingAddressList[
                                                                        index]
                                                                    ["s_city"] +
                                                                ","
                                                            : _shippingAddressList[
                                                                        widget
                                                                            .data]
                                                                    ["s_city"] +
                                                                ",",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                _shippingAddressList == null
                                                    ? Text("No Address")
                                                    : Text(
                                                        widget.data == null
                                                            ? _shippingAddressList[
                                                                        index][
                                                                    "s_state"] +
                                                                " "
                                                            : _shippingAddressList[
                                                                        widget
                                                                            .data]
                                                                    [
                                                                    "s_state"] +
                                                                " ",
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }
                        if (index == _cartList.length + 1) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800],
                                      offset: Offset(5.0, 8.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Theme.of(context).primaryColor),
                              height: screenHeight / 3.3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: Colors.amber,
                                        groupValue: _optionValue,
                                        value: 0,
                                        onChanged: _handleRadioButton,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Pick Up",
                                              style: TextStyle(fontSize: 18)),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child:
                                                Text("Delivery Charge: RM 0"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(
                                      thickness: 3,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        activeColor: Colors.amber,
                                        groupValue: _optionValue,
                                        value: 1,
                                        onChanged: _handleRadioButton,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Delivery",
                                              style: TextStyle(fontSize: 18)),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child:
                                                Text("Delivery Charge: RM 5"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(
                                      thickness: 3,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                height: 40,
                                                width: screenWidth / 2.5,
                                                child: TextField(
                                                    controller: _dateController,
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .primaryColorDark,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 10.0,
                                                              left: 10),
                                                      hintText: "dd/mm/yyyy",
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 18))),
                                            Container(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                height: 40,
                                                width: screenWidth / 2.5,
                                                child: TextField(
                                                    controller: _timeController,
                                                    cursorColor:
                                                        Theme.of(context)
                                                            .primaryColorDark,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 10.0,
                                                              left: 10),
                                                      hintText: "24 hrs format",
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 18)))
                                          ])),
                                ]),
                              ),
                            ),
                          );
                        }
                        if (index == _cartList.length + 2) {
                          return Container(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 150,
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        hasbeenPressed = true;
                                        hasbeenPressed1 = false;
                                        print("P");
                                        print(hasbeenPressed);
                                        print("P1");
                                        print(hasbeenPressed1);
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            "assets/images/cashPayment.png"),
                                        Text("Cash Payment"),
                                      ],
                                    ),
                                    color: hasbeenPressed == true
                                        ? Colors.amber[800]
                                        : Colors.amber,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(
                                    height: 100,
                                    width: 150,
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          hasbeenPressed = false;
                                          hasbeenPressed1 = true;
                                          print("P");
                                          print(hasbeenPressed);
                                          print("P1");
                                          print(hasbeenPressed1);
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 68,
                                              width: 68,
                                              child: Image.asset(
                                                  "assets/images/cardPayment.png")),
                                          Text("Card Payment"),
                                        ],
                                      ),
                                      color: hasbeenPressed1 == true
                                          ? Colors.amber[800]
                                          : Colors.amber,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (index == _cartList.length + 3) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              height: screenHeight / 4.0,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          height: 40,
                                          width: screenWidth / 1.2,
                                          child: TextField(
                                              controller: _promoController,
                                              cursorColor: Theme.of(context)
                                                  .primaryColorDark,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    bottom: 10.0, left: 10),
                                                hintText:
                                                    "Enter promocode here",
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ),
                                              style: TextStyle(fontSize: 18))),
                                      IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () {
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Subtotal (RM)"),
                                        Text(_cartList[_cartList.length - 1]
                                            ["grandtotal"])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Delivery Charge (RM)"),
                                        Text(deliverycharge)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Promocode Discount (RM)"),
                                        Text((_promoController.text
                                                    .toString() ==
                                                "RAYAFEST")
                                            ? "-" +
                                                _calculatePromo(_calculateTotal(
                                                    _cartList[_cartList.length -
                                                        1]["grandtotal"],
                                                    deliverycharge,
                                                    _promoController.text
                                                        .toString()))
                                            : "0.00")
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order Amount (RM)"),
                                        Text(_calculateTotal(
                                            _cartList[_cartList.length - 1]
                                                ["grandtotal"],
                                            deliverycharge,
                                            _promoController.text.toString()))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    width: screenWidth / 1.5,
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  checkProductName(
                                                      _cartList[index]
                                                          ['product_name']),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    _cartList[index]
                                                        ['product_size'],
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Text("RM",
                                                          style: TextStyle(
                                                              fontSize: 14)),
                                                      Text(
                                                        _cartList[index]
                                                            ['product_price'],
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .amber[800],
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text("Quantity:" +
                                                      _cartList[index]
                                                          ["c_quantity"]),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "RM" +
                                                  _cartList[index]
                                                      ["totalprice"],
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.amber[800],
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 150,
              child: FloatingActionButton(
                backgroundColor: Colors.amber[800],
                onPressed: () {
                  _placeOrder(widget.data == null ? 0 : widget.data);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text("Place Order", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  void _loadShippingAddress() {
    String email = widget.user.email;
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadShippingAddress.php"),
        body: {
          "email": email,
        }).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No Address";
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _shippingAddressList = jsondata["shippingaddresses"];
        setState(() {});
        print(_shippingAddressList);
      }
    });
  }

  void _loadCart() {
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
        print(widget.data);
      }
    });
  }

  String checkProductName(String productName) {
    if (productName.length < 13) {
      return productName;
    } else {
      return productName.substring(0, 13) + "...";
    }
  }

  void _handleRadioButton(int value) {
    setState(() {
      _optionValue = value;
      switch (_optionValue) {
        case 0:
          option = "Pick Up";
          deliverycharge = "0.00";
          print(deliverycharge);
          break;
        case 1:
          option = "Delivery";
          deliverycharge = "5.00";
          print(deliverycharge);
          break;
      }
    });
  }

  String _calculateTotal(
      String grandtotal, String deliverycharge, String promocode) {
    double grandTotal = double.parse(grandtotal);
    double deliveryCharge = double.parse(deliverycharge);
    double orderAmount;

    if (promocode == "RAYAFEST") {
      orderAmount = grandTotal + deliveryCharge;
      orderAmount = orderAmount - (orderAmount * (20 / 100));
    } else {
      orderAmount = grandTotal + deliveryCharge;
    }

    return orderAmount.toStringAsFixed(2);
  }

  String _calculatePromo(String orderamount) {
    double promodiscount;
    double orderAmount = double.parse(orderamount);
    promodiscount = orderAmount * (20 / 100);
    return promodiscount.toStringAsFixed(2);
  }

  void _placeOrder(data) {
    if (_optionValue == 0) {
      option = "Pick Up";
    } else {
      option = "Delivery";
    }

    if (hasbeenPressed == true) {
      paymentoption = "Cash";
    } else {
      paymentoption = "Card";
    }

    print(
      _shippingAddressList[data]["shipping_id"],
    );

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/publishOrder.php"),
        body: {
          "email": widget.user.email,
          "collect_option": option,
          "collect_date": _dateController.text.toString() +
              " " +
              _timeController.text.toString(),
          "payment_option": paymentoption,
          "address": _shippingAddressList[data]["shipping_id"],
        }).then((response) {
      print(response.body);
      if (response.body == "Failed") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.close_rounded, color: Colors.red),
                    Container(child: Text("  Order Failed")),
                  ],
                ),
                content: Container(
                    height: 50,
                    child: Center(
                        child: Text("Please contact us for any query."))),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.done_outline_sharp, color: Colors.green),
                    Container(child: Text("  Order Placed!")),
                  ],
                ),
                content: Container(
                  height: 250,
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "- - - - - - - - - - - Receipt - - - - - - - - - - -"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Subtotal (RM)"),
                              Text(
                                  _cartList[_cartList.length - 1]["grandtotal"])
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Charge (RM)"),
                              Text(deliverycharge)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Promocode Discount (RM)"),
                              Text((_promoController.text.toString() ==
                                      "RAYAFEST")
                                  ? "-" +
                                      _calculatePromo(_calculateTotal(
                                          _cartList[_cartList.length - 1]
                                              ["grandtotal"],
                                          deliverycharge,
                                          _promoController.text.toString()))
                                  : "0.00")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order Amount (RM)"),
                              Text(_calculateTotal(
                                  _cartList[_cartList.length - 1]["grandtotal"],
                                  deliverycharge,
                                  _promoController.text.toString()))
                            ],
                          ),
                        ),
                        Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - -"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payment Method"),
                              Text((hasbeenPressed == true) ? "Cash" : "Card")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 4);
                    },
                    child: Text("Ok", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              );
            });

        return;
      }
    });
  }
}
