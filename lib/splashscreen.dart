import 'package:flutter/material.dart';
import 'choicemenu.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(children: <Widget>[
                Image.asset(
                  'assets/images/eyehealthlogo.png',
                ),
                SizedBox(
                  height: 80,
                ),
                new ProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Text("Start Your Day\nWith Healthy Eye",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold))
                    .tr(),
              ]),
            ),
          ),
        ));
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ChoiceMenu()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
        value: animation.value,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ));
  }
}

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    canvasColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      ),
    ),
  );
}
