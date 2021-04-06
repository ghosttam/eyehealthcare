import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:toast/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import '../adminsymptom.dart';

void main() => runApp(EditSymptom());

class EditSymptom extends StatefulWidget {
  final Symptom symp;

  const EditSymptom({Key key, this.symp}) : super(key: key);

  @override
  _EditSymptomState createState() => _EditSymptomState();
}

class _EditSymptomState extends State<EditSymptom> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _subtitlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _mydescriptioncontroller =
      TextEditingController();
  final TextEditingController _symptomcontroller = TextEditingController();
  final TextEditingController _simptomcontroller = TextEditingController();
  final TextEditingController _referencecontroller = TextEditingController();

  String _name = "";
  String _subtitle = "";
  String _description = "";
  String _mydescription = "";
  String _symptom = "";
  String _simptom = "";
  String _reference = "";
  double screenHeight, screenWidth;
  File _image;
  String pathAsset = 'assets/images/cameraicon.png';
  String symptomtype = "Symptom";
  bool _takepicture = true;
  bool _takepicturelocal = false;

  @override
  void initState() {
    super.initState();
    _namecontroller.text = (widget.symp.sympname);
    _subtitlecontroller.text = (widget.symp.sympsubtitle);
    _descriptioncontroller.text = (widget.symp.sympdescription);
    _mydescriptioncontroller.text = (widget.symp.sympmydescription);
    _symptomcontroller.text = (widget.symp.sympsymptom);
    _simptomcontroller.text = (widget.symp.sympsimptom);
    _referencecontroller.text = (widget.symp.sympreference);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Symptom'.tr()),
      ),
      body: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () => {_onPictureSelection()},
                        child: Visibility(
                          visible: _takepicture,
                          child: Container(
                            height: screenHeight / 3,
                            width: screenWidth / 1.5,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://steadybongbibi.com/eyehealthcare/images/symptomimages/${widget.symp.sympimage}.jpg",
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ),
                        )),
                    Visibility(
                        visible: _takepicturelocal,
                        child: Container(
                          height: screenHeight / 3,
                          width: screenWidth / 1.5,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                              image: _image == null
                                  ? AssetImage('assets/images/cameraicon.png')
                                  : FileImage(_image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )),
                    SizedBox(height: 5),
                    Text("Tap image to change symptom info picture".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0, color: Colors.black)),
                    SizedBox(height: 5),
                    IntrinsicHeight(
                      child: TextField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: _namecontroller,
                          decoration: InputDecoration(
                              labelText: 'Symptom Name (EN & MY)'.tr(),
                              hintText:
                                  'Add malay language into a bracket'.tr(),
                              icon: Icon(Icons.medical_services))),
                    ),
                    IntrinsicHeight(
                      child: TextField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: _subtitlecontroller,
                          decoration: InputDecoration(
                              labelText: 'Subtitle (EN & MY)'.tr(),
                              hintText: 'Provide both language'.tr(),
                              icon: Icon(Icons.insert_comment))),
                    ),
                    IntrinsicHeight(
                      child: TextField(
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          controller: _descriptioncontroller,
                          decoration: InputDecoration(
                            labelText: 'Description (EN)',
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
                          controller: _mydescriptioncontroller,
                          decoration: InputDecoration(
                            labelText: 'Penerangan (MY)',
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
                          controller: _symptomcontroller,
                          decoration: InputDecoration(
                            labelText: 'Symptom (EN)',
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
                          controller: _simptomcontroller,
                          decoration: InputDecoration(
                            labelText: 'Simptom (MY)',
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
                            labelText: 'Reference'.tr(),
                            hintText: 'Paste website link here'.tr(),
                            icon: Icon(Icons.insert_link),
                          )),
                    ),
                    SizedBox(height: 30),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 300,
                      height: 50,
                      child: Text('Update'.tr()),
                      color: Colors.black,
                      textColor: Colors.white,
                      elevation: 15,
                      onPressed: editSymptomDialog,
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
    setState(() {
      _takepicture = false;
      _takepicturelocal = true;
    });
  }

  void _chooseGallery() async {
    // ignore: deprecated_member_use
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {
      _takepicture = false;
      _takepicturelocal = true;
    });
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

  void editSymptomDialog() {
    _name = _namecontroller.text;
    _subtitle = _subtitlecontroller.text;
    _description = _descriptioncontroller.text;
    _mydescription = _mydescriptioncontroller.text;
    _symptom = _symptomcontroller.text;
    _simptom = _simptomcontroller.text;
    _reference = _referencecontroller.text;

    if (_name == "" ||
        _subtitle == "" ||
        _description == "" ||
        _mydescription == "" ||
        _symptom == "" ||
        _simptom == "" ||
        _reference == "") {
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
            "Update ".tr() + widget.symp.sympname,
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
                _onEditSymptom();
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

  void _onEditSymptom() {
    _name = _namecontroller.text;
    _subtitle = _subtitlecontroller.text;
    _description = _descriptioncontroller.text;
    _mydescription = _mydescriptioncontroller.text;
    _symptom = _symptomcontroller.text;
    _simptom = _simptomcontroller.text;
    _reference = _referencecontroller.text;
    String base64Image = "";
    if (_image == null) {
      http.post(
          "https://steadybongbibi.com/eyehealthcare/php/update_symptom.php",
          body: {
            "id": widget.symp.sympid,
            "name": _name,
            "subtitle": _subtitle,
            "description": _description,
            "mydescription": _mydescription,
            "symptom": _symptom,
            "simptom": _simptom,
            "reference": _reference,
            "image": widget.symp.sympimage,
            // "encoded_string": base64Image,
            //    "image": "${dateTime.microsecondsSinceEpoch}",
          }).then((res) {
        print(res.body);
        if (res.body == "success") {
          Toast.show(
            "Success",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          Navigator.pop(context);
          Navigator.of(context).pop(true);
        } else {
          Toast.show(
            "Failed",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
        }
      }).catchError((err) {
        print(err);
      });
    } else {
      base64Image = base64Encode(_image.readAsBytesSync());
      http.post(
          "https://steadybongbibi.com/eyehealthcare/php/update_symptom.php",
          body: {
            "id": widget.symp.sympid,
            "name": _name,
            "subtitle": _subtitle,
            "description": _description,
            "mydescription": _mydescription,
            "symptom": _symptom,
            "simptom": _simptom,
            "reference": _reference,
            "encoded_string": base64Image,
            "image": widget.symp.sympimage,
          }).then((res) {
        print(res.body);
        if (res.body == "success") {
          Toast.show(
            "Success".tr(),
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          setState(() {
            DefaultCacheManager manager = new DefaultCacheManager();
            manager.emptyCache();
            imageCache.clearLiveImages();
            imageCache.clear();
          });
          Navigator.pop(context);
          Navigator.of(context).pop(true);
        } else {
          Toast.show(
            "Success".tr(),
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          setState(() {
            DefaultCacheManager manager = new DefaultCacheManager();
            manager.emptyCache();
            imageCache.clearLiveImages();
            imageCache.clear();
          });
          Navigator.pop(context);
          Navigator.of(context).pop(true);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }
}
