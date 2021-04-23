import 'package:flutter/material.dart';
import 'package:snackeverywhere/homePage.dart';
import 'package:snackeverywhere/registrationScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _recoveryEmailController = TextEditingController();
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    loadUserPreferences();
  }

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
                  Container(child: Image.asset("assets/images/Logo.png")),
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
                              Text("SIGN IN",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (content) =>
                                              RegistrationScreen()));
                                },
                                child: Text(
                                  "SIGN UP",
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 350,
                          child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email",
                                icon: Icon(Icons.email_outlined),
                              )),
                        ),
                        Container(
                          width: 350,
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: "Password",
                                icon: Icon(Icons.lock_outlined)),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 350,
                          child: Row(
                            children: [
                              SizedBox(width: 5),
                              Container(
                                height: 20,
                                width: 20,
                                child: GFCheckbox(
                                    type: GFCheckboxType.circle,
                                    inactiveBgColor: GFColors.TRANSPARENT,
                                    activeBgColor: GFColors.SUCCESS,
                                    value: _rememberMe,
                                    onChanged: (bool value) {
                                      _checkbox(value);
                                    }),
                              ),
                              SizedBox(width: 10),
                              Text("Remember me")
                            ],
                          ),
                        ),
                        SizedBox(height: 48),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              width: 200,
                              height: 50,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Sign In",
                                        style: TextStyle(fontSize: 20)),
                                  ]),
                            ),
                            color: Colors.orange[800],
                            onPressed: _userLogin),
                        SizedBox(height: 15),
                        GestureDetector(
                            onTap: _forgetPassword,
                            child: Text("Forgot password?")),
                        SizedBox(height: 48),
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

  void _userLogin() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();

    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/loginUser.php"),
        body: {"email": _email, "password": _password}).then((response) {
      print(response.body);
      if (response.body == "Success") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (content) => HomePage()));
      } else
        Fluttertoast.showToast(
            msg: "Login failed. Please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      return;
    });
  }

  void _checkbox(bool value) {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();

    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Empty email or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);

      return;
    }

    setState(() {
      _rememberMe = value;
      saveuserPreference(value, _email, _password);
    });
  }

  void _forgetPassword() {
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
                Container(child: Text("Forget Password")),
              ],
            ),
            content: new Container(
                height: 78,
                child: Column(children: [
                  Text("Enter your recovery email:"),
                  TextField(
                      controller: _recoveryEmailController,
                      decoration: InputDecoration(
                          labelText: "Email", icon: Icon(Icons.email_outlined)))
                ])),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                  onPressed: () {
                    print(_recoveryEmailController.text);
                    _resetPasswords(_recoveryEmailController.text.toString());
                  },
                  child: Text("Send", style: TextStyle(color: Colors.blue)))
            ],
          );
        });
  }

  Future<void> saveuserPreference(bool value, email, password) async {
    preferences = await SharedPreferences.getInstance();
    if (value) {
      await preferences.setString("email", email);
      await preferences.setString("password", password);
      await preferences.setBool("remember", value);
      Fluttertoast.showToast(
          msg: "Remembered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);

      return;
    } else
      await preferences.setString("email", "");
    await preferences.setString("password", "");
    await preferences.setBool("remember", false);
    Fluttertoast.showToast(
        msg: "Unremembered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);

    return;
  }

  Future<void> loadUserPreferences() async {
    preferences = await SharedPreferences.getInstance();
    String _email = preferences.getString("email") ?? "";
    String _password = preferences.getString("password") ?? "";
    _rememberMe = preferences.getBool("remember") ?? false;

    setState(() {
      _emailController.text = _email;
      _passwordController.text = _password;
    });
  }

  void _resetPasswords(String _recoveryEmail) {
    TextEditingController _otpController = TextEditingController();
    print(_recoveryEmail);
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/forgetPassword.php"),
        body: {
          "email": _recoveryEmail,
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
                    Container(
                        child: Text("Please check your email for OTP",
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
                content: new Container(
                    height: 100,
                    child: Row(children: [
                      Container(
                        width: 250,
                        child: TextField(
                            controller: _otpController,
                            decoration: InputDecoration(
                                labelText: "OTP",
                                icon:
                                    Icon(Icons.admin_panel_settings_outlined))),
                      )
                    ])),
                actions: [
                  TextButton(
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child:
                          Text("Submit", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        _verifyReset(
                            _recoveryEmail, _otpController.text.toString());
                      })
                ],
              );
            });
      } else {
        Fluttertoast.showToast(
            msg: "Invalid Email",
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

  void _verifyReset(String recoveryEmail, String otp) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/270607/snackeverywhere/php/resetPassword.php"),
        body: {
          "email": recoveryEmail,
          "otp": otp,
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
                    Container(
                        child: Text("Temporary Password generated",
                            style: TextStyle(fontSize: 15))),
                  ],
                ),
                content: new Container(
                    height: 100,
                    child: Row(children: [
                      Container(
                        width: 250,
                        child: Text(
                            "Please check email for temporary password, you can use this to login. You may change it manually after login"),
                      )
                    ])),
                actions: [
                  TextButton(
                      child:
                          Text("Cancel", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  TextButton(
                      child: Text("Ok", style: TextStyle(color: Colors.blue)),
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
        Fluttertoast.showToast(
            msg: "Invalid OTP",
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
