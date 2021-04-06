import 'dart:async';

import 'package:eyehealthcare/user/foodweb.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(AccessWebFood());

class AccessWebFood extends StatefulWidget {
  final FoodWeb curfoodweb;

  const AccessWebFood({Key key, this.curfoodweb}) : super(key: key);
  @override
  _AccessWebFoodState createState() => _AccessWebFoodState();
}

class _AccessWebFoodState extends State<AccessWebFood> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Reference'.tr()),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: WebView(
                initialUrl: widget.curfoodweb.foodreference1,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                }))
      ]),
    );
  }
}
