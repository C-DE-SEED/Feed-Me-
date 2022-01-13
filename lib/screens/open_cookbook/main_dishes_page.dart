import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:flutter/material.dart';
import '../../model/recipe_object.dart';
import 'detail_page.dart';

class MainDishesPage extends StatefulWidget {
  final List<Recipe> recipes;
  final List<Recipe> favs;
  final bool isUserBook;
  final Cookbook cookbook;

  const MainDishesPage(
      {Key key, this.recipes, this.favs, this.isUserBook, this.cookbook})
      : super(key: key);

  @override
  State<MainDishesPage> createState() => _MainDishesPageState();
}

class _MainDishesPageState extends State<MainDishesPage> {
  List<String> reciptSteps = [];
  List<String> ingredients = [];

  void filterSteps(Recipe recipe) {
    reciptSteps = recipe.description.split("/");
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
            child: Text('Hauptgerichte',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontFamily: openSansFontFamily)),
          ),
          SizedBox(height: size.height * 0.02),
          TextField(
              onChanged: (value) {
                //TODO insert filtered value
              },
              showCursor: true,
              decoration: InputDecoration(
                hintText: "Nach Gerichten suchen",
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: basicColor,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              )),
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
                                recipeSteps: reciptSteps,
                                favs: widget.favs,
                                fromHome: false,
                                isUserBook: widget.isUserBook,
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
