import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/buttons/standard_button_with_icon.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/screens/user/about_us.dart';
import 'package:feed_me/screens/user/impressum.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/screens/registration_and_login/sign_in.dart';
import 'package:feed_me/screens/user/set_profile_information.dart';
import 'package:feed_me/constants/custom_widgets/appbar_widget.dart';
import 'package:feed_me/constants/custom_widgets/numbers_widget.dart';
import 'package:feed_me/constants/custom_widgets/profile_widget.dart';
import 'package:feed_me/services/google_services/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage(
      {Key key, @required this.recipeCount, @required this.cookBookCount})
      : super(key: key);
  final int recipeCount;
  final int cookBookCount;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService auth = AuthService();
  AuthenticationGoogle authGoogle = AuthenticationGoogle();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [basicColor, deepOrange])),
      child: Scaffold(
        appBar: buildAppBar(
            context,
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SetProfilePage(
                                recipeCount: widget.recipeCount,
                                cookBookCount: widget.cookBookCount,
                                fromRegistration: false,
                              )));
                },
                icon: Icon(MdiIcons.accountEdit, size: size.width * 0.11))),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileWidget(
                isProfileRoot: false,
                isLoadingState: false,
              ),
              SizedBox(height: size.height * 0.015),
              buildName(),
              SizedBox(height: size.height * 0.01),
              NumbersWidget(
                recipeCount: widget.recipeCount,
                cookBookCount: widget.cookBookCount,
              ),
              SizedBox(height: size.height * 0.01),
              StandardButtonWithIcon(
                  icon: const Icon(Icons.info, color: deepOrange),
                  color: Colors.white54,
                  text: "Über uns",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const About()));
                  }),
              StandardButtonWithIcon(
                  icon: const Icon(Icons.info, color: Colors.black54),
                  color: Colors.white54,
                  text: "Impressum",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Impressum()));
                  }),
              StandardButtonWithIcon(
                  icon: const Icon(Icons.thumb_up, color: deepOrange),
                  color: Colors.white54,
                  text: "FeedMe bewerten",
                  onPressed: () {
                    //TODO insert as soon as go in app store
                  }),
              StandardButtonWithIcon(
                  icon: const Icon(Icons.lock, color: Colors.black54),
                  color: Colors.white54,
                  text: "Passwort ändern",
                  onPressed: () {
                    String newPassword1 = '';
                    String newPassword2 = '';
                    String newPasswordFinal = '';
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Neues Passwort eingeben'),
                            content: Column(
                              children: [
                                TextField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                  controller: controller,
                                  decoration: const InputDecoration(
                                      hintText: "Gib dein neues Passwort ein:"),
                                  onChanged: (value) {
                                    newPassword1 = value;
                                  },
                                ),
                                TextField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                  controller: controller,
                                  decoration: const InputDecoration(
                                      hintText:
                                          "Gib dein neues Passwort erneut ein"),
                                  onChanged: (value) {
                                    newPassword2 = value;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Bestätigen'),
                                onPressed: () {
                                  if (newPassword1 == newPassword2) {
                                    newPasswordFinal = newPassword2;
                                    auth
                                        .getUser()
                                        .updatePassword(newPasswordFinal);
                                    Navigator.of(context).pop();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return RoundedAlert(
                                          title: "Achtung",
                                          text:
                                              "Deine Passwörter stimmen nicht überein!",
                                        );
                                      },
                                    );
                                    controller.clear();
                                  }
                                },
                              )
                            ],
                          );
                        });
                  }),
              StandardButtonWithIcon(
                  icon: const Icon(Icons.delete, color: deepOrange),
                  color: Colors.white54,
                  text: "Konto löschen",
                  onPressed: () {
                   auth.getUser().delete();
                   showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return RoundedAlert(
                         title: "Achtung",
                         text:
                         "Deine Konto wurdge gelöscht!",
                       );
                     },
                   );
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => const SignIn(
                             fromRegistration: false,
                           )));
                  }),
              StandardButtonWithIcon(
                  icon: const Icon(Icons.logout, color: Colors.black54),
                  color: Colors.white54,
                  text: "Abmelden",
                  onPressed: () {
                    auth.signOut();
                    AuthenticationGoogle.signOut(context: context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn(
                                  fromRegistration: false,
                                )));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return StandardButton(
        color: Colors.white,
        text: "Abmelden",
        onPressed: () {
          auth.signOut();
          AuthenticationGoogle.signOut(context: context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignIn(
                        fromRegistration: false,
                      )));
        });
  }

  Widget buildName() => Column(
        children: [
          Text(
            auth.getUser().displayName ?? 'Feed Me!',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: openSansFontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(height: 4),
        ],
      );
}
