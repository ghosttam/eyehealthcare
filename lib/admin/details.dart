import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

import 'adminexerciseinfo.dart';

class DetailScreen extends StatefulWidget {
  final ExerciseInfo exeinfo;

  const DetailScreen({Key key, this.exeinfo}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenHeight, screenWidth;
  int _progress = 0;
  int _quarterTurns = 0;
  @override
  void initState() {
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        Expanded(
            child: Column(children: [
          Stack(
            children: [
              Container(
                child: IconButton(
                    iconSize: 42,
                    color: Colors.lightBlue,
                    icon: Icon(Icons.fullscreen),
                    onPressed: () {
                      setState(
                        () {
                          _quarterTurns = 1;
                        },
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100.0),
                child: Container(
                  child: IconButton(
                      iconSize: 42,
                      color: Colors.lightBlue,
                      icon: Icon(Icons.fullscreen_exit),
                      onPressed: () {
                        setState(
                          () {
                            _quarterTurns = 0;
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
          GestureDetector(
              child: Center(
                  child: Hero(
                      tag: 'imageHero',
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 100, left: 5, right: 5),
                            child: RotatedBox(
                              quarterTurns: _quarterTurns,
                              child: CachedNetworkImage(
                                  width: screenWidth / 1,
                                  height: screenHeight / 2,
                                  imageUrl: (widget.exeinfo.reference),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      new CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      CachedNetworkImage(
                                        imageUrl:
                                            "https://steadybongbibi.com/eyehealthcare/images/exerciseinfoimages/${widget.exeinfo.infoimagename}.jpg",
                                        fit: BoxFit.cover,
                                      )),
                            ),
                          ),
                        ],
                      ))),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ])),
        /*  Column(
          children: [
            Container(
                child: LinearProgressIndicator(
              backgroundColor: Colors.lightBlue,
              valueColor: new AlwaysStoppedAnimation(Colors.red),
              value: _progress.toDouble() / 100,
            )),
            Container(
                child: IconButton(
                    iconSize: 42,
                    color: Colors.lightBlue,
                    icon: Icon(Icons.file_download),
                    onPressed: () async {
                      await ImageDownloader.downloadImage(
                          "https://steadybongbibi.com/eyehealthcare/images/exerciseinfoimages/${widget.exeinfo.infoimagename}.jpg",
                          destination: AndroidDestinationType.custom(
                              directory: 'Download'));
                    })),
          ],
        )*/
      ])),
    );
  }
}
