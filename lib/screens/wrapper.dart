
import 'package:feed_me/model/user_local.dart';
import 'package:feed_me/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserLocal>(context);
    if(user == null){
      //  return either Home or Authenticate Widget
      return const Authenticate();
    }
    else{
      return const ChooseCookbook();
    }
  }
}