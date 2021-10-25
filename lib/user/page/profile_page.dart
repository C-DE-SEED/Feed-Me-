import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/user/model/user.dart';
import 'package:feed_me/user/utils/user_preferences.dart';
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
    const user = UserPreferences.myUser;
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: BasicGreen,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              //TODO insert user images from camera roll
            },
          ),
          SizedBox(height: size.height * 0.07),
          buildName(user),
          SizedBox(height: size.height * 0.07),
          const NumbersWidget(),
          SizedBox(height: size.height * 0.07),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
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
                color:Colors.black54,
              ),
              const SizedBox(width: 7.0,),
              Text(
                user.email,
                style: const TextStyle(
                    fontFamily: openSansFontFamily, color:
                Colors.black54,
                ),
              ),
            ],
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Über mich:',
              style: TextStyle(
                  color:Colors.black45,
                  fontFamily: openSansFontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: const TextStyle(
                  fontFamily: openSansFontFamily, fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
