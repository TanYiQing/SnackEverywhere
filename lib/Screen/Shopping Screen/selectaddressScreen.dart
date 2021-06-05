import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/s_address.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Screen/Setting/Profile/shippingAddressScreen.dart';
import 'package:snackeverywhere/Screen/Shopping%20Screen/checkoutScreen.dart';

class SelectAddressScreen extends StatefulWidget {
  final User user;

  const SelectAddressScreen({Key key, this.user}) : super(key: key);
  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  String _titlecenter = "Loading...";
  double screenWidth;
  double screenHeight;
  List _shippingAddressList;

  @override
  void initState() {
    super.initState();
    _loadShippingAddress();
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
            "Select Address",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (_shippingAddressList == null)
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
                      itemCount: _shippingAddressList == null
                          ? 1
                          : _shippingAddressList.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _shippingAddressList.length) {
                          return GestureDetector(
                            onTap: () {
                              _addAddress();
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
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.asset(
                                              "assets/images/addaddress.png")),
                                      Text(
                                        "Add Address",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ))),
                            ),
                          );
                        }

                        return GestureDetector(
                          onTap: () {
                            _chooseAddress(index);
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
                                                  _shippingAddressList[index]
                                                      ["s_name"],
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                          _shippingAddressList == null
                                              ? Text("No Address")
                                              : Text(
                                                  _shippingAddressList[index]
                                                      ["email"],
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                          _shippingAddressList == null
                                              ? Text("No Address")
                                              : Text(
                                                  _shippingAddressList[index]
                                                      ["s_phone"],
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                          Row(
                                            children: [
                                              _shippingAddressList == null
                                                  ? Text("No Address")
                                                  : Text(
                                                      _shippingAddressList[
                                                                  index]
                                                              ["s_address1"] +
                                                          ",",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                              _shippingAddressList == null
                                                  ? Text("No Address")
                                                  : Text(
                                                      _shippingAddressList[
                                                                  index]
                                                              ["s_address2"] +
                                                          ",",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                            ],
                                          ),
                                          _shippingAddressList == null
                                              ? Text("No Address")
                                              : Text(
                                                  _shippingAddressList[index]
                                                          ["s_address3"] +
                                                      " ",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                          Row(
                                            children: [
                                              _shippingAddressList == null
                                                  ? Text("No Address")
                                                  : Text(
                                                      _shippingAddressList[
                                                              index]["s_zip"] +
                                                          " ",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                              _shippingAddressList == null
                                                  ? Text("No Address")
                                                  : Text(
                                                      _shippingAddressList[
                                                              index]["s_city"] +
                                                          ",",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                              _shippingAddressList == null
                                                  ? Text("No Address")
                                                  : Text(
                                                      _shippingAddressList[
                                                                  index]
                                                              ["s_state"] +
                                                          " ",
                                                      style: TextStyle(
                                                          fontSize: 16),
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
                      }),
                ),
        ],
      ),
    );
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

  void _chooseAddress(index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) =>
                CheckOutScreen(user: widget.user, data: index)));
  }

  void _addAddress() {
    S_Address s_address = new S_Address(// ignore: non_constant_identifier_names
        email: widget.user.email,
        s_name:"",
        shipping_id:"",
        s_phone: "",
        s_address1:"",
        s_address2: "",
        s_address3: "",
        s_zip: "",
        s_city: "",);
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => ShippingAddressScreen(s_address: s_address)));
  }
}
