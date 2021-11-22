import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/custom_alert.dart';
import 'package:feed_me/constants/images/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/text_fields/password_text_form_field.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/text_fields/standard_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/sign_in.dart';
import 'package:feed_me/user/page/set_profile_information.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Registration extends StatefulWidget {
  const Registration({Key key, this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String password1 = "";
  String password2 = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
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
                    }),
                const SizedBox(
                  height: 20,
                ),
                PasswordTextFormField(
                  hintText: "Bitte geben Sie Ihr Passwort ein",
                  onChange: (value) {
                    setState(() {
                      password1 = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                PasswordTextFormField(
                  hintText: "Bitte geben Sie Ihr Passwort erneut ein",
                  onChange: (value) {
                    setState(
                      () {
                        password2 = value;
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                StandardButton(
                  color: Colors.white,
                  text: "Registrieren",
                  onPressed: () async {
                    if (checkIfPasswordsMatching() == true) {
                      await _auth.registerWithEmailAndPassword(email, password);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SetProfilePage()));
                    } else {
                      error = "Bitte geben Sie eine valide E-Mail ein!";
                      loading = false;
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
                      "Zurück zum Login?",
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
                                builder: (context) => const SignIn()));
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
        ));
  }

  bool checkIfPasswordsMatching() {
    if (password1 == password2) {
      password = password1;
      return true;
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CustomAlert(
              title: "Ihre eingegebenen Passwörter stimmen nicht überein!",
              descriptions: "Bitte überprüfen Sie ihre Eingaben.",
              text: "OK",
            );
          });
      return false;
    }
  }
}
