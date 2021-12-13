import 'dart:ui';

import 'package:feed_me/constants/alerts/custom_alert.dart';
import 'package:feed_me/constants/alerts/custom_alert_password_reset.dart';
import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/images/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/orange_box_decoration.dart';
import 'package:feed_me/constants/text_fields/password_text_form_field.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/text_fields/standard_text_form_field.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/screens/user/set_profile_information.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/services/google_services/google_sign_in_button.dart';
import 'package:feed_me/services/loading.dart';
import 'package:feed_me/screens/registration_and_login/registration.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key key,
    this.toggleView,this.fromRegistration
  }) : super(key: key);

//TODO insert google log in option
  final Function toggleView;
  final bool fromRegistration;


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
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
            backgroundColor: basicColor,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 1,
                      child: Center(
                          child: FeedMeCircleAvatar(
                        radius: size.height * 0.5,
                      )),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    StandardTextFormField(
                      hintText: "Bitte geben Sie Ihre E-Mail ein",
                      onChange: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    PasswordTextFormField(
                      hintText: "Bitte geben Sie Ihr Passwort ein",
                      onChange: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.02,
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
                                  return RoundedAlert(
                                    title: "Achtung",
                                    text:
                                        "Deine Eingaben stimmen nicht mit den hinterlegten Daten überein!",
                                  );
                                },
                              );
                            });
                          } else if (widget.fromRegistration)
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SetProfilePage(
                                      cookBookCount: 0,
                                      recipeCount: 0,
                                    )));
                          }
                          else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                          }
                        }
                      },
                    ),
                    const GoogleSignInButton(),
                    StandardButton(
                        color: Colors.white,
                        text: "Passwort zurücksetzen",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RoundedAlert(
                                title: "Passwort zurücksetzen?",
                                text:
                                    "Willst du dein Passwort wirklich zurücksetzten? Es wird dir eine E-Mail zum zurücksetzen gesendet werden. Bitte gebe deineE-Mail Adresse ein.",
                              );
                            },
                          );
                        }),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0.0, size.height * 0.02, 0.0, 0.0),
                      child: Row(
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
                      ),
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
          return RoundedAlert(
            title: "Deine Eingaben sind noch nicht vollständig!",
            text: "Bitte überprüfe deine Eingaben.",
          );
        },
      );

      return false;
    }
  }
}
