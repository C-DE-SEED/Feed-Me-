import 'package:flutter/material.dart';

import '../../../constants/styles/colors.dart';
import '../../../constants/styles/text_style.dart';

class IngredientsView extends StatelessWidget {
  final List<String> ingredients;
  final String unsortedIngredients;
  final String personCount;

  const IngredientsView(
      {Key key,
      @required this.ingredients,
      @required this.personCount,
      @required this.unsortedIngredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> newIngredients = [];
    Size size = MediaQuery.of(context).size;
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
                    personCount,
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
                        List<String> list = increasedIngredients();
                        //TODO add increase Ingredients Function
                      },
                      icon: const Icon(Icons.add,
                          size: 30, color: Colors.deepOrange)),
                  IconButton(
                      onPressed: () {
                        //TODO add decrease Ingredients Function
                      },
                      icon: const Icon(Icons.remove,
                          size: 30, color: Colors.deepOrange)),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.2, vertical: size.height * 0.025),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: ingredients.length,
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
                            ingredients.elementAt(index),
                            style: const TextStyle(
                              fontFamily: openSansFontFamily,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ))
                        ],
                      ),
                      const SizedBox(height: 10)
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  List<String> increasedIngredients() {
    List<String> x = [];

    RegExp regExp = RegExp(r'^([0-9]|[1-9][0-9]|[1-9][0-9][0-9])$');
    ingredients.forEach((element) {
      var st = regExp.matchAsPrefix(element).toString();
      print('st output: $st');
    });
    print(ingredients);
    return x;
  }
}
