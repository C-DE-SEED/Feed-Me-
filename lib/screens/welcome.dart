import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await _auth.signOut();
      },
      child: const Text("logout"),
    );
  }
}
