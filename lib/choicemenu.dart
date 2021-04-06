import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyehealthcare/user/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'admin/adminloginscreen.dart';

void main() => runApp(ChoiceMenu());

class ChoiceMenu extends StatefulWidget {
  @override
  _ChoiceMenuState createState() => _ChoiceMenuState();
}

class _ChoiceMenuState extends State<ChoiceMenu> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Choice Menu'.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () => _loadUserMenu(),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: 0.7,
                      child: Container(
                        height: screenHeight / 3,
                        width: screenWidth / 1,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/slide/userchoice1.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 160),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(("User".tr()),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.redAccent,
                                )
                              ])),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () => _loadAdminMenu(),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: 0.7,
                      child: Container(
                        height: screenHeight / 3,
                        width: screenWidth / 1,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/slide/userchoice2.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 160),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(("Admin".tr()),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.purpleAccent,
                                )
                              ])),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _loadUserMenu() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  _loadAdminMenu() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AdminLoginScreen()));
  }
}
