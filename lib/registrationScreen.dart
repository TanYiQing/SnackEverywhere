import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'loginScreen.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _ishidden = true;
  bool _ishidden1 = true;
  bool _tnc = false;
  double screenHeight;
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmpasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Stack(
          children: [
            Container(
              child: Image.asset("assets/images/snackstore.jpg"),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                      height: 135,
                      width: 135,
                      child: Image.asset("assets/images/Logo.png")),
                  SizedBox(height: 35),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange[400], Colors.yellowAccent]),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("SIGN UP",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          width: 350,
                          child: TextField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                  labelText: "First Name",
                                  icon: Icon(Icons.person_outline))),
                        ),
                        Container(
                          width: 350,
                          child: TextField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                  labelText: "Last Name",
                                  icon: Icon(Icons.person_outline))),
                        ),
                        Container(
                          width: 350,
                          child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  icon: Icon(Icons.email_outlined))),
                        ),
                        Container(
                          width: 350,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _ishidden,
                            decoration: InputDecoration(
                                labelText: "Password",
                                icon: Icon(Icons.lock_outlined),
                                suffixIcon: IconButton(
                                    icon: Icon(_ishidden
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: _togglePassword1)),
                          ),
                        ),
                        Container(
                          width: 350,
                          child: TextField(
                            controller: _confirmpasswordController,
                            obscureText: _ishidden1,
                            decoration: InputDecoration(
                                labelText: "Confirm Password",
                                icon: Icon(Icons.lock_outlined),
                                suffixIcon: IconButton(
                                    icon: Icon(_ishidden1
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: _togglePassword2)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 350,
                          child: FlutterPwValidator(
                              controller: _passwordController,
                              minLength: 8,
                              uppercaseCharCount: 1,
                              numericCharCount: 1,
                              specialCharCount: 1,
                              width: 350,
                              height: 95,
                              defaultColor: Colors.black,
                              onSuccess: () {}),
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              width: 200,
                              height: 50,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Sign Up",
                                        style: TextStyle(fontSize: 20)),
                                  ]),
                            ),
                            color: Colors.orange[800],
                            onPressed: () {
                              if (_tnc == true) {
                                userRegister();
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please agree on terms and conditions",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                return;
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: GFCheckbox(
                                  type: GFCheckboxType.circle,
                                  inactiveBgColor: GFColors.TRANSPARENT,
                                  activeBgColor: GFColors.SUCCESS,
                                  value: _tnc,
                                  onChanged: _checkbox),
                            ),
                            SizedBox(width: 10),
                            Text("I agree to", style: TextStyle(fontSize: 10)),
                            TextButton(
                                onPressed: () {
                                  _showTNC();
                                },
                                child: Text("Terms and Conditions",
                                    style: TextStyle(fontSize: 10)))
                          ],
                        ),
                        SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already our member?",
                              style: TextStyle(fontSize: 17),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (content) => LoginScreen()));
                                },
                                child: Text("Sign In",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 17)))
                          ],
                        ),
                        SizedBox(height: 6),
                        Text("Copyright Reserved by Tan Yi Qing @ 2021",
                            style: TextStyle(fontSize: 8)),
                        SizedBox(height: 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void userRegister() {
    String _firstName = _firstNameController.text.toString();
    String _lastName = _lastNameController.text.toString();
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    String _confirmpassword = _confirmpasswordController.text.toString();

    if (_firstName.isEmpty ||
        _lastName.isEmpty ||
        _email.isEmpty ||
        _password.isEmpty ||
        _confirmpassword.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (_email.contains(RegExp(r'[@]')) == false) {
      Fluttertoast.showToast(
          msg: "Invalid Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (_password != _confirmpassword) {
      Fluttertoast.showToast(
          msg: "Password Mismatch",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (_password.length <7 && _confirmpassword.length <7) {
      Fluttertoast.showToast(
          msg: "Please set password with at least 8 characters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }

    if (_password.contains(RegExp(r'[A-Z]')) == false) {
      Fluttertoast.showToast(
          msg: "Please contains at least one uppercase",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (_password.contains(RegExp(r'[0-9]')) == false) {
      Fluttertoast.showToast(
          msg: "Please contains at least one number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else if (_password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) == false) {
      Fluttertoast.showToast(
          msg: "Please contains at least one special character",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    } else {
      _registeredUser(_firstName, _lastName, _email, _password);
    }
  }

  void _togglePassword1() {
    setState(() {
      _ishidden = !_ishidden;
    });
  }

  void _togglePassword2() {
    setState(() {
      _ishidden1 = !_ishidden1;
    });
  }

  void _registeredUser(
      String firstName, String lastName, String email, String password) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/registeredUser.php"),
        body: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
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
                  child: Text("Account registered successfully"),
                ),
                actions: [
                  TextButton(
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => RegistrationScreen()));
                        _firstNameController.text = "";
                        _lastNameController.text = "";
                        _emailController.text = "";
                        _passwordController.text = "";
                        _confirmpasswordController.text = "";
                      }),
                  TextButton(
                      child: Text("Login Now",
                          style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => LoginScreen()));
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
                    Container(child: Text("Opps...")),
                  ],
                ),
                content: Container(
                  height: 25,
                  child: Text("Account registration failed"),
                ),
                actions: [
                  TextButton(
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _firstNameController.text = "";
                        _lastNameController.text = "";
                        _emailController.text = "";
                        _passwordController.text = "";
                        _confirmpasswordController.text = "";
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

  void _checkbox(bool value) {
    setState(() {
      _tnc = value;
    });
  }

  void _showTNC() {
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
              Container(
                  child: Text("End-User License Agreement (EULA)",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold))),
            ],
          ),
          content: new Container(
            height: 350,
            width: 500,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement (EULA) is a legal agreement between you and Hong Mui Trading.This EULA agreement governs your acquisition and use of our SnackEverywhere software (Software) directly from Hong Mui Trading or indirectly through a Hong Mui Trading authorized reseller or distributor (a Reseller). Our Privacy Policy was created by the Privacy Policy Generator.Please read this EULA agreement carefully before completing the installation process and using the SnackEverywhere software. It provides a license to use the SnackEverywhere software and contains warranty information and liability disclaimers.If you register for a free trial of the SnackEverywhere software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the SnackEverywhere software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Hong Mui Trading herewith regardless of whether other software is referred to or described herein. The terms also apply to any Hong Mui Trading updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.")),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
