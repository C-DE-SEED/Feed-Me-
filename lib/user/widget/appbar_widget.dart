import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:feed_me/registration_and_login/authenticate.dart';

AppBar buildAppBar(BuildContext context) {
  final AuthService _auth = AuthService();
  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      TextButton(
        child: Text("Logout",
            style: TextStyle(
                fontFamily: openSansFontFamily,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        onPressed: () async {
          await _auth.signOut();
        },
      ),
      IconButton(
        icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 27.0),
        onPressed: () {
          //TODO insert User setting method
        },
      ),
    ],
  );
}
