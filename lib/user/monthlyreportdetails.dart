import 'package:eyehealthcare/user/user.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:easy_localization/easy_localization.dart';
import 'monthlyreportdata.dart';

void main() => runApp(MonthlyReportDetails());

class MonthlyReportDetails extends StatefulWidget {
  final User user;
  final MonthlyReportData monthlyreport;

  const MonthlyReportDetails({Key key, this.user, this.monthlyreport})
      : super(key: key);
  @override
  _MonthlyReportDetailsState createState() => _MonthlyReportDetailsState();
}

class _MonthlyReportDetailsState extends State<MonthlyReportDetails> {
  List monthlyReportList;
  List exeList;
  int index = 0;
  String titlecenter = "Loading Report...".tr();

  @override
  Widget build(BuildContext context) {
    int sum = int.parse(widget.monthlyreport.exe1m) +
        int.parse(widget.monthlyreport.exe2m) +
        int.parse(widget.monthlyreport.exe3m) +
        int.parse(widget.monthlyreport.exe4m) +
        int.parse(widget.monthlyreport.exe5m) +
        int.parse(widget.monthlyreport.exe6m);
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Monthly Exercise Progress Report".tr()),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          new CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 1,
            center: new Icon(
              Icons.person_pin,
              size: 50.0,
              color: Colors.orange,
            ),
            footer: new Text(
              widget.user.name,
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            backgroundColor: Colors.grey,
            progressColor: Colors.red,
          ),
          SizedBox(height: 20),
          new CircularPercentIndicator(
            radius: 140.0,
            lineWidth: 13.0,
            animation: true,
            percent: 1.0,
            center: new Text(
              sum.toString() + (" Total".tr()),
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            footer: new Text(
              sum.toString() + " Total Exercises Completed This Month".tr(),
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
            color: Colors.brown[300],
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("List of Completed Exercises".tr(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.amber,
                              )
                            ])),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          new CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 4.0,
                            percent: 1,
                            animation: true,
                            center: new Text(
                              widget.monthlyreport.exe1m + " Times".tr(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            progressColor: Colors.red,
                          ),
                          Text(
                            "\t\t\t\tDry Eye Exercise".tr(),
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          new CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 4.0,
                            percent: 1,
                            animation: true,
                            center: new Text(
                              widget.monthlyreport.exe2m + " Times".tr(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            progressColor: Colors.orange,
                          ),
                          Text(
                            "\t\t\t\tAccommodation Spasm".tr(),
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          new CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 4.0,
                            percent: 1,
                            animation: true,
                            center: new Text(
                              widget.monthlyreport.exe3m + " Times".tr(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            progressColor: Colors.yellow,
                          ),
                          Text(
                            "\t\t\t\tRelaxation Exercise".tr(),
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          new CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 4.0,
                            percent: 1,
                            animation: true,
                            center: new Text(
                              widget.monthlyreport.exe4m + " Times".tr(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            progressColor: Colors.green,
                          ),
                          Text(
                            "\t\t\t\tEye Muscles Exercise".tr(),
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          new CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 4.0,
                            percent: 1,
                            animation: true,
                            center: new Text(
                              widget.monthlyreport.exe5m + " Times".tr(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            progressColor: Colors.blue,
                          ),
                          Text(
                            "\t\t\t\tStimulation Exercise".tr(),
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          new CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 4.0,
                            percent: 1,
                            animation: true,
                            center: new Text(
                              widget.monthlyreport.exe6m + " Times".tr(),
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                            progressColor: Colors.purple,
                          ),
                          Text(
                            "\t\t\t\tCombination Exercise".tr(),
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ]),
      ),
    );
  }
}
