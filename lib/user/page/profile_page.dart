import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/custom_alert.dart';
import 'package:feed_me/constants/orange_box_decoration.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/authenticate.dart';
import 'package:feed_me/registration_and_login/google_services/google_auth.dart';
import 'package:feed_me/registration_and_login/sign_in.dart';
import 'package:feed_me/user/page/set_profile_information.dart';
import 'package:feed_me/user/widget/appbar_widget.dart';
import 'package:feed_me/user/widget/numbers_widget.dart';
import 'package:feed_me/user/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, @required this.recipeCount, @required this.cookBookCount}) :
super(key:
key);
  final int recipeCount;
  final int cookBookCount;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService auth = AuthService();
  AuthenticationGoogle authGoogle = AuthenticationGoogle();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: orangeBoxDecoration,
      child: Scaffold(
        appBar: buildAppBar(
            context,
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  SetProfilePage
                            (recipeCount: widget.recipeCount, cookBookCount:
                          widget.cookBookCount,)));
                },
                icon: Icon(MdiIcons.accountEdit, size: size.width * 0.11))),
        backgroundColor: basicColor,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(isProfileRoot: false,isLoadingState: false,),
            SizedBox(height: size.height * 0.015),
            buildName(),
            SizedBox(height: size.height * 0.01),
            NumbersWidget(recipeCount: widget.recipeCount, cookBookCount: 0,),
            SizedBox(height: size.height * 0.01),
            buildAbout(auth),
            SizedBox(height: size.height * 0.01),
            StandardButton(
                color: Colors.white,
                text: "Log out",
                onPressed: () {
                  auth.signOut();
                  AuthenticationGoogle.signOut(context: context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignIn()));
                }),
          ],
        ),
      ),
    );
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

  Widget buildAbout(AuthService auth) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Über mich:',
              style: TextStyle(
                  color: Colors.black45,
                  fontFamily: openSansFontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              GetStorage(auth.getUser().uid).read('userDescription') ??
                  'Keine Beschreibung vorhanden',
              style: const TextStyle(
                  fontFamily: openSansFontFamily,
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.black54),
            ),
          ],
        ),
      );


}
