import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles/colors.dart';
import '../../../constants/styles/text_style.dart';
import '../../../model/recipe_db_object.dart';
import '../../../model/recipe_object.dart';

class RecipeSteps extends StatefulWidget {
  final List<String> recipeSteps;
  Recipe recipe;
  final String cookbookName;
  final bool isUserBook;

  RecipeSteps(this.recipeSteps, this.recipe, this.isUserBook, this.cookbookName,
      {Key key})
      : super(key: key);

  @override
  State<RecipeSteps> createState() => _RecipeStepsState();
}

class _RecipeStepsState extends State<RecipeSteps> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.2, vertical: size.height * 0.035),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.recipeSteps.length,
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
                              color: deepOrange, shape: BoxShape.circle),
                          child: Center(
                              child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                            child: Text(
                          widget.recipeSteps.elementAt(index),
                          style: const TextStyle(
                            fontFamily: openSansFontFamily,
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        )),
                      ],
                    ),
                  ],
                );
              }),
        ),
        Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Divider(
              color: Colors.deepOrange,
              height: 36,
            )),
        const Text("Notizen 📓️",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: openSansFontFamily,
                fontSize: 14,
                color: Colors.black)),
        Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: const Divider(
              color: Colors.deepOrange,
              height: 36,
            )),
        widget.isUserBook
            ? Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: widget.isUserBook
                        ? 'Deine Notizen 📙'
                        : widget.recipe.userNotes,
                    hintStyle: const TextStyle(
                      fontFamily: openSansFontFamily,
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  maxLines: 15,
                  onChanged: (notes) {
                    setState(() {
                      widget.recipe.userNotes = notes;
                    });
                  },
                  onEditingComplete: () async {
                    await RecipeDbObject().updateRecipe(
                        widget.recipe.userNotes,
                        widget.recipe.category,
                        widget.recipe.description,
                        widget.recipe.difficulty,
                        widget.recipe.image,
                        widget.recipe.ingredientsAndAmount,
                        widget.recipe.name,
                        widget.recipe.origin,
                        widget.recipe.persons,
                        widget.recipe.shortDescription,
                        widget.recipe.time,
                        widget.recipe.userNotes,
                        widget.cookbookName,
                        widget.recipe.image);
                  },
                ),
              )
            : widget.recipe.userNotes == 'none'
                ? const Text(
                    'Zu diesem Gericht haben wir keine speziellen Tipps für dich ☺️',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: openSansFontFamily,
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  )
                : Text(
                    widget.recipe.userNotes,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: openSansFontFamily,
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  )
      ],
    );
  }
}
