import 'package:feed_me/constants/alerts/alert_with_function.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/model/shopping_list_object.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles/colors.dart';
import '../../../constants/styles/text_style.dart';

class IngredientsView extends StatefulWidget {
  final List<String> ingredients;
  final String unsortedIngredients;
  final String personCount;
  final Recipe recipe;

  const IngredientsView(
      {Key key,
      @required this.ingredients,
      @required this.personCount,
      @required this.unsortedIngredients,
      @required this.recipe})
      : super(key: key);

  @override
  State<IngredientsView> createState() => _IngredientsViewState();
}

class _IngredientsViewState extends State<IngredientsView> {
  List<double> ingredientAmounts = [];
  int standardPersonAmount;
  int newPersonAmount;

  @override
  void initState() {
    addExtractedValues();
    standardPersonAmount = int.parse(widget.recipe.persons);
    newPersonAmount = int.parse(widget.recipe.persons);
    super.initState();
  }

  @override
  void dispose() {
    ingredientAmounts.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FavsAndShoppingListDbHelper favsAndShopping = FavsAndShoppingListDbHelper();
    int.parse(widget.recipe.persons);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 35.0,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    'Anzahl der Personen: ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    newPersonAmount.toString(),
                    style: const TextStyle(
                        fontSize: 21.0,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (newPersonAmount < 12) {
                          newPersonAmount = newPersonAmount + 1;
                          changePersons(standardPersonAmount, newPersonAmount);
                        }
                      },
                      icon: const Icon(Icons.add,
                          size: 30, color: Colors.deepOrange)),
                  IconButton(
                      onPressed: () {
                        if (newPersonAmount > 1) {
                          newPersonAmount = newPersonAmount - 1;
                          changePersons(standardPersonAmount, newPersonAmount);
                        }
                      },
                      icon: const Icon(Icons.remove,
                          size: 30, color: Colors.deepOrange)),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: size.height * 0.025),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.ingredients.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                color: deepOrange, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                              child: Text(
                                widget.ingredients.elementAt(index),
                                style: const TextStyle(
                                  fontFamily: openSansFontFamily,
                                  color: Colors.black,
                                  fontSize: 17.0,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  );
                }),
          ),
          StandardButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertWithFunction(
                    title: "",
                    text:
                        "Willst du das Rezept wirklich zu deiner Einkaugsliste hinzufügen?️",
                    buttonText: "Ja, bitte",
                    onPressed: () {
                      Navigator.pop(context);
                      getAsShoppingListObjects().forEach((element) async {
                        await favsAndShopping.updateShoppingList(
                            element.ingredient,
                            element.isChecked,
                            widget.recipe.name);
                      });
                    },
                  );
                },
              );
            },
            color: basicColor,
            text: 'Zur Einkausliste hinzufügen',
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  List<ShoppingListObject> getAsShoppingListObjects() {
    List<ShoppingListObject> shoppingList = [];
    widget.ingredients.forEach((element) {
      shoppingList.add(ShoppingListObject(element, '0'));
    });
    return shoppingList;
  }

  void changePersons(int standard, int newAmountofPersons) {
    String fullString = "";
    String newString = "";
    double newAmount;
    for (int i = 0; i < widget.ingredients.length; i++) {
      fullString = widget.ingredients.elementAt(i);
      newString =
          widget.ingredients.elementAt(i).replaceAll(RegExp(r'[^0-9,.]'), '');
      if (newString != '') {
        newAmount = calculateAmount(
            standard, newAmountofPersons, ingredientAmounts.elementAt(i));
        fullString = fullString.replaceAll(RegExp(r'[^a-zA-Z,üÜ,äÄ,öÖ, ]'), '');

        widget.ingredients[i] = newAmount.toStringAsFixed(2) + fullString;
      }
    }
    setState(() {});
  }

  double calculateAmount(int standard, int newAmountofPersons, double amount) {
    return ((newAmountofPersons * amount) / standard);
  }

  void addExtractedValues() {
    widget.ingredients.forEach((element) {
      element = element.replaceAll(RegExp(r'[^0-9,.]'), '');
      if (element != '') {
        ingredientAmounts.add(double.parse(element));
      } else {
        ingredientAmounts.add(0);
      }
    });
  }
}
