import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/b_address.dart';
import 'package:http/http.dart' as http;

class BillingAddressScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final B_Address b_address;
  // ignore: non_constant_identifier_names
  const BillingAddressScreen({Key key, this.b_address}) : super(key: key);
  @override
  _BillingAddressScreenState createState() => _BillingAddressScreenState();
}

class _BillingAddressScreenState extends State<BillingAddressScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _address1Controller = new TextEditingController();
  TextEditingController _address2Controller = new TextEditingController();
  TextEditingController _address3Controller = new TextEditingController();
  TextEditingController _zipController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _stateController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text: widget.b_address.b_name);
    _phoneController =
        new TextEditingController(text: widget.b_address.b_phone);
    _address1Controller =
        new TextEditingController(text: widget.b_address.b_address1);
    _address2Controller =
        new TextEditingController(text: widget.b_address.b_address2);
    _address3Controller =
        new TextEditingController(text: widget.b_address.b_address3);
    _zipController = new TextEditingController(text: widget.b_address.b_zip);
    _cityController = new TextEditingController(text: widget.b_address.b_city);
    _stateController =
        new TextEditingController(text: widget.b_address.b_state);
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
            "Billing Address",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      height: 250,
                      width: 250,
                      child: Image.asset("assets/images/billing.png"))),
              SizedBox(height: 20),
              Text("Name (required)", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      controller: _nameController,
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
                          color: Theme.of(context).backgroundColor,
                          width: 200,
                          child: TextField(
                              controller: _cityController,
                              cursorColor: Theme.of(context).primaryColorDark,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorLight))),
                              style: TextStyle(fontSize: 18))),
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
                      controller: _stateController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
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
                          if (widget.b_address.billing_id == "") {
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
      String email = widget.b_address.email;
      String billing_id = widget.b_address.billing_id;// ignore: non_constant_identifier_names
      String b_name = (_nameController.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_name
          : _nameController.text.toString();
      String b_phone = (_phoneController.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_phone
          : _phoneController.text.toString();
      String b_address1 = (_address1Controller.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_address1
          : _address1Controller.text.toString();
      String b_address2 = (_address2Controller.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_address2
          : _address2Controller.text.toString();
      String b_address3 = (_address3Controller.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_address3
          : _address3Controller.text.toString();
      String b_zip = (_zipController.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_zip
          : _zipController.text.toString();
      String b_city = (_cityController.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_city
          : _cityController.text.toString();
      String b_state = (_stateController.text.toString() == "")// ignore: non_constant_identifier_names
          ? widget.b_address.b_state
          : _stateController.text.toString();
      print(billing_id);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/editBillingAddress.php"),
          body: {
            "email": email,
            "billing_id": billing_id,
            "b_name": b_name,
            "b_phone": b_phone,
            "b_address1": b_address1,
            "b_address2": b_address2,
            "b_address3": b_address3,
            "b_zip": b_zip,
            "b_city": b_city,
            "b_state": b_state,
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
                    child: Text("Billing address updated successfully"),
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
          widget.b_address.b_name = b_name;
          widget.b_address.b_phone = b_phone;
          widget.b_address.b_address1 = b_address1;
          widget.b_address.b_address2 = b_address2;
          widget.b_address.b_address3 = b_address3;
          widget.b_address.b_zip = b_zip;
          widget.b_address.b_city = b_city;
          widget.b_address.b_state = b_state;
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
      String email = widget.b_address.email;
      String billing_id = widget.b_address.billing_id;// ignore: non_constant_identifier_names
      String b_name = _nameController.text.toString();// ignore: non_constant_identifier_names
      String b_phone = _phoneController.text.toString();// ignore: non_constant_identifier_names
      String b_address1 = _address1Controller.text.toString();// ignore: non_constant_identifier_names
      String b_address2 = _address2Controller.text.toString();// ignore: non_constant_identifier_names
      String b_address3 = _address3Controller.text.toString();// ignore: non_constant_identifier_names
      String b_zip = _zipController.text.toString();// ignore: non_constant_identifier_names
      String b_city = _cityController.text.toString();// ignore: non_constant_identifier_names
      String b_state = _stateController.text.toString();// ignore: non_constant_identifier_names
      print(b_name);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/addBillingAddress.php"),
          body: {
            "email": email,
            "billing_id": billing_id,
            "b_name": b_name,
            "b_phone": b_phone,
            "b_address1": b_address1,
            "b_address2": b_address2,
            "b_address3": b_address3,
            "b_zip": b_zip,
            "b_city": b_city,
            "b_state": b_state,
          }).then((response) {
        print(response.body);
        if (response.body == "Failed") {
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
                      Container(child: Text("Updated")),
                    ],
                  ),
                  content: Container(
                    height: 25,
                    child: Text("Billing address updated successfully"),
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
          widget.b_address.b_name = b_name;
          widget.b_address.b_phone = b_phone;
          widget.b_address.b_address1 = b_address1;
          widget.b_address.b_address2 = b_address2;
          widget.b_address.b_address3 = b_address3;
          widget.b_address.b_zip = b_zip;
          widget.b_address.b_city = b_city;
          widget.b_address.b_state = b_state;
        }
      });
    });
  }
}
