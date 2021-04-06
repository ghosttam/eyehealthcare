import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'Details.dart';
import 'exercise.dart';
import 'exerciseinfo.dart';
import 'user.dart';
import 'package:easy_localization/easy_localization.dart';

class ExeInfoScreen extends StatefulWidget {
  final Exercise exe;
  final ExerciseInfo exeinfo;
  final User user;

  const ExeInfoScreen({Key key, this.exeinfo, this.user, this.exe})
      : super(key: key);

  @override
  _ExeInfoScreenState createState() => _ExeInfoScreenState();
}

class _ExeInfoScreenState extends State<ExeInfoScreen> {
  String _email = "";
  String _exeid = "";
  double screenHeight, screenWidth;
  String titlecenter = "Loading Exercises...".tr();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        Stack(
          children: [
            CachedNetworkImage(
                height: screenHeight / 3.2,
                width: screenWidth / 0.3,
                imageUrl:
                    "https://steadybongbibi.com/eyehealthcare/images/exerciseinfoimages/${widget.exeinfo.infoimagename}.jpg",
                fit: BoxFit.cover,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(
                      Icons.broken_image,
                      size: screenWidth / 3,
                    )),
            Padding(
              padding: EdgeInsets.all(8),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: new Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(widget.exeinfo.infoname,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Exercise Steps (EN)",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(widget.exeinfo.infostep + "\n")),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Langkah-Langkah Latihan (MY)",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(widget.exeinfo.infolangkah + "\n")),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Reference".tr(),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 10),
            GestureDetector(
                child: CachedNetworkImage(
                    height: screenHeight / 4.2,
                    width: screenWidth / 1.5,
                    imageUrl:
                        "https://steadybongbibi.com/eyehealthcare/images/exerciseinfoimages/${widget.exeinfo.infoimagename}.jpg",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(
                          Icons.broken_image,
                          size: screenWidth / 3,
                        )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailScreen(
                        user: widget.user, exeinfo: widget.exeinfo);
                  }));
                }),
            SizedBox(height: 50),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              minWidth: 300,
              height: 50,
              child: Text('Complete Exercise'.tr()),
              color: Colors.amber,
              textColor: Colors.black,
              elevation: 10,
              onPressed: newCompleteExerciseDialog,
            ),
            SizedBox(height: 20),
          ]),
        ),
      ]),
    )));
  }

  void newCompleteExerciseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Complete This Exercise?".tr(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are you sure?".tr(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes".tr(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _onAddRecord();
              },
            ),
            new FlatButton(
              child: new Text(
                "No".tr(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onAddRecord() {
    print(widget.exe.exeid);
    print(widget.user.email);

    _email = widget.user.email;
    _exeid = widget.exe.exeid;

    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/record_exercise.php",
        body: {
          "email": _email,
          "exeid": _exeid,
        }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Record Success".tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );

        Navigator.of(context).pop(true);
      } else {
        Toast.show(
          "Record Failed".tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
  }
}
