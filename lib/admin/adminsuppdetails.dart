import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyehealthcare/admin/adminsupplement.dart';
import 'package:eyehealthcare/admin/adminsupplementweb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:easy_localization/easy_localization.dart';
import 'adminaccesswebsupplement.dart';
import 'manage/editsupplement.dart';

void main() => runApp(SuppDetails());

class SuppDetails extends StatefulWidget {
  final Supplement cursupp;

  const SuppDetails({Key key, this.cursupp}) : super(key: key);
  @override
  _SuppDetailsState createState() => _SuppDetailsState();
}

class _SuppDetailsState extends State<SuppDetails> {
  double screenHeight, screenWidth;

  get index => null;
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
                onTap: _editSupplement),
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
                      "https://steadybongbibi.com/eyehealthcare/images/supplementimages/${widget.cursupp.suppimage}.jpg",
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
                child: Text(widget.cursupp.suppname,
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
                  child: Text(widget.cursupp.suppdescription + "\n")),
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
                  child: Text(widget.cursupp.suppmydescription + "\n")),
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
                    widget.cursupp.suppreference + "\n",
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
      )),
    );
  }

  _loadWeb(index) {
    print(widget.cursupp.suppreference);
    SupplementWeb suppweb =
        new SupplementWeb(suppreference1: widget.cursupp.suppreference);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AccessWebSupplement(cursuppweb: suppweb)),
    );
  }

  void _editSupplement() {
    Supplement supplement = new Supplement(
        suppid: widget.cursupp.suppid,
        suppname: widget.cursupp.suppname,
        suppimage: widget.cursupp.suppimage,
        suppdescription: widget.cursupp.suppdescription,
        suppmydescription: widget.cursupp.suppmydescription,
        suppreference: widget.cursupp.suppreference,
        suppdatareg: widget.cursupp.suppdatareg);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                EditSupplement(cursupp: supplement)));
  }
}
