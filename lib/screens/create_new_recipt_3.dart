import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/show_steps_widget.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'create_new_recipt_2.dart';
import 'create_new_recipt_4.dart';

class CreateNewRecipe_3 extends StatefulWidget {
  const CreateNewRecipe_3({Key key}) : super(key: key);

  @override
  _CreateNewRecipe_3State createState() => _CreateNewRecipe_3State();
}

class _CreateNewRecipe_3State extends State<CreateNewRecipe_3> {
  File image;
  String inputText;
  List<String> items = [];
  bool easy = false;
  bool medium = false;
  bool hard = false;
  String time = "0";
  String persons = "1";
  List<Color> colors = [
    DeepOrange,
    DeepOrange,
    DeepOrange,
    Colors.white.withOpacity(0.5),
  ];
  List<String> timeList = [
    "5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
    "55",
    "60",
  ];
  List<String> personList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
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
                height: size.height * 0.2,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.5)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                  onChanged: (value) {},
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Kurzbeschreibung hinzufügen',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
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
                  difficultyButton(size, "Einfach", BasicGreen, easy, () {
                    setState(() {
                      easy = !easy;
                      if (easy == true) {
                        medium = false;
                        hard = false;
                      }
                    });
                  }),
                  SizedBox(width: size.width * 0.05),
                  difficultyButton(size, "Mittel", BasicGreen, medium, () {
                    setState(() {
                      medium = !medium;
                      if (medium == true) {
                        easy = false;
                        hard = false;
                      }
                    });
                  }),
                  SizedBox(width: size.width * 0.05),
                  difficultyButton(size, "Schwer", BasicGreen, hard, () {
                    setState(() {
                      hard = !hard;
                      if (hard == true) {
                        medium = false;
                        easy = false;
                      }
                    });
                  }),
                ],
              ),
              SizedBox(height: size.height * 0.09),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width*0.4,
                    child: const Text("Zubereitungszeit: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily)),
                  ),
                  SizedBox(width: size.width * 0.1),
                  Container(
                    width: size.width*0.3,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: DeepOrange),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        _showMinutesPicker(context, size);
                      },
                      child: Text(time + " Minuten",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width*0.4,
                    child: const Text("Anzahl der Personen:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily)),
                  ),
                  SizedBox(width: size.width * 0.1),
                  Container(
                    width: size.width*0.3,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: DeepOrange),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        _showPersonsPicker(context, size);
                      },
                      child: Text(persons + " Personen",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.17),
              buttonRow(size)
            ],
          ),
        ),
      ),
    );
  }

  void _showMinutesPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: size.width,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: DeepOrange,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: timeList
                    .map((item) => Center(
                          child: Text(item),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    time = timeList.elementAt(value);
                  });
                },
              ),
            ));
  }


  void _showPersonsPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
          width: size.width,
          height: 250,
          child: CupertinoPicker(
            backgroundColor: DeepOrange,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 1),
            children: personList
                .map((item) => Center(
              child: Text(item),
            ))
                .toList(),
            onSelectedItemChanged: (value) {
              setState(() {
                persons = personList.elementAt(value);
              });
            },
          ),
        ));
  }

  Widget difficultyButton(
      Size size, String text, Color color, bool isChosen, Function onPressed) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.2,
      decoration: BoxDecoration(
          color: isChosen ? color : Colors.transparent,
          border: isChosen ? null :Border.all(color: DeepOrange),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: onPressed,
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
              border: Border.all(color: Colors.deepOrange),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Zurück",
              style: TextStyle(
                color: DeepOrange,
                fontSize: 18.0,
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
              color: DeepOrange, borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateNewRecipe_4()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Weiter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(width: size.width * 0.01),
                const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
