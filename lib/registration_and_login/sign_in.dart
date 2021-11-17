import 'dart:ui';

import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/images/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/text_fields/password_text_form_field.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/text_fields/standard_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/open_cookbook/screens/recipe_page.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/loading.dart';
import 'package:feed_me/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/choose_cookbook.dart';

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
                decoration: const BoxDecoration(
                    gradient: SweepGradient(
                      center: Alignment.bottomLeft,
                  colors: [
                    basicColor,
                    basicColor,
                    Colors.orange,
                    Colors.deepOrange,
                  ],
                )),
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
                          radius: size.width * 0.8,
                        )),
                      ),
                      SizedBox(
                        height: size.height * 0.10,
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
                        height: 90,
                      ),
                      StandardButton(
                        color: Colors.white,
                        text: "Login",
                        onPressed: () async {
                          // dynamic result = await _auth
                          //     .loginWithEmailAndPassword(email, password);
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .loginWithEmailAndPassword(email, password);
                            await GetStorage.init(_auth.getUser().uid);
                            if (result == null) {
                              setState(() {
                                error = "Please supply a valid email";
                                loading = false;
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
}
