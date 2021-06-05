import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:snackeverywhere/Class/user.dart';

class ChangePasswordScreen extends StatefulWidget {
  final User user;

  const ChangePasswordScreen({Key key, this.user}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldpassController = new TextEditingController();

  TextEditingController _newpassController = new TextEditingController();

  TextEditingController _confirmnewpassController = new TextEditingController();
  bool _ishidden = true;
  bool _ishidden1 = true;
  bool _ishidden2 = true;

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
            "Change Password",
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
                      child: Image.asset("assets/images/changepwd.png"))),
              SizedBox(height: 20),
              Text("Current Password", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      obscureText: _ishidden,
                      controller: _oldpassController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_ishidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Theme.of(context).primaryColorLight,
                            onPressed: () {
                              _togglePassword("old");
                            },
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 10),
              Text("New Password", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      obscureText: _ishidden1,
                      controller: _newpassController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_ishidden1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Theme.of(context).primaryColorLight,
                            onPressed: () {
                              _togglePassword("new");
                            },
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 10),
              Text("Confirm New Password", style: TextStyle(fontSize: 18)),
              Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: TextField(
                      obscureText: _ishidden2,
                      controller: _confirmnewpassController,
                      cursorColor: Theme.of(context).primaryColorDark,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_ishidden2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Theme.of(context).primaryColorLight,
                            onPressed: () {
                              _togglePassword("confirm");
                            },
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight))),
                      style: TextStyle(fontSize: 18))),
              SizedBox(height: 10),
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
                          _onChangedPassword();
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

  void _togglePassword(String title) {
    if (title == "old") {
      setState(() {
        _ishidden = !_ishidden;
      });
    } else if (title == "new") {
      setState(() {
        _ishidden1 = !_ishidden1;
      });
    } else {
      setState(() {
        _ishidden2 = !_ishidden2;
      });
    }
  }

  void _onChangedPassword() {
    String oldpassword = _oldpassController.text.toString();
    String newpassword = _newpassController.text.toString();
    String confirmnewpassword = _confirmnewpassController.text.toString();
    if (oldpassword.isEmpty ||
        newpassword.isEmpty ||
        confirmnewpassword.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (newpassword.length < 7 && confirmnewpassword.length < 7) {
      Fluttertoast.showToast(
          msg: "Please set password with at least 8 characters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (newpassword.contains(RegExp(r'[A-Z]')) == false) {
      Fluttertoast.showToast(
          msg: "Please contains at least one uppercase",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (newpassword.contains(RegExp(r'[0-9]')) == false) {
      Fluttertoast.showToast(
          msg: "Please contains at least one number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (newpassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
        false) {
      Fluttertoast.showToast(
          msg: "Please contains at least one special character",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (newpassword != confirmnewpassword) {
      Fluttertoast.showToast(
          msg: "Password Mismatch",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else {
      _changingPassword(oldpassword, newpassword);
    }
  }

  void _changingPassword(String oldpassword, String newpassword) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/changePassword.php"),
        body: {
          "oldpassword": oldpassword,
          "newpassword": newpassword,
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
                    Container(child: Text("Congratulation!")),
                  ],
                ),
                content: Container(
                  height: 25,
                  child: Text("Password changed successfully"),
                ),
                actions: [
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _oldpassController.text = "";
                        _newpassController.text = "";
                        _confirmnewpassController.text = "";
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
                  child: Text("Password change failed. Please check if you insert the correct 'Current Password'"),
                ),
                actions: [
                  TextButton(
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _oldpassController.text = "";
                        _newpassController.text = "";
                        _confirmnewpassController.text = "";
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
}
