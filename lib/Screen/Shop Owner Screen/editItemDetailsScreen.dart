import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snackeverywhere/Class/product.dart';

class EditItemDetailsScreen extends StatefulWidget {
  final Product product;

  const EditItemDetailsScreen({Key key, this.product}) : super(key: key);

  @override
  _EditItemDetailsScreenState createState() => _EditItemDetailsScreenState();
}

class _EditItemDetailsScreenState extends State<EditItemDetailsScreen> {
  File _image;
  bool _nosmallValue = false;
  bool _havesmallValue = true;
  bool _nolargeValue = false;
  bool _havelargeValue = true;
  bool _enableSmall;
  bool _enableLarge;
  int _categoryValue;
  String product_cat; // ignore: non_constant_identifier_names
  TextEditingController _productnameController = new TextEditingController();
  TextEditingController _productdescController = new TextEditingController();
  TextEditingController _smallpriceController = new TextEditingController();
  TextEditingController _smallqtyController = new TextEditingController();
  TextEditingController _largepriceController = new TextEditingController();
  TextEditingController _largeqtyController = new TextEditingController();
  TextEditingController _instockqtysmallController =
      new TextEditingController();
  TextEditingController _instockqtylargeController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    _productnameController =
        TextEditingController(text: widget.product.product_name);
    _productdescController =
        TextEditingController(text: widget.product.product_desc);
    _smallpriceController = TextEditingController(
        text: (widget.product.product_small_price == "0.00")
            ? ""
            : widget.product.product_small_price);
    _smallqtyController = TextEditingController(
        text: (widget.product.product_small_qty == "0")
            ? ""
            : widget.product.product_small_qty);
    _largepriceController = TextEditingController(
        text: (widget.product.product_large_price == "0.00")
            ? ""
            : widget.product.product_large_price);
    _largeqtyController = TextEditingController(
        text: (widget.product.product_large_qty == "0")
            ? ""
            : widget.product.product_large_qty);
    _instockqtysmallController =
        TextEditingController(text: widget.product.instock_qtysmall);
    _instockqtylargeController =
        TextEditingController(text: widget.product.instock_qtylarge);
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
              "Edit Item Details",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
                child: (_image == null)
                    ? Container(
                        height: 150,
                        width: 150,
                        child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "https://hubbuddies.com/270607/snackeverywhere/images/product/${widget.product.product_id}.png"))
                    : Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: FileImage(_image))),
                      )),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 8.0),
              child: Text("Product Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Theme.of(context).backgroundColor,
                  height: 50,
                  width: double.infinity,
                  child: TextField(
                      controller: _productnameController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      style: TextStyle(fontSize: 18))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 8.0),
              child: Text("Product Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Theme.of(context).backgroundColor,
                  height: 150,
                  width: double.infinity,
                  child: TextField(
                      maxLines: 6,
                      controller: _productdescController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      style: TextStyle(fontSize: 18))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 8.0),
              child: Text("Product Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Row(children: [
              Checkbox(
                value: (widget.product.product_small_price == null)
                    ? _nosmallValue
                    : _havesmallValue,
                onChanged: (bool value) {
                  setState(() {
                    (widget.product.product_small_price == null)
                        ? _nosmallValue = value
                        : _havesmallValue = value;

                    if (value == false) {
                      _smallpriceController.text = "";
                      _smallqtyController.text = "";
                    } else {
                      _smallpriceController.text =
                          widget.product.product_small_price;
                      _smallqtyController.text =
                          widget.product.product_small_qty;
                    }
                    _enableSmall = value;
                  });
                },
              ),
              Text("Small"),
            ]),
            GestureDetector(
              onTap: () {
                print("ans");
                print(_enableSmall);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(children: [
                  Text(
                    "Price: RM",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100,
                        height: 30,
                        color: Theme.of(context).backgroundColor,
                        child: TextField(
                            enabled: _enableSmall,
                            controller: _smallpriceController,
                            cursorColor: Theme.of(context).primaryColorDark,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            style: TextStyle(fontSize: 18))),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Quantity:",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100,
                        height: 30,
                        color: Theme.of(context).backgroundColor,
                        child: TextField(
                            enabled: _enableSmall,
                            controller: _smallqtyController,
                            cursorColor: Theme.of(context).primaryColorDark,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            style: TextStyle(fontSize: 18))),
                  ),
                ]),
              ),
            ),
            Row(children: [
              Checkbox(
                value: (widget.product.product_large_price == "0.00")
                    ? _nolargeValue
                    : _havelargeValue,
                onChanged: (bool value) {
                  setState(() {
                    (widget.product.product_large_price == "0.00")
                        ? _nolargeValue = value
                        : _havelargeValue = value;
                    _enableLarge = value;
                    _largepriceController.text = "";
                    _largeqtyController.text = "";
                  });
                },
              ),
              Text("Large"),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(
                    "Price: RM",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100,
                        height: 30,
                        color: Theme.of(context).backgroundColor,
                        child: TextField(
                            enabled: _enableLarge,
                            controller: _largepriceController,
                            cursorColor: Theme.of(context).primaryColorDark,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            style: TextStyle(fontSize: 18))),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Quantity:",
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100,
                        height: 30,
                        color: Theme.of(context).backgroundColor,
                        child: TextField(
                            enabled: _enableLarge,
                            controller: _largeqtyController,
                            cursorColor: Theme.of(context).primaryColorDark,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            style: TextStyle(fontSize: 18))),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 8.0),
              child: Text("Product Category",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        groupValue: _categoryValue,
                        value: 0,
                        onChanged: _handleRadioButton,
                      ),
                      Text("Candy"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        groupValue: _categoryValue,
                        value: 1,
                        onChanged: _handleRadioButton,
                      ),
                      Text("Drink"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        groupValue: _categoryValue,
                        value: 2,
                        onChanged: _handleRadioButton,
                      ),
                      Text("Nut"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        groupValue: _categoryValue,
                        value: 3,
                        onChanged: _handleRadioButton,
                      ),
                      Text("Plum    "),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        groupValue: _categoryValue,
                        value: 4,
                        onChanged: _handleRadioButton,
                      ),
                      Text("Snack"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        groupValue: _categoryValue,
                        value: 5,
                        onChanged: _handleRadioButton,
                      ),
                      Text("Toy"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 8.0),
              child: Text("Instock Quantity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15),
                  child: Text("Instock Quantity(Small):"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Container(
                      width: 120,
                      height: 30,
                      color: Theme.of(context).backgroundColor,
                      child: TextField(
                          controller: _instockqtysmallController,
                          cursorColor: Theme.of(context).primaryColorDark,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          style: TextStyle(fontSize: 18))),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15),
                  child: Text("Instock Quantity(Large):"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Container(
                      width: 120,
                      height: 30,
                      color: Theme.of(context).backgroundColor,
                      child: TextField(
                          controller: _instockqtylargeController,
                          cursorColor: Theme.of(context).primaryColorDark,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          style: TextStyle(fontSize: 18))),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                        _editProduct();
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
                            Icon(Icons.add_business_rounded,
                                color: Colors.white)
                          ]),
                    )),
              ),
            ),
          ],
        )));
  }

  void _handleRadioButton(int value) {
    setState(() {
      _categoryValue = value;
      switch (_categoryValue) {
        case 0:
          product_cat = "Candy";
          break;
        case 1:
          product_cat = "Drink";
          break;
        case 2:
          product_cat = "Nut";
          break;
        case 3:
          product_cat = "Plum";
          break;
        case 4:
          product_cat = "Snack";
          break;
        case 5:
          product_cat = "Toy";
          break;
      }
    });
  }

  void _editProduct() {
    setState(() {
      // ignore: non_constant_identifier_names
      String product_id = widget.product.product_id;
      // ignore: non_constant_identifier_names
      String product_name = _productnameController.text.toString();
      // ignore: non_constant_identifier_names
      String product_desc = _productdescController.text.toString();
      // ignore: non_constant_identifier_names
      String product_small_price = _smallpriceController.text.toString();
      // ignore: non_constant_identifier_names
      String product_small_qty = _smallqtyController.text.toString();
      // ignore: non_constant_identifier_names
      String product_large_price = _largepriceController.text.toString();
      // ignore: non_constant_identifier_names
      String product_large_qty = _largeqtyController.text.toString();
      // ignore: non_constant_identifier_names
      String product_cate = product_cat;
      // ignore: non_constant_identifier_names
      String instock_qtysmall = _instockqtysmallController.text.toString();
      // ignore: non_constant_identifier_names
      String instock_qtylarge = _instockqtylargeController.text.toString();

      print(_categoryValue);
      print(product_id);
      print(product_name);
      print(product_desc);
      print(product_small_price);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/editProduct.php"),
          body: {
            "product_id": product_id,
            "product_name": product_name,
            "product_desc": product_desc,
            "product_small_price": product_small_price,
            "product_small_qty": product_small_qty,
            "product_large_price": product_large_price,
            "product_large_qty": product_large_qty,
            "product_cat": product_cate,
            "instock_qtysmall": instock_qtysmall,
            "instock_qtylarge": instock_qtylarge,
            // "encoded_string":base64Image,
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
                    child: Text("Item updated successfully"),
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
          widget.product.product_name = product_name;
          widget.product.product_desc = product_desc;
          widget.product.product_small_price = product_small_price;
          widget.product.product_small_qty = product_small_qty;
          widget.product.product_large_price = product_large_price;
          widget.product.product_large_qty = product_large_qty;
          widget.product.product_cat = product_cat;
          widget.product.instock_qtysmall = instock_qtysmall;
          widget.product.instock_qtylarge = instock_qtylarge;
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
                    child: Text("Item change failed. Please try again"),
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
}
