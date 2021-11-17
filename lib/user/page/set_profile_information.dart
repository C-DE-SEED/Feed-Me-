import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';

import 'package:feed_me/screens/choose_cookbook.dart';

import 'package:feed_me/registration_and_login/user_local.dart';

import 'package:feed_me/user/widget/numbers_widget.dart';
import 'package:feed_me/user/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../recipt_db_object.dart';

class SetProfilePage extends StatefulWidget {

  const SetProfilePage({Key key,}) : super(key: key);

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

  getAdditionalData() async {
     Future<int> recipes = ReciptDbObject().getReciptObject
      ("plant_food_factory").length;
     await GetStorage(auth.getUser().uid).write('recipes', recipes);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
      ),
      backgroundColor: basicColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileWidget(isProfileRoot: true),
          SizedBox(height: size.height * 0.015),
          buildName(auth,GetStorage(auth.getUser().uid)),
          SizedBox(height: size.height * 0.01),
          NumbersWidget(),
          SizedBox(height: size.height * 0.01),
          buildAbout(size, auth),
          SizedBox(height: size.height * 0.0025),
          StandardButton(
              color: Colors.white,
              text: "Eingaben speichern",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseCookbook()));
              }),
        ],
      ),
    );
  }

  Widget buildName(AuthService auth, GetStorage box) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 11, right: 15),
                  hintText: GetStorage(auth.getUser().uid).read('displayName') ??
                      'Benutzername '
                          'eingeben'),
              onChanged: (value) {
                String name = value;
                //TODO remove enter from string
                name.replaceAll('\n', ' ');
                GetStorage(auth.getUser().uid).write('displayName', name);
                auth.getUser().updateDisplayName(name);
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
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                  left: 15, bottom: 11, top: 11, right: 15),
              hintText:
                  GetStorage(auth.getUser().uid).read('userDescription')
                      .toString() ?? 'Schreibe etwas über dich:'),
          minLines: 6,
          maxLines: 9,
          onChanged: (value) {
            userDescription = value;
            GetStorage(auth.getUser().uid).write('userDescription', userDescription);
          },
        ),
      );
}
