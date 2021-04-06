import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'Details.dart';
import 'adminexercise.dart';
import 'adminexerciseinfo.dart';
import 'manage/editexerciseinfo.dart';
import 'package:easy_localization/easy_localization.dart';

class ExeInfoScreen extends StatefulWidget {
  final Exercise exe;
  final ExerciseInfo exeinfo;

  const ExeInfoScreen({Key key, this.exeinfo, this.exe}) : super(key: key);

  @override
  _ExeInfoScreenState createState() => _ExeInfoScreenState();
}

class _ExeInfoScreenState extends State<ExeInfoScreen> {
  double screenHeight, screenWidth;
  String titlecenter = "Loading Exercises...";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.amber,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.mode_edit),
                  label: "Edit Information".tr(),
                  backgroundColor: Colors.green,
                  labelBackgroundColor: Colors.white,
                  onTap: _editExerciseInfo),
            ]),
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
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
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
                        return DetailScreen(exeinfo: widget.exeinfo);
                      }));
                    }),
                SizedBox(height: 50),
              ]),
            ),
          ]),
        )));
  }

  void _editExerciseInfo() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                EditExerciseInfo(exe: widget.exe, exeinfo: widget.exeinfo)));
  }
}
