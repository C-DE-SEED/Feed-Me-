import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles/colors.dart';
import '../../../constants/styles/text_style.dart';

class RecipeSteps extends StatelessWidget {
  final List<String> recipeSteps;

  RecipeSteps(this.recipeSteps);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: size.height *0.035),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: recipeSteps.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                          color: deepOrange,
                          shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style:
                            const TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                        child: Text(
                          recipeSteps.elementAt(index),
                          style: const TextStyle(
                            fontFamily: openSansFontFamily,
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ))
                  ],
                ),
                const SizedBox(height: 20)
              ],
            );
          }),
    );
  }
}