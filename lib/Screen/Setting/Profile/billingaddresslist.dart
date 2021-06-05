import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/billingAddressScreen.dart';
import 'package:snackeverywhere/Class/b_address.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;

class BillingAddressListScreen extends StatefulWidget {
  final User user;

  const BillingAddressListScreen({Key key, this.user}) : super(key: key);

  @override
  _BillingAddressListScreenState createState() =>
      _BillingAddressListScreenState();
}

class _BillingAddressListScreenState extends State<BillingAddressListScreen> {
  double screenHeight;
  double screenWidth;
  List _billingAddressList;
  String _titlecenter = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadBillingAddress();
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
              "Billing Address",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )),
        body: Center(
            child: Container(
                child: Column(children: [
          _billingAddressList == null
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
                            List.generate(_billingAddressList.length, (index) {
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
                                            _billingAddressList[index]
                                                ["b_name"],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                              _billingAddressList[index]
                                                  ["b_phone"],
                                              style: TextStyle(fontSize: 18)),
                                          Row(
                                            children: [
                                              Text(_billingAddressList[index]
                                                  ["b_address1"]),
                                              Text(","),
                                              Text(_billingAddressList[index]
                                                  ["b_address2"]),
                                            ],
                                          ),
                                          Text(_billingAddressList[index]
                                              ["b_address3"]),
                                          Row(
                                            children: [
                                              Text(_billingAddressList[index]
                                                  ["b_zip"]),
                                              Text(" "),
                                              Text(_billingAddressList[index]
                                                  ["b_city"]),
                                            ],
                                          ),
                                          Text(_billingAddressList[index]
                                              ["b_state"]),
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

  void _loadBillingAddress() {
    String email = widget.user.email;
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loadBillingAddress.php"),
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
        _billingAddressList = jsondata["billingaddresses"];
        setState(() {});
        print(_billingAddressList);
      }
    });
  }

  void _deleteAddress(int index) {
    // ignore: non_constant_identifier_names
    String billing_id = _billingAddressList[index]["billing_id"];
    print(billing_id);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/deleteBillingAddress.php"),
        body: {
          "billing_id": billing_id,
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
                          _loadBillingAddress();
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
    // ignore: non_constant_identifier_names
    B_Address b_address = new B_Address(
        email: widget.user.email,
        b_name: _billingAddressList[index]["b_name"],
        billing_id: _billingAddressList[index]["billing_id"],
        b_phone: _billingAddressList[index]["b_phone"],
        b_address1: _billingAddressList[index]["b_address1"],
        b_address2: _billingAddressList[index]["b_address2"],
        b_address3: _billingAddressList[index]["b_address3"],
        b_zip: _billingAddressList[index]["b_zip"],
        b_city: _billingAddressList[index]["b_city"],
        b_state:_billingAddressList[index]["b_state"]);
        
    print(_billingAddressList[index]["billing_id"]);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => BillingAddressScreen(b_address: b_address)));
  }

  void _addAddress() {
    // ignore: non_constant_identifier_names
    B_Address b_address = new B_Address(
        email: widget.user.email,
        b_name:"",
        billing_id:"",
        b_phone: "",
        b_address1:"",
        b_address2: "",
        b_address3: "",
        b_zip: "",
        b_city: "",
        b_state:"");
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (content) => BillingAddressScreen(b_address: b_address)));
  }
}
