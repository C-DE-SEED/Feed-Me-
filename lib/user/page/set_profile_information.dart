import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/standard_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/screens/home.dart';
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
    String userName = '';
    return Scaffold(
      appBar: buildAppBar(
          context,
          IconButton(
              onPressed: () {
                //TODO if check that all user informations are filled
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              icon: const Icon(
                Icons.save_outlined,
                size: 40.0,
                color: Colors.white60,
              ))),
      backgroundColor: BasicGreen,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileWidget(),
          SizedBox(height: size.height * 0.06),
          buildName(_auth, userName),
          SizedBox(height: size.height * 0.06),
          const NumbersWidget(),
          SizedBox(height: size.height * 0.06),
          buildAbout(_auth, size),
        ],
      ),
    );
  }

  Widget buildName(AuthService authService, String userName) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Benutzername eingeben",
              ),
              //TODO find a way to add external User data
            ),
          ),
          const SizedBox(height: 5),
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

  Widget buildAbout(AuthService authService, Size size) => Container(
        height: size.height * 0.27,
        decoration: BoxDecoration(
          color: Colors.white54,
          border: Border.all(
            width: 20,
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
          //TODO find a way to add external User data
        ),
      );
}
