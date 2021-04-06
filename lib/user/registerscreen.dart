import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:eyehealthcare/user/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emcontroller = TextEditingController();
  final TextEditingController _phcontroller = TextEditingController();
  final TextEditingController _pscontroller = TextEditingController();
  final TextEditingController _psconfirmcontroller = TextEditingController();

  String _email = "";
  String _pass = "";
  String _name = "";
  String _phone = "";
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;
  bool _rememberMe = false;
  bool _termsCondition = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registration').tr(),
      ),
      body: Container(
          child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Register Account",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: (25),
                                  fontWeight: FontWeight.bold))
                          .tr(),
                      Text(
                        "Complete your details",
                      ).tr(),
                      Image.asset(
                        'assets/images/eyehealthlogo.png',
                        scale: 2,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _namecontroller,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: ('Name').tr(),
                            hintText: ("Enter your Name").tr(),
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
                              padding: const EdgeInsets.only(
                                left: 30.0,
                                right: 20.0,
                              ),
                              child: SvgPicture.asset("assets/icons/User.svg",
                                  height: 25),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ('Please enter your name').tr();
                            }

                            return null;
                          },
                          onSaved: (String name) {
                            _name = name;
                          }),
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
                              borderSide: BorderSide(
                                  color: Color(0XFF8B8B8B), width: 5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Color(0XFF8B8B8B)),
                              gapPadding: 10,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(20),
                              child: SvgPicture.asset("assets/icons/Mail.svg",
                                  height: 20),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ('Please enter your email').tr();
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return ("Please enter valid email").tr();
                            }
                            return null;
                          },
                          onSaved: (String email) {
                            _email = email;
                          }),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _phcontroller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: ('Phone').tr(),
                            hintText: ("Enter your phone number").tr(),
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
                              padding: const EdgeInsets.only(
                                left: 30.0,
                                right: 25.0,
                              ),
                              child: SvgPicture.asset("assets/icons/Phone.svg",
                                  height: 30),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return ('Please enter your phone number').tr();
                            }
                            if (value.length < 10) {
                              return ('Please enter valid phone number').tr();
                            }
                            return null;
                          },
                          onSaved: (String phone) {
                            _phone = phone;
                          }),
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
                            borderSide: BorderSide(
                                color: Color(0XFF8B8B8B), width: 5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0XFF8B8B8B)),
                            gapPadding: 10,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                              left: 30.0,
                              right: 10.0,
                            ),
                            child: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        obscureText: _passwordVisible,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ('Please enter your password').tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _psconfirmcontroller,
                        decoration: InputDecoration(
                          labelText: ('Confirm Password').tr(),
                          hintText: ("Re-enter your password").tr(),
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
                            borderSide: BorderSide(
                                color: Color(0XFF8B8B8B), width: 5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0XFF8B8B8B)),
                            gapPadding: 10,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                              left: 30.0,
                              right: 10.0,
                            ),
                            child: IconButton(
                              icon: Icon(
                                _passwordVisible2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible2 = !_passwordVisible2;
                                });
                              },
                            ),
                          ),
                        ),
                        obscureText: _passwordVisible2,
                        validator: (value) {
                          if (value.isEmpty) {
                            return ('Please re-enter your password').tr();
                          }
                          if (_pscontroller.text != _psconfirmcontroller.text) {
                            return ('Your password does not match').tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          Text('Remember Me', style: TextStyle(fontSize: 14))
                              .tr()
                        ],
                      ),
                      FormField<bool>(
                        builder: (state) {
                          return Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: _termsCondition,
                                    onChanged: (bool value) {
                                      _onTick(value);
                                      state.didChange(value);
                                    },
                                  ),
                                  Text("I agree to the ",
                                          style: TextStyle(fontSize: 14))
                                      .tr(),
                                  GestureDetector(
                                      onTap: _showEULA,
                                      child: Text('Terms and Conditions',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.amber[800]))
                                          .tr()),
                                ],
                              ),
                              Text(state.errorText ?? '',
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor))
                            ],
                          );
                        },
                        validator: (value) {
                          if (!_termsCondition) {
                            return ('You need to agree the Terms and Conditions')
                                .tr();
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        minWidth: 300,
                        height: 50,
                        child:
                            Text('Register', style: TextStyle(fontSize: (16)))
                                .tr(),
                        color: Colors.amber,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: _openDialog,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                          onTap: _onLogin,
                          child: Text('Already register',
                                  style: TextStyle(fontSize: 14))
                              .tr()),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ))),
    );
  }

  void _onRegister() async {
    if (_formKey.currentState.validate()) {
      _name = _namecontroller.text;
      _email = _emcontroller.text;
      _pass = _pscontroller.text;
      _phone = _phcontroller.text;

      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: ("Registration...").tr());
      await pr.show();
      http.post(
          "https://steadybongbibi.com/eyehealthcare/php/PHPMailer1/index.php",
          body: {
            "name": _name,
            "email": _email,
            "phone": _phone,
            "password": _pass,
          }).then((res) {
        print(res.body);

        if (res.body == "success") {
          Toast.show(
            ("Registration Success, Please check your email to verify your account")
                .tr(),
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          if (_rememberMe) {
            savepref();
          }

          _onLogin();
        }
        if (res.body == "failed") {
          Toast.show(
            ("The Email had been used").tr(),
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        }
      }).catchError((err) {
        print(err);
      });
      await pr.hide();
    } else {
      Toast.show(
        ("Registration Failed").tr(),
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
    }
  }

  void _onLogin() {
    Navigator.pop(context);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  void savepref() async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _pass = _pscontroller.text;
    await prefs1.setString('email', _email);
    await prefs1.setString('password', _pass);
    await prefs1.setBool('rememberme', true);
  }

  void _openDialog() {
    showDialog(
      context: context,
      builder: (dialogcontext) {
        return AlertDialog(
          title: new Text(
            ("Confirmation Message").tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            ("Are you sure your information is correct?").tr(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                ("Yes").tr(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogcontext);
                _onRegister();
              },
            ),
            new FlatButton(
              child: new Text(
                ("No").tr(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogcontext);
              },
            ),
          ],
        );
      },
    );
  }

  void _onTick(bool value) {
    setState(() {
      _termsCondition = value;
    });
  }

  void _showEULA() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            ("End-user License Agreement").tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: SingleChildScrollView(
            child: new Text(
              ("End-User License Agreement (Agreement) Last updated: December 09, 2020 Please read this End-User License Agreement carefully before clicking the I Agree button, downloading or using Eye Health Care. Interpretation and Definitions Interpretation The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural. Definitions For the purposes of this End-User License Agreement: Agreement means this End-User License Agreement that forms the entire agreement between You and the Company regarding the use of the Application. This Agreement has been created with the help of the EULA Generator. Application means the software program provided by the Company downloaded by You to a Device, named Eye Health Care Company (referred to as either the Company, We, Us or Our in this Agreement) refers to Eye Health Care. Content refers to content such as text, images, or other information that can be posted, uploaded, linked to or otherwise made available by You, regardless of the form of that content. Country refers to: Malaysia Device means any device that can access the Application such as a computer, a cellphone or a digital tablet.")
                  .tr(),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ).tr(),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                ("Close").tr(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ).tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
