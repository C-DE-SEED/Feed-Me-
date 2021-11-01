import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/standard_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/user/widget/appbar_widget.dart';
import 'package:feed_me/user/widget/numbers_widget.dart';
import 'package:feed_me/user/widget/profile_widget.dart';
import 'package:flutter/material.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({Key key}) : super(key: key);

  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AuthService _auth = AuthService();
    String userName='';
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: BasicGreen,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileWidget(),
          SizedBox(height: size.height * 0.07),
          buildName(_auth, userName),
          SizedBox(height: size.height * 0.07),
          const NumbersWidget(),
          SizedBox(height: size.height * 0.07),
          buildAbout(_auth),
        ],
      ),
    );
  }

  Widget buildName(AuthService authService, String userName) => Column(
        children: [
    Container(
    color: Colors.transparent,
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: TextFormField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: openSansFontFamily,
        color: Colors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: BasicGreen,
        ),
        filled: true,
        fillColor: Colors.white60,
        hintText: 'Benutzername',
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: BasicGreen, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
      onChanged: (value) {
        setState(() {
          userName = value;
        });
        authService.getUser().updateDisplayName(userName);
      },
    ),
  ),
          const SizedBox(height: 10),
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
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: LightBasicGreen,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Schreibe etwas über dich",
              ),
             //TODO find a way to add external User data
            ),
          ],
        ),
      );
}
