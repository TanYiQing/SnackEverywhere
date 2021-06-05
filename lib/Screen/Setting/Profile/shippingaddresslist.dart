import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/shippingaddressScreen.dart';
import 'package:snackeverywhere/Class/s_address.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;

class ShippingAddressListScreen extends StatefulWidget {
  final User user;

  const ShippingAddressListScreen({Key key, this.user}) : super(key: key);

  @override
  _ShippingAddressListScreenState createState() =>
      _ShippingAddressListScreenState();
}

class _ShippingAddressListScreenState extends State<ShippingAddressListScreen> {
  double screenHeight;
  double screenWidth;
  List _shippingAddressList;
  String _titlecenter = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadShippingAddress();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _addAddress();
                },
              ),
            ],
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
              "Shipping Address",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )),
        body: Center(
            child: Container(
                child: Column(children: [
          _shippingAddressList == null
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
                )))
              : Flexible(
                  child: Center(
                    child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: (screenWidth / screenHeight) / 0.17,
                        children:
                            List.generate(_shippingAddressList.length, (index) {
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
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _shippingAddressList[index]
                                                ["s_name"],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                              _shippingAddressList[index]
                                                  ["s_phone"],
                                              style: TextStyle(fontSize: 18)),
                                          Row(
                                            children: [
                                              Text(_shippingAddressList[index]
                                                  ["s_address1"]),
                                              Text(","),
                                              Text(_shippingAddressList[index]
                                                  ["s_address2"]),
                                            ],
                                          ),
                                          Text(_shippingAddressList[index]
                                              ["s_address3"]),
                                          Row(
                                            children: [
                                              Text(_shippingAddressList[index]
                                                  ["s_zip"]),
                                              Text(" "),
                                              Text(_shippingAddressList[index]
                                                  ["s_city"]),
                                            ],
                                          ),
                                          Text(_shippingAddressList[index]
                                              ["s_state"]),
                                        ]),
                                  ),
                                ),
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Edit',
                                    color: Colors.black45,
                                    icon: Icons.edit,
                                    onTap: () {
                                      _editAddress(index);
                                    },
                                  ),
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
                                                height: 70,
                                                child: Text(
                                                    "Are you sure to delete this?"),
                                              ),
                                              actions: [
                                                TextButton(
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blue)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                TextButton(
                                                    child: Text("Confirm",
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _deleteAddress(index);
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
                ),
        ]))));
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

  void _deleteAddress(int index) {
    String shippingId = _shippingAddressList[index]["shipping_id"];
    print(shippingId);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/deleteShippingAddress.php"),
        body: {
          "shipping_id": shippingId,
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
                  child: Text("Address deleted successfully"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _loadShippingAddress();
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
                  child: Text("Address delete failed. Please try again"),
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
                        _deleteAddress(index);
                      })
                ],
              );
            });
      }
    });
  }

  void _editAddress(index) {
    S_Address s_address = new S_Address(// ignore: non_constant_identifier_names
        email: widget.user.email,
        s_name: _shippingAddressList[index]["s_name"],
        shipping_id: _shippingAddressList[index]["shipping_id"],
        s_phone: _shippingAddressList[index]["s_phone"],
        s_address1: _shippingAddressList[index]["s_address1"],
        s_address2: _shippingAddressList[index]["s_address2"],
        s_address3: _shippingAddressList[index]["s_address3"],
        s_zip: _shippingAddressList[index]["s_zip"],
        s_city: _shippingAddressList[index]["s_city"]);
    print(_shippingAddressList[index]["shipping_id"]);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => ShippingAddressScreen(s_address: s_address)));
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
