import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/delivery.dart';
import 'package:snackeverywhere/Screen/mappage.dart';
import 'package:snackeverywhere/Widget/dropdownbutton.dart';
import 'package:snackeverywhere/Class/s_address.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ShippingAddressScreen extends StatefulWidget {
  final S_Address s_address; // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  const ShippingAddressScreen({Key key, this.s_address}) : super(key: key);

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _address1Controller = new TextEditingController();
  TextEditingController _address2Controller = new TextEditingController();
  TextEditingController _address3Controller = new TextEditingController();
  TextEditingController _zipController = new TextEditingController();
  // TextEditingController _userlocctrl = new TextEditingController();
  String address = "";

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text: widget.s_address.s_name);
    _phoneController =
        new TextEditingController(text: widget.s_address.s_phone);
    _address1Controller =
        new TextEditingController(text: widget.s_address.s_address1);
    _address2Controller =
        new TextEditingController(text: widget.s_address.s_address2);
    _address3Controller =
        new TextEditingController(text: widget.s_address.s_address3);
    _zipController = new TextEditingController(text: widget.s_address.s_zip);
  }

  @override
  Widget build(BuildContext context) {
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
          "Shipping Address",
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching_rounded, color: Colors.red),
            onPressed: () {
              _getUserCurrentLoc();
            },
          ),
          IconButton(
            icon: Icon(Icons.map_outlined, color: Colors.red),
            onPressed: () async {
              Delivery _del = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MapPage(),
                ),
              );
              print(address);
              setState(() {
                _address1Controller.text = _del.name + ", " + _del.subLocality;
                _address2Controller.text = _del.locality;
                _zipController.text = _del.postalCode;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: Image.asset("assets/images/shipping.png")),
              SizedBox(height: 20),
              Text("Name (required)", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      controller: _nameController,
                      maxLines: null,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 10),
              Text("Phone Number (required)", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      controller: _phoneController,
                      maxLines: null,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 10),
              Text("Address 1 (required)", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      controller: _address1Controller,
                      maxLines: null,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 10),
              Text("Address 2 (optional)", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      controller: _address2Controller,
                      maxLines: null,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 10),
              Text("Address 3 (optional)", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      controller: _address3Controller,
                      maxLines: null,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("ZIP Code", style: TextStyle(fontSize: 18)),
                      Container(
                          color: Theme.of(context).backgroundColor,
                          width: 130,
                          child: TextField(
                              controller: _zipController,
                              cursorColor: Theme.of(context).primaryColorDark,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorLight))),
                              style: TextStyle(fontSize: 18))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("City", style: TextStyle(fontSize: 18)),
                      Container(
                          width: 220,
                          color: Theme.of(context).backgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropDownButton(s_address: widget.s_address),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("State", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      maxLines: null,
                      enabled: false,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          hintText: "Penang",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                      width: 200,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.orange[800],
                        onPressed: () {
                          if (widget.s_address.shipping_id == "") {
                            _addAddress();
                          } else {
                            _saveChanges();
                          }
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save Changes",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.save_outlined, color: Colors.white)
                            ]),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    setState(() {
      String email = widget.s_address.email;
      // ignore: non_constant_identifier_names
      String shipping_id = widget.s_address.shipping_id;
      // ignore: non_constant_identifier_names
      String s_name = (_nameController.text.toString() == "")
          ? widget.s_address.s_name
          : _nameController.text.toString();
      // ignore: non_constant_identifier_names
      String s_phone = (_phoneController.text.toString() == "")
          ? widget.s_address.s_phone
          : _phoneController.text.toString();
      // ignore: non_constant_identifier_names
      String s_address1 = (_address1Controller.text.toString() == "")
          ? widget.s_address.s_address1
          : _address1Controller.text.toString();
      // ignore: non_constant_identifier_names
      String s_address2 = (_address2Controller.text.toString() == "")
          ? widget.s_address.s_address2
          : _address2Controller.text.toString();
      // ignore: non_constant_identifier_names
      String s_address3 = (_address3Controller.text.toString() == "")
          ? widget.s_address.s_address3
          : _address3Controller.text.toString();
      // ignore: non_constant_identifier_names
      String s_zip = (_zipController.text.toString() == "")
          ? widget.s_address.s_zip
          : _zipController.text.toString();
      // ignore: non_constant_identifier_names
      String s_city = widget.s_address.s_city;
      String s_state = "Penang"; // ignore: non_constant_identifier_names
      print(shipping_id);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/editShippingAddress.php"),
          body: {
            "email": email,
            "shipping_id": shipping_id,
            "s_name": s_name,
            "s_phone": s_phone,
            "s_address1": s_address1,
            "s_address2": s_address2,
            "s_address3": s_address3,
            "s_zip": s_zip,
            "s_city": s_city,
            "s_state": s_state,
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
                      Container(child: Text("Updated")),
                    ],
                  ),
                  content: Container(
                    height: 25,
                    child: Text("Shipping address updated successfully"),
                  ),
                  actions: [
                    TextButton(
                        child: Text("Ok", style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                );
              });
          widget.s_address.s_name = s_name;
          widget.s_address.s_phone = s_phone;
          widget.s_address.s_address1 = s_address1;
          widget.s_address.s_address2 = s_address2;
          widget.s_address.s_address3 = s_address3;
          widget.s_address.s_zip = s_zip;
          widget.s_address.s_city = s_city;
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
                    child: Text("Address change failed. Please try again"),
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
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
        }
      });
    });
  }

  void _addAddress() {
    setState(() {
      String email = widget.s_address.email;
      // ignore: non_constant_identifier_names
      String shipping_id = widget.s_address.shipping_id;
      // ignore: non_constant_identifier_names
      String s_name = _nameController.text.toString();
      // ignore: non_constant_identifier_names
      String s_phone = _phoneController.text.toString();
      // ignore: non_constant_identifier_names
      String s_address1 = _address1Controller.text.toString();
      // ignore: non_constant_identifier_names
      String s_address2 = _address2Controller.text.toString();
      // ignore: non_constant_identifier_names
      String s_address3 = _address3Controller.text.toString();
      // ignore: non_constant_identifier_names
      String s_zip = _zipController.text.toString();
      // ignore: non_constant_identifier_names
      String s_city = widget.s_address.s_city;
      // ignore: non_constant_identifier_names
      String s_state = "Penang";

      print(shipping_id);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/addShippingAddress.php"),
          body: {
            "email": email,
            "shipping_id": shipping_id,
            "s_name": s_name,
            "s_phone": s_phone,
            "s_address1": s_address1,
            "s_address2": s_address2,
            "s_address3": s_address3,
            "s_zip": s_zip,
            "s_city": s_city,
            "s_state": s_state,
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
                      Container(child: Text("Updated")),
                    ],
                  ),
                  content: Container(
                    height: 25,
                    child: Text("Shipping address updated successfully"),
                  ),
                  actions: [
                    TextButton(
                        child: Text("Ok", style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                );
              });
          widget.s_address.s_name = s_name;
          widget.s_address.s_phone = s_phone;
          widget.s_address.s_address1 = s_address1;
          widget.s_address.s_address2 = s_address2;
          widget.s_address.s_address3 = s_address3;
          widget.s_address.s_zip = s_zip;
          widget.s_address.s_city = s_city;
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
                    child: Text("Name change failed. Please try again"),
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
                          Navigator.of(context).pop();
                        })
                  ],
                );
              });
        }
      });
    });
  }

  _getUserCurrentLoc() async {
    await _determinePosition().then((value) => {_getPlace(value)});
    setState(
      () {},
    );
  }

  void _getPlace(Position pos) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    // this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.thoroughfare.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    address = name +
        "," +
        subLocality +
        ",\n" +
        locality +
        "," +
        postalCode +
        ",\n" +
        administrativeArea +
        "," +
        country;
    // _userlocctrl.text = address;
    print(address);

    setState(() {
      _address1Controller.text = name + ", " + subLocality;
      _address2Controller.text = locality;
      _zipController.text = postalCode;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
