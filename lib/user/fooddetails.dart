import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyehealthcare/user/accesswebfood.dart';
import 'package:eyehealthcare/user/food.dart';
import 'package:eyehealthcare/user/foodweb.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(FoodDetails());

class FoodDetails extends StatefulWidget {
  final Food curfood;

  const FoodDetails({Key key, this.curfood}) : super(key: key);
  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  double screenHeight, screenWidth;

  get index => null;
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
                      "https://steadybongbibi.com/eyehealthcare/images/foodimages/${widget.curfood.foodimage}.jpg",
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
                child: Text(widget.curfood.foodname,
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
                  child: Text(widget.curfood.fooddescription + "\n")),
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
                  child: Text(widget.curfood.foodmydescription + "\n")),
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
                    widget.curfood.foodreference + "\n",
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
    print(widget.curfood.foodreference);
    FoodWeb foodweb = new FoodWeb(foodreference1: widget.curfood.foodreference);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AccessWebFood(curfoodweb: foodweb)),
    );
  }
}
