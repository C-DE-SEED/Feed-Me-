import 'package:feed_me/Screens/register.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/password_text_form_field.dart';
import 'package:feed_me/constants/standard_button.dart';
import 'package:feed_me/constants/standard_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/loading.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key, this.toggleView}) : super(key: key);

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
            backgroundColor: BasicGreen,
            body: Form(
              key: _formKey,
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
                        radius: size.height * 0.6,
                      )),
                    ),
                    SizedBox(
                      height: size.height * 0.10,
                    ),
                    MailTextFormField(
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
                      onPress: () async {
                        // dynamic result = await _auth
                        //     .loginWithEmailAndPassword(email, password);
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .loginWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = "Please supply a valid email";
                              loading = false;
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
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
                            fontFamily: openSansTextStyle,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: const Text("Hier klicken",
                              style: TextStyle(
                                fontFamily: openSansTextStyle,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}