import 'package:animate_do/animate_do.dart';
import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/services/auth_service.dart';

import 'package:feed_me/screens/home.dart';

import 'package:feed_me/model/user_local.dart';

import 'package:feed_me/constants/custom_widgets/numbers_widget.dart';
import 'package:feed_me/constants/custom_widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../model/recipe_db_object.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage(
      {Key key,
      @required this.recipeCount,
      @required this.cookBookCount,
      @required this.fromRegistration})
      : super(key: key);
  final int recipeCount;
  final int cookBookCount;
  final bool fromRegistration;

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  String userDescription = '';
  AuthService auth = AuthService();

  waitAndRefresh() async {
    await Future.delayed(const Duration(milliseconds: 5));
    setState(() {});
  }

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            FadeInDown(
              from: 100,
              duration: const Duration(milliseconds: 500),
              child: ProfileWidget(
                isProfileRoot: true,
                isLoadingState: false,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            FadeInDown(
                from: 100,
                duration: const Duration(milliseconds: 500),
                child: buildName(auth,size)),
            SizedBox(height: size.height * 0.01),
            FadeInDown(
              from: 100,
              duration: const Duration(milliseconds: 500),
              child: NumbersWidget(
                recipeCount: widget.recipeCount,
                cookBookCount: widget.cookBookCount,
              ),
            ),
            SizedBox(height: size.height * 0.35),
            FadeInUp(
              from: 100,
              duration: const Duration(milliseconds: 500),
              child: StandardButton(
                  color: Colors.white,
                  text: "Eingaben speichern",
                  onPressed: () {
                    var user = auth.getUser();
                    if (user.displayName == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RoundedAlert(
                            title: "❗️Achtung❗",
                            text: "Bitte gib deinen Namen an ☺️",
                          );
                        },
                      );
                    }
                    // else if (user.photoURL == null) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return RoundedAlert(
                    //         title: "❗️Achtung❗",
                    //         text: "Gib bitte ein Profilbild an ☺️",
                    //       );
                    //     },
                    //   );
                    // }
                    else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Home()));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildName(AuthService auth, Size size) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width*0.9,
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 11, right: 15),
                  hintText:
                      auth.getUser().displayName ?? 'Benutzername eingeben'),
              onChanged: (value) {
                String displayName = value;
                displayName.replaceAll('\n', ' ');
                auth.getUser().updateDisplayName(displayName);
              },
            ),
          ),
        ],
      );

  Widget buildAbout(Size size, AuthService auth) => Container(
        height: size.height * 0.27,
        decoration: BoxDecoration(
          color: Colors.white54,
          border: Border.all(
            width: 15,
            color: basicColor,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintText: 'Schreibe etwas über dich:'
              //TODO insert UserDescription
              ),
          minLines: 6,
          maxLines: 9,
          onChanged: (value) {
            //TODO inser method for user description
          },
        ),
      );
}
