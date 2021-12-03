import 'package:feed_me/constants/styles/colors.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, IconButton iconButton) {
  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0,0,15,0),
        child: iconButton,
      ),
    ],
  );
}