import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles/colors.dart';
import '../../../constants/styles/text_style.dart';

class IngredientsView extends StatelessWidget {
  final List<String> ingredients;
  final String recipeTime;
  final String recipeDifficulty;

  const IngredientsView(
      {Key key,
      @required this.ingredients,
      @required this.recipeTime,
      @required this.recipeDifficulty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.2, vertical: size.height * 0.035),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.timer,
                size: 25.0,
                color: basicColor,
              ),
              const SizedBox(width: 5.0),
              Text(
                recipeTime + ' min',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: openSansFontFamily,
                ),
              ),
              const Spacer(),
              const Icon(Icons.settings, size: 25.0, color: basicColor),
              const SizedBox(width: 5.0),
              Text(
                recipeDifficulty,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: openSansFontFamily,
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          ListView.builder(
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
        ],
      ),
    );
  }
}
