import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/constants/user_options.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';
import 'create_new_recipe_4.dart';

class CreateNewRecipe_3 extends StatefulWidget {
  const CreateNewRecipe_3(
      {Key key, @required this.recipe, @required this.cookbook})
      : super(key: key);
  final Recipe recipe;
  final Cookbook cookbook;

  @override
  _CreateNewRecipe_3State createState() => _CreateNewRecipe_3State();
}

class _CreateNewRecipe_3State extends State<CreateNewRecipe_3> {
  List<String> items = [];
  String time = 'Auswählen';
  String persons = 'Auswählen';
  String category = 'Auswählen';
  String shortDescription = '';
  String type = 'Auswählen';
  String difficulty = 'Einfach';

  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: basicColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                    child: Text('3. Schritt: Beschreibung des Gerichtes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontFamily: openSansFontFamily))),
                SizedBox(height: size.height * 0.01),
                Hero(
                  tag: 'steps',
                  child: ShowSteps(colors: step3),
                ),
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
                  height: size.height * 0.1,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white.withOpacity(0.5)),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    onChanged: (value) {
                      shortDescription = value;
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: 'z.B. leckeres rotes Thai Curry...',
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
                      child: const Text("Zuordnung:  ",
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
                          _showOriginPicker(context, size);
                        },
                        child: Text(type,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontFamily: openSansFontFamily)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: const Text("Zubereitungsdauer in Minuten: ",
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
                        child: Text(time,
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
                        child: Text(persons,
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
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: const Text("Schwierigkeit:",
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
                          _showDifficultyPicker(context, size);
                        },
                        child: Text(difficulty,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: fontSize,
                                fontFamily: openSansFontFamily)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                const Spacer(),
                Hero(
                  tag: 'buttonRow',
                  child: ButtonRow(
                    onPressed: () {
                     if (time == 'Auswählen') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RoundedAlert(
                              title: "❗️Achtung❗",
                              text:
                                  "Gib bitte die Zubereitungsdauer deines Rezeptes an ☺️",
                            );
                          },
                        );
                      } else if (persons == 'Auswählen') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RoundedAlert(
                              title: "❗️Achtung❗",
                              text: "Gib bitte die Anzahl der Personen an ☺️",
                            );
                          },
                        );
                      } else if (category == 'Auswählen') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RoundedAlert(
                              title: "❗️Achtung❗",
                              text: "Gib bitte die Art deines Gerichtes an ☺️",
                            );
                          },
                        );
                      } else if (shortDescription == '') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RoundedAlert(
                              title: "❗️Achtung❗",
                              text:
                                  "Gib bitte eine kurze Beschreibung deines Gerichtes an ☺️",
                            );
                          },
                        );
                      } else {
                        widget.recipe.shortDescription = shortDescription;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateNewRecipe_4(
                                    recipe: widget.recipe,
                                    cookbook: widget.cookbook)));
                      }
                      // widget.recipe.shortDescription = shortDescription;
                      // widget.recipe.time = time;
                      // widget.recipe.persons = persons;
                    },
                  ),
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
                          child: Text(item,
                              style: const TextStyle(
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
                          child: Text(item,
                              style: const TextStyle(
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
                          child: Text(item,
                              style: const TextStyle(
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

  void _showOriginPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: size.width,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: deepOrange,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: originList
                    .map((item) => Center(
                          child: Text(item,
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    type = originList.elementAt(value);
                    widget.recipe.origin = type;
                  });
                },
              ),
            ));
  }

  void _showDifficultyPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
          width: size.width,
          height: 250,
          child: CupertinoPicker(
            backgroundColor: deepOrange,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 1),
            children: difficultyList
                .map((item) => Center(
              child: Text(item,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
            ))
                .toList(),
            onSelectedItemChanged: (value) {
              setState(() {
                difficulty = difficultyList.elementAt(value);
                widget.recipe.difficulty = difficulty;
              });
            },
          ),
        ));
  }

  Widget spicyButton(
      Size size, Icon icon, Color color, bool isChosen, Function onPressed) {
    return Container(
      width: size.width * 0.25,
      decoration: BoxDecoration(
          color: isChosen ? color : Colors.transparent,
          border: isChosen ? null : Border.all(color: deepOrange),
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: onPressed,
        child: Center(child: icon),
      ),
    );
  }
}
