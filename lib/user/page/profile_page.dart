import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/user/widget/appbar_widget.dart';
import 'package:feed_me/user/widget/numbers_widget.dart';
import 'package:feed_me/user/widget/profile_widget.dart';
import 'package:flutter/material.dart';

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
      appBar: buildAppBar(context),
      backgroundColor: BasicGreen,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileWidget(),
          SizedBox(height: size.height * 0.07),
          buildName(authService),
          SizedBox(height: size.height * 0.07),
          const NumbersWidget(),
          SizedBox(height: size.height * 0.07),
          buildAbout(authService),
        ],
      ),
    );
  }

  Widget buildName(AuthService authService) => Column(
        children: [
          Text(
            authService.getUser().displayName,
            style: const TextStyle(
                fontFamily: openSansFontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_outlined,
                color: Colors.black54,
              ),
              const SizedBox(
                width: 7.0,
              ),
              Text(
                authService.getUser().email,
                style: const TextStyle(
                  fontFamily: openSansFontFamily,
                  color: Colors.black54,
                ),
              ),
            ],
          )
        ],
      );

  Widget buildAbout(AuthService authService) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Über mich:',
              style: TextStyle(
                  color: Colors.black45,
                  fontFamily: openSansFontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Lore Ipsum Lore Ipsum',
              style: TextStyle(
                  fontFamily: openSansFontFamily, fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}