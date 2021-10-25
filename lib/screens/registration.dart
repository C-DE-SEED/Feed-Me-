import 'package:feed_me/constants/Colors.dart';
import 'package:feed_me/constants/custom_alert.dart';
import 'package:feed_me/constants/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/password_text_form_field.dart';
import 'package:feed_me/constants/standard_button.dart';
import 'package:feed_me/constants/standard_text_form_field.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/user/model/user.dart';
import 'package:feed_me/user/page/set_profile_information.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key key, this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  User user = User('', '', '', '', '');
  String email = "";
  String password = "";
  String password1 = "";
  String password2 = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    radius: size.height * 0.4,
                  )),
                ),
                SizedBox(
                  height: size.height * 0.05,
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
                  onPress: () async {
                    if (checkIfPasswordsMatching() == true) {
                      await _auth.registerWithEmailAndPassword(email, password);
                      user.id = _auth.getUserId();
                      user.email = _auth.getUserMail();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SetProfilePage(user: user)));
                    } else {
                      error = "Bitte geben Sie eine valide E-Mail ein!";
                      loading = false;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                StandardButton(
                    color: Colors.white,
                    text: "Zurück zum Login",
                    onPress: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SignIn()));
                      Navigator.pop(context);
                    })
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
