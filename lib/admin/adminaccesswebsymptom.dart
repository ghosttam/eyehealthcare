import 'dart:async';

import 'package:eyehealthcare/admin/adminsymptomweb.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(AccessWebSymptom());

class AccessWebSymptom extends StatefulWidget {
  final SymptomWeb sympweb;

  const AccessWebSymptom({Key key, this.sympweb}) : super(key: key);
  @override
  _AccessWebSymptomState createState() => _AccessWebSymptomState();
}

class _AccessWebSymptomState extends State<AccessWebSymptom> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Reference'.tr()),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: WebView(
                initialUrl: widget.sympweb.sympreference1,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                }))
      ]),
    );
  }
}
