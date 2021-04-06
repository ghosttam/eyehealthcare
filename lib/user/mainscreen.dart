import 'dart:convert';
import 'dart:io';
import 'package:eyehealthcare/user/exedetails.dart';
import 'package:eyehealthcare/user/exercise.dart';
import 'package:eyehealthcare/user/food.dart';
import 'package:eyehealthcare/user/fooddetails.dart';
import 'package:eyehealthcare/user/suppdetails.dart';
import 'package:eyehealthcare/user/supplement.dart';
import 'package:eyehealthcare/user/sympdetails.dart';
import 'package:eyehealthcare/user/symptom.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'dailyreportdata.dart';
import 'dailyreportdetails.dart';
import 'loginscreen.dart';
import 'monthlyreportdata.dart';
import 'monthlyreportdetails.dart';
import 'user.dart';
import 'weeklyreportdata.dart';
import 'weeklyreportdetails.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List sympList;
  List exeList;
  List foodList;
  List suppList;
  List dailyReportList;
  List weeklyReportList;
  List monthlyReportList;
  double screenHeight, screenWidth;
  String titlecenter = "No Data Found";
  int _currentIndex = 0;
  int index = 0;
  String _title = 'Main Page';
  File _image;
  final f = new DateFormat('dd-MM-yyyy hh:mm a');
  var parsedDate;
  @override
  void initState() {
    super.initState();
    _loadExercise();
    _loadSymptoms();
    _loadFood();
    _loadSupplement();
    _loadDailyReportData();
    _loadWeeklyReportData();
    _loadMonthlyReportData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    parsedDate = DateTime.parse(widget.user.datereg);
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: FFNavigationBar(
              theme: FFNavigationBarTheme(
                barBackgroundColor: Colors.white,
                selectedItemBorderColor: Colors.amber,
                selectedItemBackgroundColor: Colors.green,
                selectedItemIconColor: Colors.white,
                selectedItemLabelColor: Colors.black,
              ),
              selectedIndex: _currentIndex,
              //  type: BottomNavigationBarType.fixed,
              //   backgroundColor: Colors.amber[800],
              //     selectedFontSize: 16,
              items: [
                FFNavigationBarItem(
                  iconData: Icons.home,
                  // ignore: deprecated_member_use
                  label: 'Menu'.tr(),
                  //  backgroundColor: Colors.red[900]
                ),
                FFNavigationBarItem(
                  iconData: Icons.visibility,
                  // ignore: deprecated_member_usee
                  label: 'Eye Exercise'.tr(),
                  // backgroundColor: Colors.amber[900]
                ),
                FFNavigationBarItem(
                  iconData: Icons.medical_services_sharp,
                  // ignore: deprecated_member_use
                  label: 'Food'.tr(),
                  //  backgroundColor: Colors.red[900]
                ),
                FFNavigationBarItem(
                  iconData: Icons.preview_rounded,
                  // ignore: deprecated_member_use
                  label: 'Symptoms'.tr(),
                  //  backgroundColor: Colors.green[900]
                ),
                FFNavigationBarItem(
                  iconData: Icons.person,
                  // ignore: deprecated_member_use
                  label: 'Profile'.tr(),
                  //  backgroundColor: Colors.blue[900]
                ),
              ],
              onSelectTab: (index) {
                setState(() {
                  _changeTitle(index);
                });
              }),
          body: (_currentIndex == 0)
              ? SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(
                        height: 250.0,
                        width: 400.0,
                        child: Carousel(
                          images: [
                            ExactAssetImage("assets/slide/eye2.jpg"),
                            ExactAssetImage("assets/slide/eye1.webp"),
                            ExactAssetImage("assets/slide/eye3.jpg"),
                            ExactAssetImage("assets/slide/eye4.jpg"),
                            ExactAssetImage("assets/slide/food.jpg"),
                            ExactAssetImage("assets/slide/eye5.webp"),
                          ],
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotIncreasedColor: Color(0xFFFF335C),
                          dotBgColor: Colors.transparent,
                          autoplay: true,
                          indicatorBgPadding: 7.0,
                          dotSize: 4,
                          dotPosition: DotPosition.topRight,
                        )),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Hi, ".tr() + widget.user.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "You have beautiful eyes. \nMake sure they are just as healthy."
                                  .tr(),
                              style: TextStyle(fontSize: 16)),
                        )
                      ]),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                height: 300,
                                width: 220,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    onTap: () => _onItemTapped(),
                                    child: Image.asset("assets/slide/main1.jpg",
                                        fit: BoxFit.cover),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                              ),
                              Positioned(
                                child: Text("Eye Exercise",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 250,
                                right: 55,
                              ),
                              Positioned(
                                child: Text("Senaman Mata",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 30,
                                right: 40,
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 300,
                                width: 220,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    onTap: () => _onItemTapped1(),
                                    child: Image.asset("assets/slide/main2.jpg",
                                        fit: BoxFit.cover),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                              ),
                              Positioned(
                                child: Text("Food Suggestions",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 250,
                                right: 30,
                              ),
                              Positioned(
                                child: Text("Cadangan Makanan",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 30,
                                right: 20,
                              )
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 300,
                                width: 220,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    onTap: () => _onItemTapped2(),
                                    child: Image.asset("assets/slide/main3.jpg",
                                        fit: BoxFit.cover),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                              ),
                              Positioned(
                                child: Text("Check Symptoms",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 250,
                                right: 35,
                              ),
                              Positioned(
                                child: Text("Periksa Simptom",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 30,
                                right: 35,
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 300,
                                width: 220,
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    onTap: () => _onItemTapped3(),
                                    child: Image.asset("assets/slide/tap3.jpg",
                                        fit: BoxFit.cover),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                ),
                              ),
                              Positioned(
                                child: Text("Profile",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 250,
                                right: 80,
                              ),
                              Positioned(
                                child: Text("Profil",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                bottom: 30,
                                right: 85,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                )
              : (_currentIndex == 1)
                  ? Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12, left: 12.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Eye Exercises".tr(),
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
                      exeList == null
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
                                  crossAxisCount: 1,
                                  childAspectRatio:
                                      (screenWidth / screenHeight) / 0.3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 2,
                                  children: List.generate(
                                    exeList.length,
                                    (index) {
                                      return Stack(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () =>
                                                _loadExerciseDetails(index),
                                            child: AnimatedOpacity(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              opacity: 0.7,
                                              child: Container(
                                                height: 180,
                                                width: 500,
                                                decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: CachedNetworkImage(
                                                      width: screenWidth / 3.5,
                                                      height:
                                                          screenHeight / 3.5,
                                                      imageUrl:
                                                          "https://steadybongbibi.com/eyehealthcare/images/exerciseimages/${exeList[index]['exeimage']}.jpg",
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          new CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(
                                                            Icons.broken_image,
                                                            size:
                                                                screenWidth / 3,
                                                          )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                              top: screenHeight / 9,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  exeList[index]['exename'] ??
                                                      'Loading',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.cyanAccent,
                                                      shadows: [
                                                        Shadow(
                                                          blurRadius: 10.0,
                                                          color: Colors.black,
                                                        )
                                                      ])),
                                            ),
                                          ),
                                          /* Text(exeList[index]['exesubtitle'],
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontStyle: FontStyle.italic)),*/

                                          // Icon(Icons.arrow_forward_ios_rounded),
                                          // onTap: () => _loadExerciseDetails(index),
                                          //  Divider(color: Colors.black)
                                        ],
                                      );
                                    },
                                  )))
                    ])
                  : (_currentIndex == 2)
                      ? MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'Healthy Food Suggestions'.tr(),
                          theme: new ThemeData(
                            primaryTextTheme: TextTheme(
                                headline6: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                          ),
                          home: DefaultTabController(
                            length: 2,
                            child: Scaffold(
                                appBar: PreferredSize(
                                  preferredSize: Size.fromHeight(80.0),
                                  child: AppBar(
                                      centerTitle: true,
                                      title:
                                          Text('Healthy Food Suggestions'.tr()),
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      bottom: TabBar(
                                        labelColor: Colors.green,
                                        unselectedLabelColor: Colors.grey[400],
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicatorColor: Colors.green,
                                        labelPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        tabs: [
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Healthy Foods".tr()),
                                            ),
                                          ),
                                          Tab(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text("Supplements".tr()),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                body: TabBarView(children: [
                                  Column(children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, left: 12.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Healthy Foods".tr(),
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
                                    foodList == null
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
                                                childAspectRatio: (screenWidth /
                                                        screenHeight) /
                                                    0.6,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 2,
                                                children: List.generate(
                                                  foodList.length,
                                                  (index) {
                                                    return Stack(
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () =>
                                                              _loadFoodDetails(
                                                                  index),
                                                          child:
                                                              AnimatedOpacity(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500),
                                                            opacity: 0.7,
                                                            child: Container(
                                                              height: 180,
                                                              width: 500,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                child:
                                                                    CachedNetworkImage(
                                                                        width: screenWidth /
                                                                            3.5,
                                                                        height: screenHeight /
                                                                            3.5,
                                                                        imageUrl:
                                                                            "https://steadybongbibi.com/eyehealthcare/images/foodimages/${foodList[index]['foodimage']}.jpg",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                new CircularProgressIndicator(),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            new Icon(
                                                                              Icons.broken_image,
                                                                              size: screenWidth / 3,
                                                                            )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 100),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                foodList[index][
                                                                        'foodname'] ??
                                                                    'Loading',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    shadows: [
                                                                      Shadow(
                                                                        blurRadius:
                                                                            10.0,
                                                                        color: Colors
                                                                            .purpleAccent,
                                                                      )
                                                                    ])),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                )))
                                  ]),
                                  Column(children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 12, left: 12.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Supplements".tr(),
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
                                    suppList == null
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
                                                childAspectRatio: (screenWidth /
                                                        screenHeight) /
                                                    0.6,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 2,
                                                children: List.generate(
                                                  suppList.length,
                                                  (index) {
                                                    return Stack(
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () =>
                                                              _loadSupplementDetails(
                                                                  index),
                                                          child:
                                                              AnimatedOpacity(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500),
                                                            opacity: 0.7,
                                                            child: Container(
                                                              height: 180,
                                                              width: 500,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                child:
                                                                    CachedNetworkImage(
                                                                        width: screenWidth /
                                                                            3.5,
                                                                        height: screenHeight /
                                                                            3.5,
                                                                        imageUrl:
                                                                            "https://steadybongbibi.com/eyehealthcare/images/supplementimages/${suppList[index]['suppimage']}.jpg",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                new CircularProgressIndicator(),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            new Icon(
                                                                              Icons.broken_image,
                                                                              size: screenWidth / 3,
                                                                            )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 100),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                                suppList[index][
                                                                        'suppname'] ??
                                                                    'Loading',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black,
                                                                    shadows: [
                                                                      Shadow(
                                                                        blurRadius:
                                                                            10.0,
                                                                        color: Colors
                                                                            .purpleAccent,
                                                                      )
                                                                    ])),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                )))
                                  ]),
                                ])),
                          ),
                        )
                      : (_currentIndex == 3) //Symptoms Tab
                          ? Column(children: [
                              Padding(
                                padding: EdgeInsets.only(top: 12, left: 12.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Bad Eye Symptoms".tr(),
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
                              sympList == null
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
                                      child: ListView.builder(
                                      itemCount: sympList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              leading: CachedNetworkImage(
                                                  width: screenWidth / 3.5,
                                                  height: screenHeight / 3.5,
                                                  imageUrl:
                                                      "https://steadybongbibi.com/eyehealthcare/images/symptomimages/${sympList[index]['sympimage']}.jpg",
                                                  fit: BoxFit.fitWidth,
                                                  placeholder: (context, url) =>
                                                      new CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      new Icon(
                                                        Icons.broken_image,
                                                        size: screenWidth / 3,
                                                      )),
                                              title: Text(
                                                  sympList[index]['sympname'],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  sympList[index]
                                                      ['sympsubtitle'],
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontStyle:
                                                          FontStyle.italic)),
                                              trailing: Icon(Icons
                                                  .arrow_forward_ios_rounded),
                                              onTap: () =>
                                                  _loadSymptomDetails(index),
                                            ),
                                            Divider(color: Colors.black)
                                          ],
                                        );
                                      },
                                    ))
                            ])
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 12, left: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Profile".tr(),
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
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                          color: Colors.brown[300],
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 20),
                                            GestureDetector(
                                                onTap: () =>
                                                    {_onPictureSelection()},
                                                child: Container(
                                                  height: screenWidth * 0.43,
                                                  width: screenWidth * 0.43,
                                                  decoration: new BoxDecoration(
                                                    color: Colors.black,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.black),
                                                  ),
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: ClipOval(
                                                        child:
                                                            CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://steadybongbibi.com/eyehealthcare/images/userprofileimages/${widget.user.email}.jpg",
                                                      placeholder: (context,
                                                              url) =>
                                                          new CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(
                                                              MdiIcons
                                                                  .cameraIris,
                                                              size: 64.0),
                                                    )),
                                                  ),
                                                )),
                                            SizedBox(height: 5),
                                            Text(
                                                "Tap image to change profile picture"
                                                    .tr(),
                                                style: TextStyle(
                                                    fontSize: 10.0,
                                                    color: Colors.black)),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Name: ".tr(),
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                  Text(
                                                    widget.user.name,
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Email: ".tr(),
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                  Text(
                                                    widget.user.email,
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Phone: ".tr(),
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                  Text(
                                                    widget.user.phone,
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Registration Date: ".tr(),
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                  Text(
                                                    f.format(parsedDate),
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 50),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Exercise Progress Report "
                                                          .tr(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: screenHeight / 6,
                                                      width: screenWidth / 3.2,
                                                      child: Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: InkWell(
                                                          onTap: () =>
                                                              _loadDailyReport(
                                                                  index),
                                                          child: Image.asset(
                                                              "assets/images/daily.png",
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        elevation: 5,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: screenHeight / 6,
                                                      width: screenWidth / 3.2,
                                                      child: Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: InkWell(
                                                          onTap: () =>
                                                              _loadWeeklyReport(
                                                                  index),
                                                          child: Image.asset(
                                                              "assets/images/weekly.png",
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        elevation: 5,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      height: screenHeight / 6,
                                                      width: screenWidth / 3.2,
                                                      child: Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: InkWell(
                                                          onTap: () =>
                                                              _loadMonthlyReport(
                                                                  index),
                                                          child: Image.asset(
                                                              "assets/images/monthly.png",
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        elevation: 5,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                          ]),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          height: 50,
                                          child: FractionallySizedBox(
                                            widthFactor: 0.7,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              child: new Text('Log Out'.tr(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              color: Colors.amber,
                                              onPressed: () {
                                                _onLogout();
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
    );
  }

  void _changeTitle(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'Main Menu';
            setState(() {});
          }
          break;
        case 1:
          {
            _title = "Eye Exercise";

            setState(() {
              _loadExercise();
            });
          }
          break;
        case 2:
          {
            _title = 'Healthy Food Suggestions';
            setState(() {
              _loadFood();
            });
          }
          break;
        case 3:
          {
            _title = 'Symptoms Checklist';
            setState(() {
              _loadSymptoms();
            });
          }
          break;
        case 4:
          {
            _title = 'Profile';
            setState(() {
              _loadDailyReportData();
              _loadWeeklyReportData();
              _loadMonthlyReportData();
            });
          }
          break;
      }
    });
  }

  void _onLogout() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onItemTapped() {
    setState(() => _currentIndex = 1);
  }

  _onItemTapped1() {
    setState(() => _currentIndex = 2);
  }

  _onItemTapped2() {
    setState(() => _currentIndex = 3);
  }

  _onItemTapped3() {
    setState(() => _currentIndex = 4);
  }

  void _loadSymptoms() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...".tr());
    await pr.show();
    http.post("https://steadybongbibi.com/eyehealthcare/php/load_symptom.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        sympList = null;
        setState(() {
          titlecenter = "No Symptoms List Found".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            sympList = jsondata["symp"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  _loadSymptomDetails(int index) {
    print(sympList[index]['sympname']);
    Symptom symptom = new Symptom(
        sympid: sympList[index]['sympid'],
        sympname: sympList[index]['sympname'],
        sympimage: sympList[index]['sympimage'],
        sympsubtitle: sympList[index]['sympsubtitle'],
        sympdescription: sympList[index]['sympdescription'],
        sympmydescription: sympList[index]['sympmydescription'],
        sympsymptom: sympList[index]['sympsymptom'],
        sympsimptom: sympList[index]['sympsimptom'],
        sympreference: sympList[index]['sympreference'],
        sympdatareg: sympList[index]['sympdatareg']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SympDetails(symp: symptom)));
  }

  void _loadExercise() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...".tr());
    await pr.show();
    http.post("https://steadybongbibi.com/eyehealthcare/php/load_exercise.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        exeList = null;
        setState(() {
          titlecenter = "No Exercises Found".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            exeList = jsondata["exe"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  _loadExerciseDetails(int index) {
    print(exeList[index]['exename']);
    print(widget.user.email);
    Exercise exercise = new Exercise(
        exeid: exeList[index]['exeid'],
        exename: exeList[index]['exename'],
        exeimage: exeList[index]['exeimage'],
        exesubtitle: exeList[index]['exesubtitle'],
        exestep: exeList[index]['exestep'],
        exedatareg: exeList[index]['exedatareg']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ExeDetails(exe: exercise, user: widget.user)));
  }

  void _loadFood() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...".tr());
    await pr.show();
    http.post("https://steadybongbibi.com/eyehealthcare/php/load_food.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        foodList = null;
        setState(() {
          titlecenter = "No Food Found".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            foodList = jsondata["food"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  _loadFoodDetails(int index) {
    print(foodList[index]['foodname']);
    Food food = new Food(
        foodid: foodList[index]['foodid'],
        foodname: foodList[index]['foodname'],
        foodimage: foodList[index]['foodimage'],
        fooddescription: foodList[index]['fooddescription'],
        foodmydescription: foodList[index]['foodmydescription'],
        foodreference: foodList[index]['foodreference'],
        fooddatareg: foodList[index]['fooddatareg']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FoodDetails(curfood: food)));
  }

  void _loadSupplement() {
    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/load_supplement.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        suppList = null;
        setState(() {
          titlecenter = "No Supplement Found".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            suppList = jsondata["supp"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadSupplementDetails(int index) {
    print(suppList[index]['suppname']);
    Supplement supp = new Supplement(
        suppid: suppList[index]['suppid'],
        suppname: suppList[index]['suppname'],
        suppimage: suppList[index]['suppimage'],
        suppdescription: suppList[index]['suppdescription'],
        suppmydescription: suppList[index]['suppmydescription'],
        suppreference: suppList[index]['suppreference'],
        suppdatareg: suppList[index]['suppdatareg']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SuppDetails(cursupp: supp)));
  }

  void _loadDailyReportData() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...".tr());
    await pr.show();
    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/load_dailyreport.php",
        body: {
          "email": widget.user.email,
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        dailyReportList = null;
        setState(() {
          titlecenter = "No Report Available".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            dailyReportList = jsondata["dailyreport"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _loadDailyReport(int index) {
    DailyReportData dailyreport = new DailyReportData(
        exe1d: dailyReportList[index]['exe1d'],
        exe2d: dailyReportList[index]['exe2d'],
        exe3d: dailyReportList[index]['exe3d'],
        exe4d: dailyReportList[index]['exe4d'],
        exe5d: dailyReportList[index]['exe5d'],
        exe6d: dailyReportList[index]['exe6d']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DailyReportDetails(
                user: widget.user, dailyreport: dailyreport)));
  }

  void _loadWeeklyReportData() {
    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/load_weeklyreport.php",
        body: {
          "email": widget.user.email,
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        weeklyReportList = null;
        setState(() {
          titlecenter = "No Report Available".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            weeklyReportList = jsondata["weeklyreport"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadWeeklyReport(int index) {
    WeeklyReportData weeklyreport = new WeeklyReportData(
        exe1w: weeklyReportList[index]['exe1w'],
        exe2w: weeklyReportList[index]['exe2w'],
        exe3w: weeklyReportList[index]['exe3w'],
        exe4w: weeklyReportList[index]['exe4w'],
        exe5w: weeklyReportList[index]['exe5w'],
        exe6w: weeklyReportList[index]['exe6w']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => WeeklyReportDetails(
                user: widget.user, weeklyreport: weeklyreport)));
  }

  void _loadMonthlyReportData() {
    http.post(
        "https://steadybongbibi.com/eyehealthcare/php/load_monthlyreport.php",
        body: {
          "email": widget.user.email,
        }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        monthlyReportList = null;
        setState(() {
          titlecenter = "No Report Available".tr();
        });
      } else {
        setState(() {
          setState(() {
            var jsondata = json.decode(res.body);
            monthlyReportList = jsondata["monthlyreport"];
          });
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _loadMonthlyReport(int index) {
    MonthlyReportData monthlyreport = new MonthlyReportData(
        exe1m: monthlyReportList[index]['exe1m'],
        exe2m: monthlyReportList[index]['exe2m'],
        exe3m: monthlyReportList[index]['exe3m'],
        exe4m: monthlyReportList[index]['exe4m'],
        exe5m: monthlyReportList[index]['exe5m'],
        exe6m: monthlyReportList[index]['exe6m']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MonthlyReportDetails(
                user: widget.user, monthlyreport: monthlyreport)));
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
      String base64Image = "";
      base64Image = base64Encode(_image.readAsBytesSync());
      http.post(
          "https://steadybongbibi.com/eyehealthcare/php/upload_userprofileimages.php",
          body: {
            "encoded_string": base64Image,
            "email": widget.user.email,
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
            _currentIndex = 0;
          });
        } else {
          Toast.show("Tidak berjaya", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        }
      }).catchError((err) {
        print(err);
      });
    }
  }
}
