import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles/colors.dart';
import '../../../constants/styles/text_style.dart';

class IngredientsView extends StatelessWidget {
  final List<String> ingredients;

  const IngredientsView(
      {Key key,
      @required this.ingredients,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
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
}
