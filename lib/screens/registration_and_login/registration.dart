import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/text_fields/password_text_form_field.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/text_fields/standard_text_form_field.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/screens/registration_and_login/sign_in.dart';
import 'package:feed_me/screens/user/set_profile_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animate_do/animate_do.dart';

class Registration extends StatefulWidget {
  const Registration({Key key, this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";
  String password1 = "";
  String password2 = "";
  String error = "";
  bool loading = false;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/welcome.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: basicColor,
          body: Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.05),
                    SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 1,
                      child: FadeInDown(
                        from: 100,
                        duration: const Duration(milliseconds: 1000),
                        child: Center(
                          child: Image.asset(
                            "assets/FeedMeFreigestellt.png",
                            height: size.height * 1.0,
                          ),
                        ),
                      ),
                    ),
                    FadeInDown(
                      from: 100,
                      duration: const Duration(milliseconds: 1000),
                      child: StandardTextFormField(
                        hintText: "Bitte geben Sie Ihre E-Mail ein",
                        onChange: (value) {
                          setState(
                            () {
                              email = value;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInDown(
                      from: 100,
                      duration: const Duration(milliseconds: 1000),
                      child: PasswordTextFormField(
                        hintText: "Bitte geben Sie Ihr Passwort ein",
                        onChange: (value) {
                          setState(() {
                            password1 = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInDown(
                      from: 100,
                      duration: const Duration(milliseconds: 1000),
                      child: PasswordTextFormField(
                        hintText: "Bitte geben Sie Ihr Passwort erneut ein",
                        onChange: (value) {
                          setState(
                            () {
                              password2 = value;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    FadeInUp(
                      from: 50,
                      duration: const Duration(milliseconds: 1000),
                      child: StandardButton(
                        color: Colors.white,
                        text: "Registrieren",
                        onPressed: () async {
                          if (checkIfPasswordsMatching() == true) {
                            var newUser = await _auth
                                .createUserWithEmailAndPassword(email, password);
                            showDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                        title: const Text(
                                          'Registrierung erfolgreich',
                                          style: TextStyle(
                                              fontFamily: openSansFontFamily,
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        content: const Text(
                                            'Du erhälst eine Bestätigung per Mail von uns 💌',
                                            style: TextStyle(
                                                fontFamily: openSansFontFamily,
                                                color: Colors.black,
                                                fontSize: 18)),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(
                                                    fontFamily:
                                                        openSansFontFamily,
                                                    color: basicColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                             const SignIn(fromRegistration: true,)));
                                              })
                                        ]));
                            if (newUser != null) {
                              await newUser.user.sendEmailVerification();
                            }
                          } else {
                            error = "Bitte gebe eine valide E-Mail ein!";
                            loading = false;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(0.0, size.height * 0.084, 0.0, 0.0),
                      child: Row(
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
                                      builder: (context) => const SignIn(
                                            fromRegistration: false,
                                          )));
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
            ],
          )),
    );
  }

  bool checkIfPasswordsMatching() {
    if (password1 == password2) {
      if (password1.characters.length < 6 || password2.characters.length < 6) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return RoundedAlert(
                title:
                    "Ihre eingegebnen Passwörter müssen mindestens 6 Zeichen lang sein!",
                text: "Bitte überprüfen Sie ihre Eingaben.",
              );
            });
      } else {
        password = password1;
        return true;
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return RoundedAlert(
              title: "Ihre eingegebenen Passwörter stimmen nicht überein!",
              text: "Bitte überprüfen Sie ihre Eingaben.",
            );
          });
      return false;
    }
  }
}
