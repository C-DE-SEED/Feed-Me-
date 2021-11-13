import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/user_local.dart';
import 'package:feed_me/user/page/set_profile_information.dart';
import 'package:feed_me/user/widget/appbar_widget.dart';
import 'package:feed_me/user/widget/numbers_widget.dart';
import 'package:feed_me/user/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthService authService = AuthService();
    return Scaffold(
      appBar: buildAppBar(
          context,
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SetProfilePage()));
              },
              icon: Icon(MdiIcons.accountEdit, size: size.width * 0.11))),
      backgroundColor: BasicGreen,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileWidget(isProfileRoot: false),
          SizedBox(height: size.height * 0.015),
          buildName(authService),
          SizedBox(height: size.height * 0.01),
          NumbersWidget(
              userMail:
                  authService.getUser().email),
          SizedBox(height: size.height * 0.01),
          buildAbout(authService),
        ],
      ),
    );
  }

  Widget buildName(AuthService authService) => Column(
        children: [
          Text(
            authService.getUser().displayName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: openSansFontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildAbout(AuthService authService) => Container(
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
              Provider.of<UserLocal>(context, listen: false).getDescription()
              ?? 'Keine Beschreibung vorhanden' ,
              style: const TextStyle(
                  fontFamily: openSansFontFamily, fontSize: 16, height: 1.4,
                  color: Colors.black54),
            ),
          ],
        ),
      );
}
