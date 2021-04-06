import 'package:eyehealthcare/user/user.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'weeklyreportdata.dart';

void main() => runApp(WeeklyReportDetails());

class WeeklyReportDetails extends StatefulWidget {
  final User user;
  final WeeklyReportData weeklyreport;

  const WeeklyReportDetails({Key key, this.user, this.weeklyreport})
      : super(key: key);
  @override
  _WeeklyReportDetailsState createState() => _WeeklyReportDetailsState();
}

class _WeeklyReportDetailsState extends State<WeeklyReportDetails> {
  List weeklyReportList;
  List exeList;
  int index = 0;
  String titlecenter = "Loading Report...".tr();

  @override
  Widget build(BuildContext context) {
    int sum = int.parse(widget.weeklyreport.exe1w) +
        int.parse(widget.weeklyreport.exe2w) +
        int.parse(widget.weeklyreport.exe3w) +
        int.parse(widget.weeklyreport.exe4w) +
        int.parse(widget.weeklyreport.exe5w) +
        int.parse(widget.weeklyreport.exe6w);
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Weekly Exercise Progress Report".tr()),
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
              sum.toString() + " Total Exercises Completed This Week".tr(),
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
                              widget.weeklyreport.exe1w + " Times".tr(),
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
                              widget.weeklyreport.exe2w + " Times".tr(),
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
                              widget.weeklyreport.exe3w + " Times".tr(),
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
                              widget.weeklyreport.exe4w + " Times".tr(),
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
                              widget.weeklyreport.exe5w + " Times".tr(),
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
                              widget.weeklyreport.exe6w + " Times".tr(),
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
