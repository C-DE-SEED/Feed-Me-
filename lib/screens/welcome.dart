import 'dart:async';

import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/screens/sing_in.dart';
import 'package:feed_me/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

import 'home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      color: BasicGreen,
      child: Image.asset(
        "assets/feedMe.gif",
        height: size.height * 1.0,
        width: size.width * 1.0,
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignIn()));
  }
}
