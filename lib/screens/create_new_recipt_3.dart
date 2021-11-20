import 'package:feed_me/constants/show_steps_widget.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'create_new_recipt_2.dart';

class CreateNewRecipe_3 extends StatefulWidget {
  const CreateNewRecipe_3({Key key}) : super(key: key);

  @override
  _CreateNewRecipe_3State createState() => _CreateNewRecipe_3State();
}

class _CreateNewRecipe_3State extends State<CreateNewRecipe_3> {
  File image;
  String inputText;
  List<String> items = [];
  bool hasImage = false;
  List<Color> colors = [
    Colors.green,
    Colors.green,
    Colors.green,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowSteps(
                  colors: colors,
                  step: "3.Schritt: Beschreibung und Schwierigkeit festlegen"),
              SizedBox(height: size.height * 0.01),
              const Text("Kurzbeschreibung hinzufügen:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: openSansFontFamily)),
              SizedBox(height: size.height * 0.01),
              Container(
                height: size.height * 0.4,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.5)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  maxLines: 25,
                  onChanged: (value) {},
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Kurzbeschreibung hinzufügen',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              const Text("Schwierigkeit:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: openSansFontFamily)),
              SizedBox(height: size.height * 0.01),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  difficultyButton(size,"Einfach"),
                  SizedBox(width: size.width*0.05),
                  difficultyButton(size,"Mittel"),
                  SizedBox(width: size.width*0.05),
                  difficultyButton(size,"Schwer"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget difficultyButton(Size size, String text) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.2,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: () {},
        child: Center(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: openSansFontFamily))),
      ),
    );
  }

  Widget buttonRow(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.08,
          width: size.width * 0.4,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Zurück",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.1,
        ),
        Container(
          height: size.height * 0.08,
          width: size.width * 0.4,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateNewRecipe_2()));
            },
            child: const Text(
              "Nächster Schritt",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
