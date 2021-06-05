import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snackeverywhere/Class/user.dart';

class ReportIssueScreen extends StatefulWidget {
  final User user;

  const ReportIssueScreen({Key key, this.user}) : super(key: key);

  @override
  _ReportIssueScreenState createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  TextEditingController _reportController = new TextEditingController();
  File _image;
  String pathAsset = "assets/images/addimg.png";

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
            "Report Issue",
            style: TextStyle(color: Theme.of(context).primaryColorDark),
          )),
      body: Stack(children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ]),
          ),
        ),
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(height: 10),
            Container(
              child: Text(
                  "   Hey, " +
                      widget.user.first_name +
                      " " +
                      widget.user.last_name,
                  style: TextStyle(fontSize: 20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("What issue are you facing?",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Center(
              child: Container(
                height: 250,
                width: 250,
                child: Image.asset("assets/images/bug.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[800],
                          offset: Offset(5.0, 8.0),
                          blurRadius: 6.0,
                        ),
                      ],
                      color: Theme.of(context).cardColor,
                    ),
                    child: TextField(
                      controller: _reportController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Tell us more...",
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      maxLength: 150,
                    ),
                  ),
                  Container(
                    height: 60,
                    color: Theme.of(context).cardColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _image == null
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    color: Theme.of(context).cardColor)
                                : Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(_image)))),
                          ),
                          IconButton(
                              icon: Icon(Icons.image),
                              onPressed: () {
                                _choosePhoto();
                              })
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 100,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Colors.orange[800],
                              onPressed: () {
                                _onSend();
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Send",
                                        style: TextStyle(color: Colors.white)),
                                    SizedBox(width: 10),
                                    Icon(Icons.send_sharp, color: Colors.white)
                                  ]),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        )
      ]),
    );
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

  Future<void> _cropImage() async {
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

  void _onSend() {
    String firstname = widget.user.first_name;
    String lastname = widget.user.last_name;
    String email = widget.user.email;
    String issue = _reportController.text.toString();
    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/report.php"),
        body: {
          "first_name": firstname,
          "last_name": lastname,
          "email": email,
          "issue": issue,
          "encoded_string": base64Image,
        }).then((response) {
      print(response.body);
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Issue reported",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          _reportController.text = "";
          _image = null;
        });
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Issue report failed",
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
