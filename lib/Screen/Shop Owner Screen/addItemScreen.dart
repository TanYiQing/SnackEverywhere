import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController _productnameController = new TextEditingController();
  TextEditingController _productdescController = new TextEditingController();
  TextEditingController _smallpriceController = new TextEditingController();
  TextEditingController _smallqtyController = new TextEditingController();
  TextEditingController _largepriceController = new TextEditingController();
  TextEditingController _largeqtyController = new TextEditingController();
  TextEditingController _instockqtysmallController = new TextEditingController();
  TextEditingController _instockqtylargeController = new TextEditingController();
  String pathAsset = "assets/images/addimg.png";
  String product_cat;// ignore: non_constant_identifier_names
  File _image;
  int _categoryValue;
  bool _smallValue = false;
  bool _largeValue = false;
  bool _enableSmall = false;
  bool _enableLarge = false;
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
              "Add Item",
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _choosePhoto();
              },
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _image == null
                              ? AssetImage("assets/images/addimg.png")
                              : FileImage(_image))),
                ),
              ),
            ),
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
                    maxLength: 150,
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
                value: _smallValue,
                onChanged: (bool value) {
                  setState(() {
                    _smallValue = value;
                    _enableSmall = value;
                    _smallpriceController.text = "";
                    _smallqtyController.text = "";
                  });
                },
              ),
              Text("Small"),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(children: [
                Text(
                  "Price: RM",
                  style: TextStyle(
                      color: (_enableSmall == true)
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 100,
                      height: 30,
                      color: (_enableSmall == true)
                          ? Theme.of(context).backgroundColor
                          : Theme.of(context).primaryColor,
                      child: TextField(
                          enabled: _enableSmall,
                          controller: _smallpriceController,
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
                SizedBox(width: 20),
                Text(
                  "Quantity:",
                  style: TextStyle(
                      color: (_enableSmall == true)
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 100,
                      height: 30,
                      color: (_enableSmall == true)
                          ? Theme.of(context).backgroundColor
                          : Theme.of(context).primaryColor,
                      child: TextField(
                          enabled: _enableSmall,
                          controller: _smallqtyController,
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
              ]),
            ),
            Row(children: [
              Checkbox(
                value: _largeValue,
                onChanged: (bool value) {
                  setState(() {
                    _largeValue = value;
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
                    style: TextStyle(
                        color: (_enableLarge == true)
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100,
                        height: 30,
                        color: (_enableLarge == true)
                            ? Theme.of(context).backgroundColor
                            : Theme.of(context).primaryColor,
                        child: TextField(
                            enabled: _largeValue,
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
                    style: TextStyle(
                        color: (_enableLarge == true)
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).primaryColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100,
                        height: 30,
                        color: (_enableLarge == true)
                            ? Theme.of(context).backgroundColor
                            : Theme.of(context).primaryColor,
                        child: TextField(
                            enabled: _largeValue,
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
                      color: (_enableSmall==true)?Theme.of(context).backgroundColor:Theme.of(context).primaryColor,
                      child: TextField(enabled: _enableSmall,
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
                      color: (_enableLarge==true)?Theme.of(context).backgroundColor:Theme.of(context).primaryColor,
                      child: TextField(enabled: _enableLarge,
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
                        _publishProduct();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Product",
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

  void _choosePhoto() {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).cardColor,
        content: Container(
          height: 110,
          child: Column(
            children: [
              Text("Profile Photo",
                  style: TextStyle(
                      fontSize: 25, color: Theme.of(context).primaryColorDark)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          _chooseRemove();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            Text(
                              "Remove",
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          _chooseGallery();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.image_rounded, color: Colors.purple),
                            Text(
                              "Gallery",
                              style: TextStyle(color: Colors.purple),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          _chooseCamera();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt_rounded, color: Colors.blue),
                            Text(
                              "Camera",
                              style: TextStyle(color: Colors.blue),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                  Container(
                      height: 60,
                      width: 60,
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.undo,
                                color: Theme.of(context).primaryColorDark),
                            Text(
                              "Undo",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _chooseRemove() {
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
                Container(child: Text("Delete Photo")),
              ],
            ),
            content: Container(
              height: 25,
              child: Text("Are you confirm to delete photo?"),
            ),
            actions: [
              TextButton(
                  child: Text("Cancel", style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }),
              TextButton(
                  child: Text("Ok", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    setState(() {
                      _image = null;
                    });
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }),
            ],
          );
        });
  }

  Future<void> _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Image Selected");
    }
    _cropImage();
  }

  Future<void> _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Imgae Selected");
    }
    _cropImage();
  }

  _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).accentColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _publishProduct() {
    String product_name = _productnameController.text.toString();// ignore: non_constant_identifier_names
    String product_desc = _productdescController.text.toString();// ignore: non_constant_identifier_names
    String product_small_price = _smallpriceController.text.toString();// ignore: non_constant_identifier_names
    String product_small_qty = _smallqtyController.text.toString();// ignore: non_constant_identifier_names
    String product_large_price = _largepriceController.text.toString();// ignore: non_constant_identifier_names
    String product_large_qty = _largeqtyController.text.toString();// ignore: non_constant_identifier_names
    String instock_qtysmall = _instockqtysmallController.text.toString();// ignore: non_constant_identifier_names
    String instock_qtylarge = _instockqtylargeController.text.toString();// ignore: non_constant_identifier_names
    String base64Image = base64Encode(_image.readAsBytesSync());
    print(product_name);
    print(product_desc);
    print(product_small_price);
    print(product_small_qty);
    print(product_large_price);
    print(product_large_qty);
    print(instock_qtysmall);
    print(instock_qtylarge);
    print(product_cat);

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/publishProduct.php"),
        body: {
          "product_name": product_name,
          "product_desc": product_desc,
          "product_small_price": product_small_price,
          "product_small_qty": product_small_qty,
          "product_large_price": product_large_price,
          "product_large_qty": product_large_qty,
          "product_cat": product_cat,
          "instock_qtysmall": instock_qtysmall,
          "instock_qtylarge": instock_qtylarge,
          "encoded_string": base64Image,
        }).then((response) {
      print(response.body);
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Product published",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          _productnameController.text = "";
          _productdescController.text = "";
          _smallValue = false;
          _enableSmall = false;
          _largeValue = false;
          _enableLarge = false;
          _smallpriceController.text = "";
          _smallqtyController.text = "";
          _largepriceController.text = "";
          _largeqtyController.text = "";
          _categoryValue = 0;
          _instockqtysmallController.text = "";
          _instockqtylargeController.text = "";
          _image=null;
        });
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Publish failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        return;
      }
    });
  }
}


/*#Take Note Here:
IF user didnt enter any input, then cannot publish!!*/