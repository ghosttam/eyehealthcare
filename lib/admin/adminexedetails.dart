import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyehealthcare/admin/adminexercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'adminexeinfoscreen.dart';
import 'adminexerciseinfo.dart';
import 'manage/addnewexerciseinfo.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(ExeDetails());

class ExeDetails extends StatefulWidget {
  final Exercise exe;

  const ExeDetails({Key key, this.exe}) : super(key: key);
  @override
  _ExeDetailsState createState() => _ExeDetailsState();
}

class _ExeDetailsState extends State<ExeDetails> {
  double screenHeight, screenWidth;
  List exeInfoList;
  String titlecenter = "Loading Exercises...".tr();

  @override
  void initState() {
    super.initState();
    _loadExeInfo();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: SpeedDial(
          backgroundColor: Colors.blue,
          animatedIcon: AnimatedIcons.menu_close,
          elevation: 8.0,
          children: [
            SpeedDialChild(
                child: Icon(Icons.visibility),
                backgroundColor: Colors.amber,
                label: "Add New ".tr() + widget.exe.exename,
                labelBackgroundColor: Colors.white,
                onTap: _addNewExerciseInfo),
          ]),
      body: SafeArea(
        child: Column(children: [
          Stack(children: [
            CachedNetworkImage(
                height: screenHeight / 3.4,
                width: screenWidth / 0.3,
                imageUrl:
                    "https://steadybongbibi.com/eyehealthcare/images/exerciseimages/${widget.exe.exeimage}.jpg",
                fit: BoxFit.fitWidth,
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
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
            )
          ]),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.exe.exename,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.white,
                        )
                      ])),
            ),
          ),
          exeInfoList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                  child: Text(
                    titlecenter,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                )))
              : Flexible(
                  child: GridView.count(
                      padding: EdgeInsets.all(10),
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 2,
                      children: List.generate(
                        exeInfoList.length,
                        (index) {
                          return Stack(
                            children: <Widget>[
                              InkWell(
                                onTap: () => _loadExeInfoScreen(index),
                                onLongPress: () => _deleteExeInfoDialog(index),
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity: 0.7,
                                  child: Container(
                                    height: 180,
                                    width: 500,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                          width: screenWidth / 3.5,
                                          height: screenHeight / 3.5,
                                          imageUrl:
                                              "https://steadybongbibi.com/eyehealthcare/images/exerciseinfoimages/${exeInfoList[index]['infoimagename']}.jpg",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                                Icons.broken_image,
                                                size: screenWidth / 3,
                                              )),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 100),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      exeInfoList[index]['infoname'] ??
                                          'Loading',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10.0,
                                              color: Colors.pinkAccent,
                                            )
                                          ])),
                                ),
                              ),
                            ],
                          );
                        },
                      )))
        ]),
      ),
    );
  }

  Future<void> _loadExeInfo() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...".tr());
    await pr.show();
    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/load_exerciseinfo.php",
        body: {
          "exeid": widget.exe.exeid,
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        exeInfoList = null;
        setState(() {
          titlecenter = "No Exercises Available".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            exeInfoList = jsondata["exeinfo"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  _loadExeInfoScreen(int index) {
    ExerciseInfo exeinfo = new ExerciseInfo(
        infoid: exeInfoList[index]['infoid'],
        infoname: exeInfoList[index]['infoname'],
        infostep: exeInfoList[index]['infostep'],
        infolangkah: exeInfoList[index]['infolangkah'],
        infoimagename: exeInfoList[index]['infoimagename'],
        reference: exeInfoList[index]['reference']);

    Navigator.push(
            context,
            MaterialPageRoute<bool>(
                builder: (BuildContext context) =>
                    ExeInfoScreen(exeinfo: exeinfo, exe: widget.exe)))
        .then((bool res) {
      if (res != null && res == true) {
        setState(() {
          _loadExeInfo();
        });
      }
    });
  }

  void _addNewExerciseInfo() {
    Navigator.push(
        context,
        MaterialPageRoute<bool>(
            builder: (BuildContext context) =>
                AddNewExerciseInfo(exe: widget.exe))).then((bool res) {
      if (res != null && res == true) {
        setState(() {
          _loadExeInfo();
        });
      }
    });
  }

  _deleteExeInfoDialog(int index) {
    print("Delete ".tr() + exeInfoList[index]['infoname']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Delete ".tr() + exeInfoList[index]['infoname'] + "?",
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
                _deleteExeInfo(index);
                _loadExeInfo();
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

  void _deleteExeInfo(int index) {
    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/delete_exerciseinfo.php",
        body: {
          "infoid": exeInfoList[index]['infoid'],
          "infoimagename": exeInfoList[index]['infoimagename'],
        }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Delete Success".tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      } else {
        Toast.show(
          "Delete Success",
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
