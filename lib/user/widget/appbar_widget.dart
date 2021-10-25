import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {

  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: const Icon(Icons.edit_outlined, color:Colors.white, size: 27.0),
        onPressed: () {
          //TODO insert User setting method
        },
      ),
    ],
  );
}