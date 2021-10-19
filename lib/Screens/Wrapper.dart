import 'package:feed_me/RegistrationAndLogin/Authenticate.dart';
import 'package:feed_me/RegistrationAndLogin/UserLocal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserLocal>(context);
    if(user == null){
      //  return either Home or Authenticate Widget
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}