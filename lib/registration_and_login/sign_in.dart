import 'dart:ui';

import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/custom_alert.dart';
import 'package:feed_me/constants/images/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/orange_box_decoration.dart';
import 'package:feed_me/constants/text_fields/password_text_form_field.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/text_fields/standard_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/open_cookbook/screens/recipe_page.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/loading.dart';
import 'package:feed_me/registration_and_login/registration.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/choose_cookbook.dart';
import 'google_services/google_auth.dart';
import 'google_services/google_sign_in_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key key,
    this.toggleView,
  }) : super(key: key);

//TODO insert google log in option
  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: orangeBoxDecoration,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.05),
                    SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 1,
                      child: Center(
                          child: FeedMeCircleAvatar(
                        radius: size.height * 0.5,
                      )),
                    ),
                    SizedBox(
                      height: size.height * 0.095,
                    ),
                    StandardTextFormField(
                      hintText: "Bitte geben Sie Ihre E-Mail ein",
                      onChange: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PasswordTextFormField(
                      hintText: "Bitte geben Sie Ihr Passwort ein",
                      onChange: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    StandardButton(
                      color: Colors.white,
                      text: "Login",
                      onPressed: () async {
                        if (isUserInformationComplete()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .loginWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomAlert(
                                      title: "Ihre Eingaben stimmen nicht "
                                          "mit den hinterlegten Daten "
                                          "überein!",
                                      descriptions:
                                          "Bitte überprüfen Sie ihre Eingaben.",
                                      text: "OK",
                                    );
                                  });
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseCookbook()));
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const GoogleSignInButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Noch nicht registriert?",
                          style: TextStyle(
                            fontFamily: openSansFontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Registration()));
                          },
                          child: const Text("Hier klicken",
                              style: TextStyle(
                                color: Color(0xFFFDFAF6),
                                fontFamily: openSansFontFamily,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }

  bool isUserInformationComplete() {
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomAlert(
              title: "Ihre Eingaben sind noch nicht vollständig!",
              descriptions: "Bitte überprüfen Sie ihre Eingaben.",
              text: "OK",
            );
          });
      return false;
    }
  }
}
