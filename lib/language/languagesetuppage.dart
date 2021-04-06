import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() => runApp(LanguageSetupPage());

class LanguageSetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language Settings',
          style: TextStyle(color: Colors.black),
        ).tr(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Change Languages',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ).tr(),
            ),
            buildSwitchListTileMenuItem(
              context: context,
              title: 'English',
              subtitle: 'Welcome',
              locale: context.supportedLocales[0],
            ),
            buildDivider(),
            buildSwitchListTileMenuItem(
              context: context,
              title: 'Bahasa Malaysia',
              subtitle: 'Selamat Datang',
              locale: context.supportedLocales[1],
            )
          ],
        ),
      ),
    );
  }

  Container buildDivider() => Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Divider(color: Colors.grey));

  Container buildSwitchListTileMenuItem(
      {BuildContext context, String title, String subtitle, Locale locale}) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: ListTile(
            dense: true,
            title: Text(title),
            subtitle: Text(subtitle),
            onTap: () {
              context.locale = locale;
              Navigator.pop(context);
            }));
  }
}
