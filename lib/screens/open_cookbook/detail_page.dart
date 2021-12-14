import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/material.dart';
import 'package:evil_icons_flutter/evil_icons_flutter.dart';

class DetailPage extends StatefulWidget {
  final Recipe recipe;
  final List<String> reciptSteps;
  final List<String> ingredients;

  const DetailPage({Key key, this.recipe, this.reciptSteps, this.ingredients})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //TODO has to be repleaced with recipe.isFavorite
  bool iconOnPressed = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userNotes = FocusNode();
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
                size: 40,
              ),
              onPressed: () {
                //TODO insert share export
                print(widget.reciptSteps);
                print(widget.ingredients);
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
                    tag: widget.recipe.name,
                    // child: Image.network(recipe.image),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.345,
                          width: size.width,
                          child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.recipe.image,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: basicColor,
                          ),
                      ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, size.height * 0.27, 0.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.info_outlined,
                                      size: 40, color: Colors.white),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: TextFormField(
                                            focusNode: userNotes,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: /*widget.recipe.userNotes ??*/ 'Hier hast du Platz für Notizen 📙',
                                            ),
                                            maxLines: 15,
                                            onChanged: (userNotes) {
                                              String notes = userNotes;
                                              //widget.recipe.userNotes = notes;
                                              //TODO: save UserNotes per Recipe (recipe db objekt erweitern)
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }),
                              IconButton(
                                  icon: iconOnPressed
                                      ? const Icon(Icons.favorite_border,
                                      size: 40, color: Colors.white)
                                      : const Icon(Icons.favorite,
                                      size: 40, color: Colors.white),
                                  onPressed: () {
                                    //TODO set Favorite Recipe true
                                    setState(() {
                                      iconOnPressed = !iconOnPressed;
                                    });
                                  }),
                            ],
                          ),
                        )
                      ]
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.005),
                        Text(
                          widget.recipe.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          widget.recipe.shortDescription,
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
                        getStepWidget(widget.reciptSteps),
                        SizedBox(height: size.height * 0.05),
                        Row(
                          children: [
                            Text(
                              'Für ' + widget.recipe.persons + ' Personen',
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
                        widget.recipe.difficulty, size),
                    SizedBox(width: size.width * 0.05),
                    buildCard("Dauer", Icons.alarm, widget.recipe.time + ' min',
                        size),
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
