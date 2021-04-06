import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyehealthcare/user/symptom.dart';
import 'package:eyehealthcare/user/symptomweb.dart';
import 'package:eyehealthcare/user/accesswebsymptom.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(SympDetails());

class SympDetails extends StatefulWidget {
  final Symptom symp;

  const SympDetails({Key key, this.symp}) : super(key: key);
  @override
  _SympDetailsState createState() => _SympDetailsState();
}

class _SympDetailsState extends State<SympDetails> {
  double screenHeight, screenWidth;

  int get index => null;
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
                        "https://steadybongbibi.com/eyehealthcare/images/symptomimages/${widget.symp.sympimage}.jpg",
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
                            color: Colors.white),
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
                  child: Text(widget.symp.sympname,
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Description (EN)",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.symp.sympdescription + "\n")),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Symptoms (EN)",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.symp.sympsymptom + "\n")),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Penerangan (MY)",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.symp.sympmydescription + "\n")),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Simptom (MY)",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(widget.symp.sympsimptom + "\n")),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Reference".tr(),
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ListTile(
                    subtitle: Text(
                      widget.symp.sympreference + "\n",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () => _loadWeb(index)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  _loadWeb(int index) {
    print(widget.symp.sympreference);
    SymptomWeb symptomweb =
        new SymptomWeb(sympreference1: widget.symp.sympreference);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AccessWebSymptom(sympweb: symptomweb)),
    );
  }
}
