import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'google_auth.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () async {
        User user =
            await AuthenticationGoogle.signInWithGoogle(context: context);
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        }
      },
      child: Container(
          height: 50,
          width: size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 5.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage("assets/google.png"),
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.18, right: size.width * 0.18),
                    child: const Text(
                      'Mit Google anmelden',
                      style: TextStyle(
                        fontFamily: openSansFontFamily,
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
