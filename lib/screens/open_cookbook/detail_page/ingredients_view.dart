import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles/colors.dart';
import '../../../constants/styles/text_style.dart';

class IngredientsView extends StatelessWidget {
  final List<String> ingredients;
  final String recipeTime;
  final String recipeDifficulty;
  final String personCount;
  final String origin;

  const IngredientsView(
      {Key key,
      @required this.ingredients,
      @required this.origin,
      @required this.personCount,
      @required this.recipeTime,
      @required this.recipeDifficulty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 30.0;
    double fontSizeForIcons = 14.0;

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: iconSize,
                color: basicColor,
              ),
              Text(
                personCount,
                style: TextStyle(
                  fontSize: fontSizeForIcons,
                  color: Colors.black,
                  fontFamily: openSansFontFamily,
                ),
              ),
              Icon(
                Icons.flag,
                size: iconSize,
                color: basicColor,
              ),
              Text(
                origin,
                style: TextStyle(
                  fontSize: fontSizeForIcons,
                  color: Colors.black,
                  fontFamily: openSansFontFamily,
                ),
              ),
              Icon(
                Icons.timer,
                size: iconSize,
                color: basicColor,
              ),
              Text(
                recipeTime + ' min',
                style: TextStyle(
                  fontSize: fontSizeForIcons,
                  color: Colors.black,
                  fontFamily: openSansFontFamily,
                ),
              ),
              Icon(Icons.settings, size: iconSize, color: basicColor),
              Text(
                recipeDifficulty,
                style: TextStyle(
                  fontSize: fontSizeForIcons,
                  color: Colors.black,
                  fontFamily: openSansFontFamily,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.2, vertical: size.height * 0.035),
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
}
