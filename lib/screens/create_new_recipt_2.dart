import 'package:feed_me/constants/animated_text_field_list.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/show_steps_widget.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateNewRecipe_2 extends StatefulWidget {
  const CreateNewRecipe_2({Key key}) : super(key: key);

  @override
  _CreateNewRecipe_2State createState() => _CreateNewRecipe_2State();
}

class _CreateNewRecipe_2State extends State<CreateNewRecipe_2> {
  List<Color> colors = [
    Colors.green,
    Colors.green,
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
  ];
  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              ShowSteps(colors: colors, step: "2. Schritt: Zutaten angeben",)
            ],
          ),
        )));
  }
}
