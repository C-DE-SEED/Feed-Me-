import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/constants/user_options.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/ingredient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/recipe_object.dart';
import '../maxi_check_mal_aus.dart';
import 'create_new_recipe_3.dart';

class CreateNewRecipe_2 extends StatefulWidget {
  Recipe recipe;
  Cookbook cookbook;

  CreateNewRecipe_2({Key key, this.recipe, this.cookbook}) : super(key: key);

  @override
  _CreateNewRecipe_2State createState() => _CreateNewRecipe_2State();
}

class _CreateNewRecipe_2State extends State<CreateNewRecipe_2> {
  int counter = 1;
  List<String> items = [""];
  List<Ingredient> ingredients = [];
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    ingredients.add(Ingredient('', '', 'Einheit'));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: basicColor,
      body: SafeArea(
        child: ListView(children: [
          Center(
            child: SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.9,
              child: Column(
                children: [
                  const Center(
                      child: Text('2. Schritt: Zutaten und Gewürze angeben',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontFamily: openSansFontFamily))),
                  SizedBox(height: size.height * 0.01),
                  Hero(
                    tag: 'steps',
                    child: ShowSteps(colors: step2),
                  ),
                  SizedBox(height: size.height * 0.01),
                  AnimatedList(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    key: listKey,
                    initialItemCount: items.length,
                    itemBuilder: (context, index, anim) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1, 0), end: Offset.zero)
                            .animate(anim),
                        child: ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15)),
                            height: size.height * 0.15,
                            child: Column(
                              children: [
                                // TODO größe anpassen vom textfeld
                                // Expanded(child: TextfieldWithSuggestion()),
                                TextFormField(
                                  obscureText: false,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Zutat eingeben',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      ingredients.elementAt(index).title =
                                          value;
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.2,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: 'Menge',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            ingredients
                                                .elementAt(index)
                                                .amount = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.1,
                                    ),
                                    Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.white))),
                                        width: size.width * 0.2,
                                        height: size.height * 0.058,
                                        child: TextButton(
                                            onPressed: () {
                                              showUnits(context, size, index);
                                            },
                                            child: Center(
                                                child: Text(
                                              ingredients.elementAt(index).unit,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: fontSize,
                                              ),
                                            )))),
                                  ],
                                )
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              items.remove(items.elementAt(index));
                              listKey.currentState.removeItem(
                                index,
                                (context, animation) {
                                  return SizeTransition(
                                    sizeFactor: animation,
                                    axis: Axis.vertical,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(40)),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                    ),
                                  );
                                },
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.01),
                  addAnotherIngredientButton(size),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Hero(
                      tag: 'buttonRow',
                      child: ButtonRow(
                        onPressed: () {
                          if (ingredients.elementAt(0).amount == '') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RoundedAlert(
                                  title: "❗️Achtung❗",
                                  text: "Gib bitte deine Zutaten an ☺️",
                                );
                              },
                            );
                          } else {
                            widget.recipe.ingredientsAndAmount =
                                ingredientsAndAmountToString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateNewRecipe_3(
                                          recipe: widget.recipe,
                                          cookbook: widget.cookbook,
                                        )));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void insertItem(int index, String item) {
    items.insert(index, item);
    ingredients.add(Ingredient('', '', 'Einheit'));
    listKey.currentState.insertItem(index);
  }

  Widget addAnotherIngredientButton(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width * 0.65,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: deepOrange),
              borderRadius: BorderRadius.circular(15)),
          child: TextButton(
              onPressed: () {
                setState(() {
                  insertItem(items.length, counter.toString());
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: deepOrange),
                  Text("Weitere Zutat hinzufügen",
                      style: TextStyle(
                          color: deepOrange,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily)),
                ],
              )),
        ),
        SizedBox(
          width: size.width * 0.15,
        )
      ],
    );
  }

  void showUnits(BuildContext ctx, Size size, int index) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: size.width,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: deepOrange,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: unitList
                    .map((item) => Center(
                          child: Text(
                            item,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    ingredients.elementAt(index).unit =
                        unitList.elementAt(value);
                  });
                },
              ),
            ));
  }

  String ingredientsAndAmountToString() {
    String joiner = '';
    for (var element in ingredients) {
      joiner = joiner +
          element.amount +
          ' ' +
          element.unit +
          ' ' +
          element.title +
          '/';
    }
    return joiner.substring(0, joiner.length - 1);
  }
}
