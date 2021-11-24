import 'dart:async';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/sign_in.dart';
import 'package:feed_me/screens/choose_cookbook.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      color: basicColor,
      child: Image.asset(
        "assets/feedMeOrange.gif",
        height: size.height * 1.0,
        width: size.width * 1.0,
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 3, milliseconds: 350);
    return Timer(duration, route);
  }

  route() {
    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen(
      (user) async {
        if (user != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ChooseCookbook()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const SignIn()));
        }
      },
    );
  }
}
