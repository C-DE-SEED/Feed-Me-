import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/screens/home.dart';
import 'package:feed_me/screens/open_cookbook/detail_page/recipe_steps_view.dart';
import 'package:feed_me/screens/open_cookbook/pdf/pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:evil_icons_flutter/evil_icons_flutter.dart';

import 'detail_page/ingredients_view.dart';

class DetailPage extends StatefulWidget {
  final Recipe recipe;
  final List<String> recipeSteps;
  final List<String> ingredients;
  List<Recipe> favs;
  final bool fromHome;
  final bool isUserBook;
  final Cookbook cookbook;

  DetailPage(
      {Key key,
      this.recipe,
      this.recipeSteps,
      this.ingredients,
      this.favs,
      this.fromHome,
      @required this.isUserBook,
      @required this.cookbook})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.recipe.name,
          style: const TextStyle(fontFamily: openSansFontFamily),
        ),
        foregroundColor: Colors.white,
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
        backgroundColor: basicColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              icon: const Icon(
                EvilIcons.share_apple,
                size: 40,
              ),
              onPressed: () async {
                final pdfFile = await PdfApi.generateRecipePdfView(
                    widget.recipe.category,
                    widget.recipe.description,
                    widget.recipe.difficulty,
                    widget.recipe.image,
                    widget.recipe.ingredientsAndAmount,
                    widget.recipe.name,
                    widget.recipe.origin,
                    widget.recipe.persons,
                    widget.recipe.shortDescription,
                    widget.recipe.time);
                PdfApi.openFile(pdfFile);
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
              backgroundColor: basicColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.345,
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
                          padding:
                              EdgeInsets.fromLTRB(0, size.height * 0.27, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: size.width * 0.02),
                              widget.isUserBook
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.create,
                                        color: Colors.white,
                                        size: 45,
                                      ),
                                      onPressed: () {
                                        //TODO: Add option to change image and name of recipe
                                      })
                                  :
                                  //    SizedBox is needed because null value is not allowed in NestedScrollView
                                  const SizedBox(height: 5),
                              const Spacer(),
                              IconButton(
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
                              SizedBox(width: size.width * 0.02),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              expandedHeight: size.height * 0.407,
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
                unselectedLabelColor: Colors.white,
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
            IngredientsView(
                ingredients: widget.ingredients,
                recipeTime: widget.recipe.time,
                recipeDifficulty: widget.recipe.difficulty, personCount: widget.recipe.persons, origin: widget.recipe.origin,),
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
                child: widget.isUserBook
                    ? TextFormField(
                        focusNode: userNotes,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: widget.recipe.userNotes.isEmpty
                              ? 'Hier hast du Platz für Notizen 📙'
                              : widget.recipe.userNotes,
                        ),
                        maxLines: 15,
                        onChanged: (userNotes) {
                          setState(() {
                            widget.recipe.userNotes = userNotes;
                          });
                        },
                      )
                    : SizedBox(
                        height: size.height * 0.3,
                        width: size.width * 0.5,
                        child: Center(
                            child: widget.recipe.userNotes == 'none'
                                ? const Text(
                                    'Zu diesem Gericht haben wir keine speziellen Tipps für dich ☺️')
                                : Text(widget.recipe.userNotes))),
              );
            },
          ).then((value) async {
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
                widget.cookbook.name,
                widget.recipe.image);
          });
        },
        child:
            const Icon(Icons.note_add_outlined, size: 40, color: Colors.white),
        elevation: 10.0,
        backgroundColor: basicColor,
      ),
    );
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
