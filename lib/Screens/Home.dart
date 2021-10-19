import 'package:feed_me/RegistrationAndLogin/AuthService.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(child: TextButton(
      onPressed: ()async{
        await _auth.signOut();
      },
      child: Text("logout"),
    ));
  }
}
