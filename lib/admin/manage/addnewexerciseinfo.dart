import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:toast/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import '../adminexercise.dart';
import '../adminexerciseinfo.dart';

class AddNewExerciseInfo extends StatefulWidget {
  final ExerciseInfo exeinfo;
  final Exercise exe;

  const AddNewExerciseInfo({Key key, this.exeinfo, this.exe}) : super(key: key);
  @override
  _AddNewExerciseInfoState createState() => _AddNewExerciseInfoState();
}

class _AddNewExerciseInfoState extends State<AddNewExerciseInfo> {
  final TextEditingController _infonamecontroller = TextEditingController();
  final TextEditingController _infostepcontroller = TextEditingController();
  final TextEditingController _infolangkahcontroller = TextEditingController();
  final TextEditingController _referencecontroller = TextEditingController();

  String _infoname = "";
  String _infostep = "";
  String _infolangkah = "";
  String _exeid = "";
  String _reference = "";

  double screenHeight, screenWidth;
  File _image;
  String pathAsset = 'assets/images/cameraicon.png';
  String exerciseinfotype = "Exercise";
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Exercise Info'.tr()),
      ),
      body: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () => {_onPictureSelection()},
                        child: Container(
                          height: screenHeight / 3.2,
                          width: screenWidth / 1.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _image == null
                                  ? AssetImage(pathAsset)
                                  : FileImage(_image),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              width: 3.0,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //         <--- border radius here
                                ),
                          ),
                        )),
                    SizedBox(height: 5),
                    Text("Tap image to take exercise info picture".tr(),
                        style: TextStyle(fontSize: 10.0, color: Colors.black)),
                    SizedBox(height: 5),
                    IntrinsicHeight(
                      child: TextField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: _infonamecontroller,
                          decoration: InputDecoration(
                              labelText: 'Exercise Info Name (EN & MY)'.tr(),
                              hintText:
                                  'Add malay language into a bracket'.tr(),
                              icon: Icon(Icons.fastfood_outlined))),
                    ),
                    IntrinsicHeight(
                      child: TextField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: _infostepcontroller,
                          decoration: InputDecoration(
                            labelText: 'Exercise Steps (EN)',
                            hintText: 'English',
                            icon: Icon(Icons.insert_comment),
                          )),
                    ),
                    IntrinsicHeight(
                      child: TextField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: _infolangkahcontroller,
                          decoration: InputDecoration(
                            labelText: 'Langkah-Langkah Latihan (MY)',
                            hintText: 'Bahasa Malaysia',
                            icon: Icon(Icons.insert_comment),
                          )),
                    ),
                    IntrinsicHeight(
                      child: TextField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: _referencecontroller,
                          decoration: InputDecoration(
                            labelText: 'Reference (Optional)'.tr(),
                            hintText: 'Paste .gif link here'.tr(),
                            icon: Icon(Icons.insert_link),
                          )),
                    ),
                    SizedBox(height: 30),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 300,
                      height: 50,
                      child: Text('Add New Exercise Info'.tr()),
                      color: Colors.black,
                      textColor: Colors.white,
                      elevation: 15,
                      onPressed: newExerciseInfoDialog,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ))),
    );
  }

  _onPictureSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              //color: Colors.white,
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:".tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Camera'.tr(),
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Colors.blueGrey,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseCamera()},
                      )),
                      SizedBox(width: 10),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Gallery'.tr(),
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Colors.blueGrey,
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: () => {
                          Navigator.pop(context),
                          _chooseGallery(),
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _chooseCamera() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  void _chooseGallery() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Resize'.tr(),
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper'.tr(),
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void newExerciseInfoDialog() {
    _infoname = _infonamecontroller.text;
    _infostep = _infostepcontroller.text;
    _infolangkah = _infolangkahcontroller.text;

    if (_infoname == "" || _infostep == "" || _infolangkah == "") {
      Toast.show(
        "Please fill all required fields".tr(),
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Register New Exercise Info? ".tr(),
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
                _onAddExerciseInfo();
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

  void _onAddExerciseInfo() {
    final dateTime = DateTime.now();
    _infoname = _infonamecontroller.text;
    _infostep = _infostepcontroller.text;
    _infolangkah = _infolangkahcontroller.text;
    _reference = _referencecontroller.text;
    _exeid = widget.exe.exeid;

    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/add_newexerciseinfo.php",
        body: {
          "infoname": _infoname,
          "infostep": _infostep,
          "infolangkah": _infolangkah,
          "reference": _reference,
          "encoded_string": base64Image,
          "image": "${dateTime.microsecondsSinceEpoch}",
          "exeid": _exeid,
        }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Success".tr(),
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );

        Navigator.of(context).pop(true);
      } else {
        Toast.show(
          "Failed".tr(),
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
