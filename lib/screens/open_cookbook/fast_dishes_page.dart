import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/material.dart';
import '../../model/recipe_object.dart';
import 'detail_page.dart';

class FastDishesPage extends StatefulWidget {
  final List<Recipe> recipes;
  final List<Recipe> favs;
  final bool isUserBook;
  final Cookbook cookbook;

  const FastDishesPage(
      {Key key, this.recipes, this.favs, this.isUserBook, this.cookbook})
      : super(key: key);

  @override
  State<FastDishesPage> createState() => _FastDishesPageState();
}

class _FastDishesPageState extends State<FastDishesPage> {
  List<String> recipeSteps = [];
  List<String> ingredients = [];

  void filterSteps(Recipe recipe) {
    recipeSteps = recipe.description.split("/");
  }

  void filterIngredients(Recipe recipe) {
    ingredients = recipe.ingredientsAndAmount.split("/");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.08),
          const Center(
            child: Text('Schnelle Gerichte',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontFamily: openSansFontFamily)),
          ),
          SizedBox(height: size.height * 0.02),
          Expanded(
            child: widget.recipes.isEmpty
                ? const Center(
                    child: Text(
                    "Dieser Abschnitt ist leer",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: openSansFontFamily,
                    ),
                  ))
                : ListView.builder(
                    itemCount: widget.recipes.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          filterSteps(widget.recipes[index]);
                          filterIngredients(widget.recipes[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(
                                recipe: widget.recipes[index],
                                ingredients: ingredients,
                                recipeSteps: recipeSteps,
                                fromHome: false,
                                favs: widget.favs,
                                isUserCookbook: widget.isUserBook,
                                cookbook: widget.cookbook,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: widget.recipes[index].name,
                              child: CachedNetworkImage(
                                imageUrl: widget.recipes[index].image,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: basicColor,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              widget.recipes[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: openSansFontFamily,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              widget.recipes[index].shortDescription,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: openSansFontFamily,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            const SizedBox(height: 30),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
