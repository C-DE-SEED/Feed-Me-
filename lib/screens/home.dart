import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
