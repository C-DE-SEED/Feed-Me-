import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/constants/user_options.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../home.dart';
import 'create_new_recipe_4.dart';

class CreateNewRecipe_5 extends StatefulWidget {
  const CreateNewRecipe_5(
      {Key key, @required this.recipe, @required this.cookbook})
      : super(key: key);
  final Recipe recipe;
  final Cookbook cookbook;

  @override
  _CreateNewRecipe_5State createState() => _CreateNewRecipe_5State();
}

class _CreateNewRecipe_5State extends State<CreateNewRecipe_5> {
  String description;
  List<String> items = [];
  bool low = false;
  bool medium = false;
  bool high = false;
  String type = "Italienisch";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: size.width * 0.9,
            height: size.height*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ShowSteps(
                    colors: step5,
                    step: "5.Schritt: Beschreibung und Herkunft"),
                SizedBox(height: size.height * 0.01),
                const Center(
                  child: Text("Beschreibung hinzufügen:",
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
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.5)),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    maxLines: 10,
                    onChanged: (value) {},
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Dieses Rote Thai Curry ist ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                const Center(
                  child: Text("Art: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: openSansFontFamily)),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: deepOrange),
                      borderRadius: BorderRadius.circular(10)),
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
                SizedBox(height: size.height * 0.05),
                const Center(
                  child: Text("Schärfegrad:",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: openSansFontFamily)),
                ),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    spicyButton(
                        size,
                        const Icon(
                          MdiIcons.chiliMild,
                          color: Colors.white,
                        ),
                        deepOrange,
                        low, () {
                      setState(() {
                        low = !low;
                        if (low == true) {
                          medium = false;
                          high = false;
                          widget.recipe.difficulty = 'Nicht Scharf';
                        }
                      });
                    }),
                    const Spacer(),
                    spicyButton(
                        size,
                        const Icon(MdiIcons.chiliMedium, color: Colors.white),
                        deepOrange,
                        medium, () {
                      setState(() {
                        medium = !medium;
                        if (medium == true) {
                          low = false;
                          high = false;
                          widget.recipe.difficulty = 'Mittelscharf';
                        }
                      });
                    }),
                    const Spacer(),
                    spicyButton(
                        size,
                        const Icon(MdiIcons.chiliHot, color: Colors.white),
                        deepOrange,
                        high, () {
                      setState(() {
                        high = !high;
                        if (high == true) {
                          medium = false;
                          low = false;
                          widget.recipe.difficulty = 'Scharf';
                        }
                      });
                    }),
                  ],
                ),
                const Spacer(),
                ButtonRow(
                  onPressed: () async {
                    widget.recipe.origin = type;
                    //TODO: Add spice level to database model

                    addToDatabase();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget spicyButton(
      Size size, Icon icon, Color color, bool isChosen, Function onPressed) {
    return Container(
      width: size.width * 0.25,
      decoration: BoxDecoration(
          color: isChosen ? color : Colors.transparent,
          border: isChosen ? null : Border.all(color: deepOrange),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: onPressed,
        child: Center(child: icon),
      ),
    );
  }

  void addToDatabase() async {
    RecipeDbObject dbObject = RecipeDbObject();
    bool exist = await dbObject.checkIfDocumentExists(widget.cookbook.name);
    if (exist == true) {
      String imagePath =
          await dbObject.getCookBookAttributes(widget.cookbook.name);

      await RecipeDbObject().updateRecipe(
          "1",
          widget.recipe.category,
          widget.recipe.description,
          widget.recipe.difficulty,
          widget.recipe.image,
          widget.recipe.ingredientsAndAmount,
          '',
          widget.recipe.name,
          widget.recipe.origin,
          widget.recipe.persons,
          widget.recipe.shortDescription,
          '',
          widget.recipe.time,
          widget.cookbook.name,
          imagePath);
    } else {
      await RecipeDbObject().updateRecipe(
          "1",
          widget.recipe.category,
          widget.recipe.description,
          widget.recipe.difficulty,
          widget.recipe.image,
          widget.recipe.ingredientsAndAmount,
          '',
          widget.recipe.name,
          widget.recipe.origin,
          widget.recipe.persons,
          widget.recipe.shortDescription,
          '',
          widget.recipe.time,
          widget.cookbook.name,
          widget.recipe.image);
    }
  }
}
