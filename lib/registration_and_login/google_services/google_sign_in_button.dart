import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/screens/choose_cookbook.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          User user = await AuthenticationGoogle.signInWithGoogle(context: context);
          if (user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ChooseCookbook(),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
      ),
    );
  }
}
