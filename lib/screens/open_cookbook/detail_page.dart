import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/material.dart';
import 'package:evil_icons_flutter/evil_icons_flutter.dart';

class DetailPage extends StatelessWidget {
  final Recipe recipe;
  final List<String> reciptSteps;
  final List<String> ingredients;

  const DetailPage({Key key, this.recipe, this.reciptSteps, this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: basicColor,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              icon: const Icon(
                EvilIcons.share_apple,
                size: 35,
              ),
              onPressed: () {
                print(reciptSteps);
                print(ingredients);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: recipe.name,
                    // child: Image.network(recipe.image),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: basicColor,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.005),
                        Text(
                          recipe.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          recipe.shortDescription,
                          style: const TextStyle(
                            fontFamily: openSansFontFamily,
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        const Text(
                          "Zutaten:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        getIngredientsWidget(),
                        const Text(
                          "Schritte:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        getStepWidget(reciptSteps),
                        SizedBox(height: size.height * 0.05),
                        Row(
                          children: [
                            Text(
                              'Für ' + recipe.persons + ' Personen',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: openSansFontFamily,
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      // TODO insert person counter
                                      setState() {}
                                    }),
                                IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      // TODO insert person counter
                                      setState() {}
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //TODO insert additonal data
                    buildCard("Schwierigkeit", Icons.settings,
                        recipe.difficulty, size),
                    SizedBox(width: size.width * 0.05),
                    buildCard("Dauer", Icons.alarm, recipe.time + ' min', size),
                    SizedBox(width: size.width * 0.05),
                    buildCard("Kalorien", Icons.align_vertical_bottom_outlined,
                        "100 kcal", size),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, IconData icon, String data, Size size) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 25),
        SizedBox(height: size.height * 0.01),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: openSansFontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          data,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: openSansFontFamily,
          ),
        )
      ],
    );
  }

  Widget getStepWidget(List<String> reciptSteps) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: reciptSteps.length,
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
                    reciptSteps.elementAt(index),
                    style: const TextStyle(
                      fontFamily: openSansFontFamily,
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 20)
            ],
          );
        });
  }

  Widget getIngredientsWidget() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
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
                      fontSize: 15.0,
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 10)
            ],
          );
        });
  }
}
