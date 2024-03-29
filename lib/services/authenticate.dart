import 'package:feed_me/screens/registration_and_login/sign_in.dart';
import 'package:feed_me/screens/registration_and_login/registration.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  const Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView, fromRegistration: false,);
    } else {
      return Registration(toggleView: toggleView);
    }
  }
}
