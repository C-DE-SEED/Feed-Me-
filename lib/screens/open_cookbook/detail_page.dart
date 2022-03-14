import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:feed_me/screens/open_cookbook/recipe_settings.dart';
import 'package:flutter/material.dart';
import 'package:evil_icons_flutter/evil_icons_flutter.dart';

import 'detail_page/ingredients_view.dart';

class DetailPage extends StatefulWidget {
  final Recipe recipe;
  final List<String> recipeSteps;
  final List<String> ingredients;
  List<Recipe> favs;
  final bool fromHome;
  final Cookbook cookbook;
  final bool isUserCookbook;

  DetailPage({
    Key key,
    this.recipe,
    this.recipeSteps,
    this.ingredients,
    this.favs,
    this.isUserCookbook,
    this.fromHome,
    @required this.cookbook,
  }) : super(key: key);

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
    double iconSize = 30.0;
    double fontSizeForIcons = 16.0;
    Size size = MediaQuery.of(context).size;
    Color infoRowIconColor = Colors.deepOrange;
    Color infoRowTextColor = Colors.white;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            widget.recipe.name,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            var usercookbooks = await getUpdates();
            if (widget.fromHome) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home(
                            userCookbooks: usercookbooks,
                          )));
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
                              widget.isUserCookbook
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.create,
                                        color: Colors.white,
                                        size: 45,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecipeSettings(
                                                      cookbook: widget.cookbook,
                                                      recipe: widget.recipe,
                                                    )));
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
                                          widget.recipe.name,
                                          widget.recipe.origin,
                                          widget.recipe.persons,
                                          widget.recipe.shortDescription,
                                          widget.recipe.time,
                                          widget.recipe.userNotes);
                                    }
                                    setState(() {
                                      isFav = !isFav;
                                    });
                                  }),
                              SizedBox(width: size.width * 0.02),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.flag,
                              size: iconSize,
                              color: infoRowIconColor,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.recipe.origin,
                              style: TextStyle(
                                fontSize: fontSizeForIcons,
                                color: infoRowTextColor,
                                fontFamily: openSansFontFamily,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: iconSize,
                              color: infoRowIconColor,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.recipe.time + ' min',
                              style: TextStyle(
                                fontSize: fontSizeForIcons,
                                color: infoRowTextColor,
                                fontFamily: openSansFontFamily,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.settings,
                                size: iconSize, color: infoRowIconColor),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.recipe.difficulty,
                              style: TextStyle(
                                fontSize: fontSizeForIcons,
                                color: infoRowTextColor,
                                fontFamily: openSansFontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              expandedHeight: size.height * 0.45,
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
              personCount: widget.recipe.persons,
              unsortedIngredients: widget.recipe.ingredientsAndAmount,
              recipe: widget.recipe,
            ),
            RecipeSteps(widget.recipeSteps, widget.recipe,
                widget.isUserCookbook, widget.cookbook.name),
          ],
          controller: _tabController,
        ),
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

  Future<List<Cookbook>> getUpdates() async {
    RecipeDbObject recipeDbObject = RecipeDbObject();
    FavsAndShoppingListDbHelper favsAndShoppingListDbHelper =
        FavsAndShoppingListDbHelper();

    List<Cookbook> tempCookbooks = [];
    List<Recipe> favs = [];
    favs = await favsAndShoppingListDbHelper
        .getRecipesFromUsersFavsCollection()
        .first;
    List<Cookbook> cookbooksUpdate =
        await await recipeDbObject.getAllCookBooksFromUser();

    cookbooksUpdate.removeWhere((element) =>
        element.image == 'none' || element.image == 'shoppingList');
    // FIXME check in database why this additional cookbook is inserted
    // remove additional Plant Food Factory Cookbook
    cookbooksUpdate
        .removeWhere((element) => element.name == 'Plant Food Factory');
    cookbooksUpdate
        .removeWhere((element) => element.name == 'plant_food_factory');

    tempCookbooks.addAll(cookbooksUpdate);
    cookbooksUpdate.clear();

    cookbooksUpdate.add(Cookbook('', 'users favorites', favs));
    cookbooksUpdate.addAll(tempCookbooks);
    cookbooksUpdate.add(Cookbook('', 'add', []));

    //setState is needed here. If we give back the recipes object directly the books will not appear instantly
    setState(() {});
    return cookbooksUpdate;
  }
}
