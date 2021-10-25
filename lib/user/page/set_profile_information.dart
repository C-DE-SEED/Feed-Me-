import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/standard_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/user/model/user.dart';
import 'package:feed_me/user/widget/appbar_widget.dart';
import 'package:feed_me/user/widget/numbers_widget.dart';
import 'package:feed_me/user/widget/profile_widget.dart';
import 'package:flutter/material.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: BasicGreen,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            user: widget.user,
          ),
          SizedBox(height: size.height * 0.07),
          buildName(widget.user),
          SizedBox(height: size.height * 0.07),
          const NumbersWidget(),
          SizedBox(height: size.height * 0.07),
          buildAbout(widget.user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          MailTextFormField(
              hintText: 'Benutzername',
              onChange: (value) {
                setState(() {
                  widget.user.name = value;
                });
              }),
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
                user.email,
                style: const TextStyle(
                  fontFamily: openSansFontFamily,
                  color: Colors.black54,
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
            MailTextFormField(
            hintText: 'Über mich:',
            onChange: (value) {
              setState(() {
                widget.user.about = value;
              });
            }),
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
