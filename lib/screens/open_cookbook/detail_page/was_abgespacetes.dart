import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/screens/home.dart';
import 'package:feed_me/screens/open_cookbook/detail_page/recipe_steps_view.dart';
import 'package:feed_me/screens/open_cookbook/recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:evil_icons_flutter/evil_icons_flutter.dart';

import 'ingredients_view.dart';

class NewDetailPage extends StatefulWidget {
  final Recipe recipe;
  final List<String> recipeSteps;
  final List<String> ingredients;
  List<Recipe> favs;
  bool fromHome;

  NewDetailPage(
      {Key key,
      this.recipe,
      this.recipeSteps,
      this.ingredients,
      this.favs,
      this.fromHome})
      : super(key: key);

  @override
  State<NewDetailPage> createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<NewDetailPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  FocusNode userNotes;
  bool isFav = false;
  FavsAndShoppingListDbHelper favsAndShopping = FavsAndShoppingListDbHelper();

  @override
  void initState() {
    userNotes = FocusNode();
    filterSteps(widget.recipe);
    filterIngredients(widget.recipe);
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    // Set Favorite true when favorite list contains the name of actual recipe
    widget.favs.forEach((element) {
      if (element.name == widget.recipe.name) {
        setState(() {
          isFav = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // "Unmount" the controllers:
    _tabController.dispose();
    _scrollController.dispose();
    userNotes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: basicColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (widget.fromHome) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            } else {
              Navigator.pop(context);
            }
          },
        ),
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
                print(widget.recipeSteps);
                print(widget.ingredients);
              },
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white54,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.32,
                          width: size.width,
                          child: Hero(
                            tag: widget.recipe.name,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.recipe.image,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: basicColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.82, size.height * 0.25, 0.0, 0.0),
                          child: IconButton(
                              icon: !isFav
                                  ? const Icon(Icons.favorite_border,
                                      size: 45, color: Colors.white)
                                  : const Icon(Icons.favorite,
                                      size: 45, color: Colors.white),
                              onPressed: () async {
                                //if it was fav before -> remove from database
                                if (isFav) {
                                  favsAndShopping.removeRecipesFromFavs(
                                      widget.recipe.name);
                                }
                                //if it was no fav before -> add to fav database
                                else {
                                  await favsAndShopping.updateFavs(
                                      widget.recipe.id,
                                      widget.recipe.category,
                                      widget.recipe.description,
                                      widget.recipe.difficulty,
                                      widget.recipe.image,
                                      widget.recipe.ingredientsAndAmount,
                                      widget.recipe.kitchenStuff,
                                      widget.recipe.name,
                                      widget.recipe.origin,
                                      widget.recipe.persons,
                                      widget.recipe.shortDescription,
                                      widget.recipe.spices,
                                      widget.recipe.time);
                                }
                                setState(() {
                                  isFav = !isFav;
                                });
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              expandedHeight: size.height * 0.39,
              pinned: true,
              floating: true,
              elevation: 2.0,
              forceElevated: innerViewIsScrolled,
              bottom: TabBar(
                labelColor: Colors.deepOrange,
                indicatorColor: Colors.deepOrange,
                labelStyle: const TextStyle(
                    fontFamily: openSansFontFamily,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: const TextStyle(
                  fontFamily: openSansFontFamily,
                  fontSize: 16.0,
                ),
                tabs: const <Widget>[
                  Tab(text: "Zutaten"),
                  Tab(text: "Zubereitung"),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            IngredientsView(widget.ingredients),
            RecipeSteps(widget.recipeSteps)
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        },
        child: const Icon(Icons.info_outlined, size: 40, color: Colors.white),
        elevation: 2.0,
        backgroundColor: Colors.deepOrange,
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

  List<String> filterSteps(Recipe recipe) {
    List<String> x = [];
    x = recipe.description.split("/");
    return x;
  }

  List<String> filterIngredients(Recipe recipe) {
    List<String> x = [];
    x = recipe.ingredientsAndAmount.split("/");
    return x;
  }
}
