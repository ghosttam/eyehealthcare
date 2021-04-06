import 'package:eyehealthcare/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'registerscreen.dart';
import '../language/languagesetuppage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import 'mainscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emcontroller = TextEditingController();
  final TextEditingController _forgotcontroller = TextEditingController();
  String _forgotemail = "";
  String _email1 = "";
  final TextEditingController _pscontroller = TextEditingController();
  String _password1 = "";
  bool _passwordVisibleLogin = true;
  bool _rememberMe1 = false;
  SharedPreferences prefs1;

  @override
  void initState() {
    loadpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.language,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LanguageSetupPage()));
            },
          )
        ],
        centerTitle: true,
        title: Text('Sign In').tr(),
      ),
      body: new Container(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome Back",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: (25),
                          fontWeight: FontWeight.bold))
                  .tr(),
              Text(
                "Sign in with your email and password",
                textAlign: TextAlign.center,
              ).tr(),
              Image.asset(
                'assets/images/eyehealthlogo.png',
                scale: 2,
              ),
              SizedBox(height: 10),
              TextFormField(
                  controller: _emcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: ('Email').tr(),
                    hintText: ("Enter your email").tr(),
                    hintStyle: TextStyle(fontSize: (12)),
                    labelStyle: TextStyle(color: Color(0XFF8B8B8B)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 20,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0XFF8B8B8B), width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Color(0XFF8B8B8B)),
                      gapPadding: 10,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(
                        right: 20.0,
                      ),
                      child:
                          SvgPicture.asset("assets/icons/Mail.svg", height: 20),
                    ),
                  )),
              SizedBox(height: 10),
              TextFormField(
                controller: _pscontroller,
                decoration: InputDecoration(
                  labelText: ('Password').tr(),
                  hintText: ("Enter your password").tr(),
                  labelStyle: TextStyle(
                    color: Color(0XFF8B8B8B),
                  ),
                  hintStyle: TextStyle(fontSize: (12)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 42,
                    vertical: 20,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        BorderSide(color: Color(0XFF8B8B8B), width: 5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Color(0XFF8B8B8B)),
                    gapPadding: 10,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                    ),
                    child: IconButton(
                      icon: Icon(
                        _passwordVisibleLogin
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisibleLogin = !_passwordVisibleLogin;
                        });
                      },
                    ),
                  ),
                ),
                obscureText: _passwordVisibleLogin,
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minWidth: 295,
                height: 50,
                child: Text('Login', style: TextStyle(fontSize: (16))).tr(),
                color: Colors.amber,
                textColor: Colors.black,
                elevation: 10,
                onPressed: _onLogin,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _rememberMe1,
                    onChanged: (bool value1) {
                      _onChange(value1);
                    },
                  ),
                  Text('Remember Me', style: TextStyle(fontSize: 16)).tr()
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account?", style: TextStyle(fontSize: 12))
                    .tr(),
                GestureDetector(
                    onTap: _onRegister,
                    child: Text(' Register Now',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[800]))
                        .tr()),
              ]),
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Forgot your password?", style: TextStyle(fontSize: 12))
                    .tr(),
                GestureDetector(
                    onTap: _onForgotPassword,
                    child: Text(' Reset Password'.tr(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[800]))),
              ]),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _onLogin() async {
    _email1 = _emcontroller.text;
    _password1 = _pscontroller.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...".tr());
    await pr.show();
    http.post("https://steadybongbibi.com/eyehealthcare/php/login_user.php",
        body: {
          "email": _email1,
          "password": _password1,
        }).then((res) {
      print(res.body);
      List userdata = res.body.split(",");

      if (userdata[0] == "success") {
        Toast.show(
          "Login Success".tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        User user = new User(
            email: _email1,
            name: userdata[1],
            password: _password1,
            phone: userdata[2],
            datereg: userdata[3]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(user: user)));
      } else {
        Toast.show(
          "Invalid Email or Password".tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _onRegister() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  void _onChange(bool value1) {
    setState(() {
      _rememberMe1 = value1;
      savepref(value1);
    });
  }

  void loadpref() async {
    prefs1 = await SharedPreferences.getInstance();
    _email1 = (prefs1.getString('email')) ?? '';
    _password1 = (prefs1.getString('password')) ?? '';
    _rememberMe1 = (prefs1.getBool('rememberme')) ?? false;
    if (_email1.isNotEmpty) {
      setState(() {
        _emcontroller.text = _email1;
        _pscontroller.text = _password1;
        _rememberMe1 = _rememberMe1;
      });
    }
  }

  void savepref(bool value1) async {
    prefs1 = await SharedPreferences.getInstance();
    _email1 = _emcontroller.text;
    _password1 = _pscontroller.text;

    if (value1) {
      if (_email1.length < 5 && _password1.length < 3) {
        print("EMAIL/PASSWORD EMPTY");
        _rememberMe1 = false;
        Toast.show(
          "Email or password is empty!".tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        return;
      } else {
        await prefs1.setString('email', _email1);
        await prefs1.setString('password', _password1);
        await prefs1.setBool('rememberme', value1);
        Toast.show(
          ("Preferences saved").tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        print("SUCCESS");
      }
    } else {
      await prefs1.setString('email', '');
      await prefs1.setString('password', '');
      await prefs1.setBool('rememberme', false);
      setState(() {
        _emcontroller.text = "";
        _pscontroller.text = "";
        _rememberMe1 = false;
      });
      Toast.show(
        "Preferences removed".tr(),
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }

  void _onForgotPassword() {
    showModalBottomSheet(
        useRootNavigator: false,
        barrierColor: Colors.black.withOpacity(0.5),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9),
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
                      child: Text('Reset Account Password'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (20),
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: TextFormField(
                          controller: _forgotcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: ('Registered Email').tr(),
                            hintText: ("Enter Registered Email").tr(),
                            hintStyle: TextStyle(fontSize: (12)),
                            labelStyle: TextStyle(color: Color(0XFF8B8B8B)),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 42,
                              vertical: 20,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(
                                  color: Color(0XFF8B8B8B), width: 5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Color(0XFF8B8B8B)),
                              gapPadding: 10,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(
                                right: 20.0,
                              ),
                              child: SvgPicture.asset("assets/icons/Mail.svg",
                                  height: 20),
                            ),
                          )),
                    ),
                    Text("Password reset link will be sent to the Email".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: (10))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: 295,
                        height: 50,
                        child: Text('Reset', style: TextStyle(fontSize: (16)))
                            .tr(),
                        color: Colors.amber,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: _onReset,
                      ),
                    ),
                    SizedBox(height: 30)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _onReset() async {
    Navigator.of(context).pop();
    _forgotemail = _forgotcontroller.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: ("Reseting...").tr());
    await pr.show();
    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/PHPMailer1/sendresetemail.php",
        body: {
          "email": _forgotemail,
        }).then((res) {
      print(res.body);

      if (res.body == "success") {
        Toast.show(
          ("An Email had been sent"),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
      if (res.body == "failed") {
        Toast.show(
          ("The Email is not registered"),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }
}
