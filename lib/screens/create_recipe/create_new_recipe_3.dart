import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/constants/user_options.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'create_new_recipe_4.dart';

class CreateNewRecipe_3 extends StatefulWidget {
  const CreateNewRecipe_3({Key key, @required this.recipe, @required this.cookbook}) : super(key: key);
  final Recipe recipe;
  final Cookbook cookbook;


  @override
  _CreateNewRecipe_3State createState() => _CreateNewRecipe_3State();
}

class _CreateNewRecipe_3State extends State<CreateNewRecipe_3> {
  List<String> items = [];
  bool easy = false;
  bool medium = false;
  bool hard = false;
  String time = "0";
  String persons = "1";
  String category = 'Vorspeise';

  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width:size.width*0.9,
            height:size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ShowSteps(
                    colors: step3,
                    step: "3.Schritt: Beschreibung und Schwierigkeit festlegen"),
                SizedBox(height: size.height * 0.01),
                const Center(
                  child: Text("Kurzbeschreibung hinzufügen:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: openSansFontFamily)),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.2,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.5)),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    maxLines: 10,
                    onChanged: (value) {
                      widget.recipe.shortDescription = value;
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Sehr leckeres Rote Thai Curry...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: const Text("Zubereitungszeit: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontFamily: openSansFontFamily)),
                    ),
                    const Spacer(),
                    Container(
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: deepOrange),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          _showMinutesPicker(context, size);
                        },
                        child: Text(time + " Minuten",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontFamily: openSansFontFamily)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: const Text("Anzahl der Personen:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontFamily: openSansFontFamily)),
                    ),
                    const Spacer(),
                    Container(
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: deepOrange),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          _showPersonsPicker(context, size);
                        },
                        child: Text(persons + " Personen",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontFamily: openSansFontFamily)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: const Text("Art des Gerichts:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontFamily: openSansFontFamily)),
                    ),
                    const Spacer(),
                    Container(
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: deepOrange),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          _showCategoryPicker(context, size);
                        },
                        child: Text(category,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontFamily: openSansFontFamily)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                const Center(
                  child: Text("Schwierigkeit:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: openSansFontFamily)),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    difficultyButton(size, "Einfach", deepOrange, easy, () {
                      setState(() {
                        easy = !easy;
                        if (easy == true) {
                          medium = false;
                          hard = false;
                          widget.recipe.difficulty = 'Einfach';
                        }
                      });
                    }),
                    const Spacer(),
                    difficultyButton(size, "Mittel", deepOrange, medium, () {
                      setState(() {
                        medium = !medium;
                        if (medium == true) {
                          easy = false;
                          hard = false;
                          widget.recipe.difficulty = 'Mittel';
                        }
                      });
                    }),
                    const Spacer(),
                    difficultyButton(size, "Schwer", deepOrange, hard, () {
                      setState(() {
                        hard = !hard;
                        if (hard == true) {
                          medium = false;
                          easy = false;
                          widget.recipe.difficulty = 'Schwer';
                        }
                      });
                    }),
                  ],
                ),
                const Spacer(),
                ButtonRow(
                  onPressed: () {
                    // widget.recipe.shortDescription = shortDescription;
                    // widget.recipe.time = time;
                    // widget.recipe.persons = persons;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateNewRecipe_4(recipe: widget.recipe, cookbook: widget.cookbook)));
                  },
                )
              ],
            ),
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
                backgroundColor: deepOrange,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: timeList
                    .map((item) => Center(
                          child: Text(item,style: const TextStyle(
                            color: Colors.white,
                          )),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    time = timeList.elementAt(value);
                    widget.recipe.time = time;
                  });
                },
              ),
            ));
  }

  void _showCategoryPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: size.width,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: deepOrange,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: categoryList
                    .map((item) => Center(
                          child: Text(item,style: const TextStyle(
                            color: Colors.white,
                          )),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    category = categoryList.elementAt(value);
                    widget.recipe.category = category;
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
                backgroundColor: deepOrange,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: personList
                    .map((item) => Center(
                          child: Text(item,style: const TextStyle(
                              color: Colors.white,
                             )),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    persons = personList.elementAt(value);
                    widget.recipe.persons = persons;
                  });
                },
              ),
            ));
  }

  Widget difficultyButton(
      Size size, String text, Color color, bool isChosen, Function onPressed) {
    return Container(
      // height: size.height * 0.05,
      width: size.width * 0.25,
      decoration: BoxDecoration(
          color: isChosen ? color : Colors.transparent,
          border: isChosen ? null : Border.all(color: deepOrange),
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontFamily: openSansFontFamily))),
      ),
    );
  }
}
