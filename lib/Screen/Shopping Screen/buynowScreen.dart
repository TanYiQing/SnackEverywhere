import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/product.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Screen/Shopping%20Screen/checkoutScreen.dart';

class BuyNowScreen extends StatefulWidget {
  final Product product;
  final User user;

  const BuyNowScreen({Key key, this.product, this.user}) : super(key: key);

  @override
  _BuyNowScreenState createState() => _BuyNowScreenState();
}

class _BuyNowScreenState extends State<BuyNowScreen> {
  double screenWidth;
  double screenHeight;
  bool hasbeenPressed = true;
  bool hasbeenPressed1 = false;
  int qty = 1;
  TextEditingController _qtyController = new TextEditingController(text: "1");
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 28.0, right: 8.0),
          child: Container(
            height: 80,
            width: 80,
            child: FloatingActionButton(
                onPressed: () {
                  _buyNow();
                },
                backgroundColor: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Icon(Icons.shopping_bag_outlined),
                  ],
                )),
          ),
        ),
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
            "Select Variety",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: screenHeight / 2.5,
                    width: double.infinity,
                    child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://hubbuddies.com/270607/snackeverywhere/images/product/${widget.product.product_id}.png")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    elevation: 20,
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.product_name,
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("RM ", style: TextStyle(fontSize: 12)),
                                (hasbeenPressed1 == false)
                                    ? Text(
                                        (widget.product.instock_qtysmall == "0")
                                            ? "Sold Out"
                                            : widget
                                                .product.product_small_price,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.amber[800],
                                            fontWeight: FontWeight.bold))
                                    : Text(
                                        widget.product.instock_qtylarge == "0"
                                            ? "Sold Out"
                                            : (widget.product
                                                        .product_large_price ==
                                                    "0.00")
                                                ? "Not Available"
                                                : widget.product
                                                    .product_large_price,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.amber[800],
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Size",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MaterialButton(
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
                                child: Text("Small"),
                                color: hasbeenPressed == true
                                    ? Colors.amber[800]
                                    : Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (widget.product.instock_qtylarge ==
                                        "0") {
                                      hasbeenPressed1 = false;
                                      return null;
                                    } else {
                                      setState(() {
                                        hasbeenPressed = false;
                                        hasbeenPressed1 = true;
                                        print("P");
                                        print(hasbeenPressed);
                                        print("P1");
                                        print(hasbeenPressed1);
                                      });
                                    }
                                  },
                                  child: Text("Large"),
                                  color:
                                      (widget.product.instock_qtylarge == "0")
                                          ? Colors.grey[200]
                                          : (hasbeenPressed1 == true
                                              ? Colors.amber[800]
                                              : Colors.amber),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MaterialButton(
                                minWidth: 12,
                                onPressed: () {
                                  setState(() {
                                    qty = int.parse(
                                            _qtyController.text.toString()) -
                                        1;
                                    _qtyController.text = qty.toString();
                                  });
                                  print(qty);
                                },
                                child: Icon(Icons.remove, size: 12),
                                color: Colors.amber,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    width: 60,
                                    height: 30,
                                    child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: _qtyController,
                                        cursorColor:
                                            Theme.of(context).primaryColorDark,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColorDark),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        style: TextStyle(
                                          fontSize: 18,
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: MaterialButton(
                                  minWidth: 12,
                                  onPressed: () {
                                    setState(() {
                                      qty = int.parse(
                                              _qtyController.text.toString()) +
                                          1;
                                      _qtyController.text = qty.toString();
                                    });
                                    print(qty);
                                  },
                                  child: Center(
                                      child: Icon(
                                    Icons.add,
                                    size: 12,
                                  )),
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 10),
                    ])),
              ),
            ]),
          ),
        ));
  }

  void _buyNow() {
    String email = widget.user.email;
    // ignore: non_constant_identifier_names
    String product_id = widget.product.product_id;
    // ignore: non_constant_identifier_names
    String product_price;
    // ignore: non_constant_identifier_names
    String product_size;
    String quantity = _qtyController.text.toString();
    print(hasbeenPressed);
    print(hasbeenPressed1);
    if (hasbeenPressed == true) {
      product_price = widget.product.product_small_price;
    } else {
      product_price = widget.product.product_large_price;
    }

    if (hasbeenPressed == true) {
      product_size = "Small";
    } else {
      product_size = "Large";
    }

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/addCart.php"),
        body: {
          "email": email,
          "product_id": product_id,
          "product_price": product_price,
          "product_size": product_size,
          "quantity": quantity,
        }).then((response) {
      print(response.body);
      if (response.body == "Failed") {
        print("Failed");
      } else {
        print(response.body);

        Navigator.push(context, MaterialPageRoute(builder: (content)=>CheckOutScreen(user: widget.user,)));
      }
    });
  }
}
