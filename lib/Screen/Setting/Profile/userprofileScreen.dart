import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/billingaddresslist.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/cardlist.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/changepasswordScreen.dart';
import 'package:snackeverywhere/Screen/Setting/Profile/shippingaddresslist.dart';
import 'package:snackeverywhere/Class/user.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;

  const UserProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  String pathAsset = "assets/images/user.png";
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ],
              ),
            ),
          ),
          title: Text(
            "User Profile",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary
                    ]),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                                "Hey," +
                                    widget.user.first_name +
                                    " " +
                                    widget.user.last_name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    Container(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Container(
                              height: 200,
                              width: 200,
                              child: ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: _image == null
                                              ? AssetImage(pathAsset)
                                              : FileImage(_image),
                                          fit: BoxFit.cover)),
                                ),
                              )),
                          Container(
                              width: 180,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.orange[800],
                                onPressed: () {
                                  _choosePhoto();
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Change Photo",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Icon(Icons.camera_alt,
                                          color: Colors.white)
                                    ]),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person),
                                  Text(
                                    "Profile",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )),
                              height: 50,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800],
                                      offset: Offset(5.0, 10.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _popUpFirstName();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "First Name",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Row(
                                            children: [
                                              Text(widget.user.first_name,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Icon(Icons
                                                  .arrow_forward_ios_rounded)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        _popUpLastName();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Last Name",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Row(
                                            children: [
                                              Text(widget.user.last_name,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Icon(Icons
                                                  .arrow_forward_ios_rounded)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Email",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Row(
                                          children: [
                                            Text(widget.user.email,
                                                style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (content) =>
                                                    ChangePasswordScreen(
                                                        user: widget.user)));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Change Password",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Icon(Icons.arrow_forward_ios_rounded)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_rounded),
                                  Text(
                                    "Address",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )),
                              height: 50,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800],
                                      offset: Offset(5.0, 10.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (content) =>
                                                    ShippingAddressListScreen(
                                                        user: widget.user)));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Shipping Address",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Icon(Icons.arrow_forward_ios_rounded)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (content) =>
                                                    BillingAddressListScreen(
                                                        user: widget.user)));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Billing Address",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Icon(Icons.arrow_forward_ios_rounded)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.credit_card_rounded),
                                  Text(
                                    "Credit/Debit Card",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )),
                              height: 50,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[800],
                                      offset: Offset(5.0, 10.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (content) =>
                                                    CardListScreen(
                                                        user: widget.user)));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Add Card",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Icon(Icons.add_box_outlined)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _popUpFirstName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              child: Text("First Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          content: Container(
              child: TextField(
            controller: _firstNameController,
            cursorColor: Colors.black,
            style: TextStyle(color: Theme.of(context).primaryColorDark),
            decoration: InputDecoration(
                hintText: widget.user.first_name,
                labelStyle:
                    TextStyle(color: Theme.of(context).primaryColorDark),
                icon: Icon(Icons.person,
                    color: Theme.of(context).primaryColorDark),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight))),
          )),
          actions: <Widget>[
            new TextButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text(
                "Update",
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _changeName();
              },
            )
          ],
        );
      },
    );
  }

  void _popUpLastName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              child: Text("Last Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          content: Container(
              child: TextField(
            controller: _lastNameController,
            cursorColor: Colors.black,
            style: TextStyle(color: Theme.of(context).primaryColorDark),
            decoration: InputDecoration(
                hintText: widget.user.last_name,
                labelStyle:
                    TextStyle(color: Theme.of(context).primaryColorDark),
                icon: Icon(Icons.person,
                    color: Theme.of(context).primaryColorDark),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight))),
          )),
          actions: <Widget>[
            new TextButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text(
                "Update",
                style: TextStyle(color: Theme.of(context).primaryColorDark),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _changeName();
              },
            )
          ],
        );
      },
    );
  }

  void _changeName() {
    setState(() {
      String firstname = widget.user.first_name;
      String lastname = widget.user.last_name;

      (_firstNameController.text.toString() == "")
          ? firstname = widget.user.first_name
          : firstname = _firstNameController.text.toString();
      (_lastNameController.text.toString() == "")
          ? lastname = widget.user.last_name
          : lastname = _lastNameController.text.toString();
      print(firstname);
      print(lastname);
      http.post(
          Uri.parse(
              "https://hubbuddies.com/270607/snackeverywhere/php/changeName.php"),
          body: {
            "firstname": firstname,
            "lastname": lastname,
            "email": widget.user.email,
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
                    child: Text("Name changed successfully"),
                  ),
                  actions: [
                    TextButton(
                        child: Text("Ok", style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _firstNameController.text = widget.user.first_name;
                          _lastNameController.text = widget.user.last_name;
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
                    child: Text("Name change failed. Please try again"),
                  ),
                  actions: [
                    TextButton(
                        child:
                            Text("Cancel", style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _firstNameController.text = "";
                          _lastNameController.text = "";
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
      widget.user.first_name = firstname;
      widget.user.last_name = lastname;
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
                            Icon(Icons.delete,
                                color: Colors.red),
                            Text(
                              "Remove",
                              style: TextStyle(
                                  color:Colors.red),
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
                            Icon(Icons.image_rounded,
                                color: Colors.purple),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                  color: Colors.purple),
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
                            Icon(Icons.camera_alt_rounded,
                                color: Colors.blue),
                            Text(
                              "Camera",
                              style: TextStyle(
                                  color: Colors.blue),
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

  Future<void> _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print("No Image Selected");
    }
    _cropImage();
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

  _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).accentColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    _postPhoto();

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _postPhoto() {
    String base64Image = base64Encode(_image.readAsBytesSync());
    print(base64Image);
  }
}
