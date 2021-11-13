import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/colors.dart';

import 'package:feed_me/screens/choose_cookbook.dart';

import 'package:feed_me/registration_and_login/user_local.dart';

import 'package:feed_me/user/widget/numbers_widget.dart';
import 'package:feed_me/user/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key key}) : super(key: key);

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  String userDescription='';
  String email ='';

  @override
  void initState() {
    email =  Provider.of<UserLocal>(context, listen: false).getUserMail();
    super.initState();
  }

  waitAndRefresh() async {
    await Future.delayed(const Duration(milliseconds: 5));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String userName = '';
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [],
      ),
      backgroundColor: BasicGreen,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileWidget(isProfileRoot: true),
          SizedBox(height: size.height * 0.015),
          buildName(userName),
          SizedBox(height: size.height * 0.01),
          NumbersWidget(
              userMail:email),
          SizedBox(height: size.height * 0.01),
          buildAbout(size),
          SizedBox(height: size.height * 0.0025),
          StandardButton(
              color: Colors.white,
              text: "Eingaben speichern",
              onPressed: () {
                //TODO if check if all data is stored

                Provider.of<UserLocal>(context, listen: false).setDescription(userDescription);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ChooseCookbook()));
              }),
        ],
      ),
    );
  }

  Widget buildName(String userName) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              border: Border.all(
                width: 15,
                color: BasicGreen,
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
                  hintText: 'Benutzername eingeben'),
              onChanged: (value) {
                Provider.of<UserLocal>(context, listen: false)
                    .getFireBaseUser()
                    .updateDisplayName(value);
              },
              //TODO find a way to add external User data
            ),
          ),
        ],
      );

  Widget buildAbout(Size size) => Container(
        height: size.height * 0.27,
        decoration: BoxDecoration(
          color: Colors.white54,
          border: Border.all(
            width: 15,
            color: BasicGreen,
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
              hintText: 'Schreibe etwas über dich:'),
          minLines: 6,
          maxLines: 9,
          onChanged: (value){
            setState(() {
              userDescription = value;
            });
          },
          //TODO find a way to add external User data
        ),
      );
}
