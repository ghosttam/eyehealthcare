import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'splashscreen.dart';

void main() => runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('ms', 'MY')],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    child: Main()));

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context).delegate,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale);
  }
}
