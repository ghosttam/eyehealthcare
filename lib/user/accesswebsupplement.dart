import 'dart:async';

import 'package:eyehealthcare/user/supplementweb.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(AccessWebSupplement());

class AccessWebSupplement extends StatefulWidget {
  final SupplementWeb cursuppweb;

  const AccessWebSupplement({Key key, this.cursuppweb}) : super(key: key);
  @override
  _AccessWebSupplementState createState() => _AccessWebSupplementState();
}

class _AccessWebSupplementState extends State<AccessWebSupplement> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplement Reference'.tr()),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: WebView(
                initialUrl: widget.cursuppweb.suppreference1,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                }))
      ]),
    );
  }
}
