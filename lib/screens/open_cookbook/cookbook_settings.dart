import 'package:flutter/material.dart';

class CookBookSettings extends StatefulWidget {
  const CookBookSettings({Key key}) : super(key: key);

  @override
  _CookBookSettingsState createState() => _CookBookSettingsState();
}

class _CookBookSettingsState extends State<CookBookSettings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Settings"),
    );
  }
}
