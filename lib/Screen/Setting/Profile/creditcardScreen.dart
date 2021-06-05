import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Class/usercard.dart';

class CreditCardScreen extends StatefulWidget {
  final UserCard usercard;

  const CreditCardScreen({Key key, this.usercard}) : super(key: key);

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  TextEditingController _cardnumController = new TextEditingController();
  TextEditingController _cardholderController = new TextEditingController();
  TextEditingController _cvvController = new TextEditingController();
  TextEditingController _validmonthController = new TextEditingController();
  TextEditingController _validyearController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardnumController =
        new TextEditingController(text: widget.usercard.card_number);
    _cardholderController =
        new TextEditingController(text: widget.usercard.card_holder);
    _cvvController = new TextEditingController(text: widget.usercard.cvv);
    _validmonthController =
        new TextEditingController(text: widget.usercard.month);
    _validyearController =
        new TextEditingController(text: widget.usercard.year);
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
              "Bank Card",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              creditcard(),
              SizedBox(height: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Card Number (required)", style: TextStyle(fontSize: 18)),
                Container(
                    color: Theme.of(context).backgroundColor,
                    width: double.infinity,
                    child: TextField(
                        controller: _cardnumController,
                        cursorColor: Theme.of(context).primaryColorDark,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).primaryColorLight))),
                        style: TextStyle(fontSize: 18))),
                Text("Cardholder Name", style: TextStyle(fontSize: 18)),
                Container(
                    color: Theme.of(context).backgroundColor,
                    width: double.infinity,
                    child: TextField(
                        controller: _cardholderController,
                        cursorColor: Theme.of(context).primaryColorDark,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).primaryColorLight))),
                        style: TextStyle(fontSize: 18))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text("Security Code (CVV)",
                            style: TextStyle(fontSize: 18)),
                        Container(
                            color: Theme.of(context).backgroundColor,
                            width: 160,
                            child: TextField(
                                controller: _cvvController,
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
                        Text("Valid Thru", style: TextStyle(fontSize: 18)),
                        Row(
                          children: [
                            Container(
                                color: Theme.of(context).backgroundColor,
                                width: 70,
                                child: TextField(
                                    controller: _validmonthController,
                                    cursorColor:
                                        Theme.of(context).primaryColorDark,
                                    decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColorLight))),
                                    style: TextStyle(fontSize: 18))),
                            SizedBox(width: 20),
                            Container(
                                color: Theme.of(context).backgroundColor,
                                width: 70,
                                child: TextField(
                                    controller: _validyearController,
                                    cursorColor:
                                        Theme.of(context).primaryColorDark,
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
                  ],
                ),
              ]),
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
                          _cardValidation();
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save Card",
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
        )));
  }

  Widget creditcard() {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[800],
                offset: Offset(5.0, 8.0),
                blurRadius: 6.0,
              ),
            ],
            gradient: LinearGradient(
                colors: [Colors.deepPurple[900], Colors.indigoAccent[700]]),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 220,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Credit/Debit Card",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Transform.rotate(
                    angle: 3.142 / 2,
                    child: Icon(
                      Icons.wifi,
                      color: Colors.white,
                    )),
              ],
            ),
            SizedBox(height: 15),
            Container(
                height: 45,
                width: 45,
                child: Image.asset("assets/images/cardchip.png")),
            SizedBox(height: 5),
            Container(
                child: Text(
                    (widget.usercard.card_number == "")
                        ? "xxxx xxxx xxxx xxxx"
                        : widget.usercard.card_number,
                    style: TextStyle(
                        letterSpacing: 5, fontSize: 18, color: Colors.white))),
            SizedBox(width: 80),
            Center(
              child: Column(
                children: [
                  Container(
                      child: Text("GOOD THRU",
                          style: TextStyle(fontSize: 8, color: Colors.white))),
                  Container(
                      child: Text(
                          (widget.usercard.month == "")
                              ? "month/year"
                              : widget.usercard.month +
                                  "/" +
                                  widget.usercard.year,
                          style: TextStyle(fontSize: 14, color: Colors.white))),
                ],
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                        (widget.usercard.card_holder == "")
                            ? "Card Holder"
                            : widget.usercard.card_holder,
                        style: TextStyle(fontSize: 18, color: Colors.white))),
                Container(
                  width: 70,
                  child: Image.asset("assets/images/visamaster.png"),
                ),
              ],
            ),
          ]),
        ),
      ),
      back: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[800],
                  offset: Offset(5.0, 8.0),
                  blurRadius: 6.0,
                ),
              ],
              gradient: LinearGradient(
                  colors: [Colors.deepPurple[900], Colors.indigoAccent[700]]),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: 220,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                  width: double.infinity, height: 40, color: Colors.black),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Container(width: 150, height: 40, color: Colors.white),
                  Container(
                    color: Colors.white,
                    height: 40,
                    child: Text(
                        (widget.usercard.cvv == "")
                            ? "cvv"
                            : widget.usercard.cvv,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/meps.png")),
                ),
              )
            ],
          )),
    );
  }

  void _savecard() {
    String email = widget.usercard.email;
    String card_id = widget.usercard.card_id;// ignore: non_constant_identifier_names
    String card_number = (_cardnumController.text.toString() == "")// ignore: non_constant_identifier_names
        ? widget.usercard.card_number
        : _cardnumController.text.toString();
    String card_holder = (_cardholderController.text.toString() == "")// ignore: non_constant_identifier_names
        ? widget.usercard.card_holder
        : _cardholderController.text.toString();
    String cvv = (_cvvController.text.toString() == "")
        ? widget.usercard.cvv
        : _cvvController.text.toString();
    String month = (_validmonthController.text.toString() == "")
        ? widget.usercard.month
        : _validmonthController.text.toString();
    String year = (_validyearController.text.toString() == "")
        ? widget.usercard.year
        : _validyearController.text.toString();
    print(card_number);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/editCard.php"),
        body: {
          "email": email,
          "card_id": card_id,
          "card_number": card_number,
          "card_holder": card_holder,
          "cvv": cvv,
          "year": year,
          "month": month,
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
                  child: Text("Card updated succesful"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {});
                      }),
                ],
              );
            });

        widget.usercard.card_number = card_number;
        widget.usercard.card_holder = card_holder;
        widget.usercard.cvv = cvv;
        widget.usercard.month = month;
        widget.usercard.year = year;
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
                  child: Text("Update card failed. Please try again"),
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
  }

  void _addCard() {
    print("one");

    String email = widget.usercard.email;
    String card_id = widget.usercard.card_id;// ignore: non_constant_identifier_names
    String card_number = (_cardnumController.text.toString() == "")// ignore: non_constant_identifier_names
        ? widget.usercard.card_number
        : _cardnumController.text.toString();
    String card_holder = (_cardholderController.text.toString() == "")// ignore: non_constant_identifier_names
        ? widget.usercard.card_holder
        : _cardholderController.text.toString();
    String cvv = (_cvvController.text.toString() == "")
        ? widget.usercard.cvv
        : _cvvController.text.toString();
    String month = (_validmonthController.text.toString() == "")
        ? widget.usercard.month
        : _validmonthController.text.toString();
    String year = (_validyearController.text.toString() == "")
        ? widget.usercard.year
        : _validyearController.text.toString();
    print(card_number);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/addCard.php"),
        body: {
          "email": email,
          "card_id": card_id,
          "card_number": card_number,
          "card_holder": card_holder,
          "cvv": cvv,
          "month": month,
          "year": year,
        }).then((response) {
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
                  child: Text("Card add failed. Please try again"),
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
                    Container(child: Text("Saved")),
                  ],
                ),
                content: Container(
                  height: 25,
                  child: Text("Card saved successfully"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {});
                      }),
                ],
              );
            });
        widget.usercard.email = email;
        widget.usercard.card_number = card_number;
        widget.usercard.card_holder = card_holder;
        widget.usercard.cvv = cvv;
        widget.usercard.month = month;
        widget.usercard.year = year;
      }
    });
  }

  void _cardValidation() {
    if (_cardnumController.text.length < 16) {
      Fluttertoast.showToast(
          msg: "Invalid card number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);

      return;
    } else if (_cvvController.text.toString() == "") {
      Fluttertoast.showToast(
          msg: "CVV required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } else if (_validmonthController.text.toString() == "" ||
        _validyearController.text.toString() == "") {
      Fluttertoast.showToast(
          msg: "Invalid month or year",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      if (widget.usercard.card_id == "") {
        _addCard();
      } else {
        _savecard();
      }
    }
  }
}
