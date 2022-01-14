import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/screens/open_cookbook/recipe_page.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/screens/user/profile_page.dart';
import 'package:flutter/material.dart';
import '../model/recipe_db_object.dart';
import '../model/recipe_object.dart';
import 'create_new_cook_book.dart';
import 'open_cookbook/detail_page.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RecipeDbObject recipeDbObject = RecipeDbObject();
  FavsAndShoppingListDbHelper favsAndShoppingListDbHelper =
      FavsAndShoppingListDbHelper();
  int selectedIndex = 0;
  AuthService authService = AuthService();
  int recipeCount = 0;
  int cookbookCount = 0;
  List<Recipe> plantFoodFactory = [];
  List<Recipe> suggestionRecipes = [];
  List<Cookbook> userCookbooks = [];
  List<Recipe> favs = [];

  @override
  void initState() {
    getCookBooks().then((value) => {setState(() {})});
    getAllPlantFoodFactoryRecipes();
    getUserFavs();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [basicColor, deepOrange])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Hallo, " +
                                    authService
                                        .getUser()
                                        .displayName
                                        .toString(),
                                // .displayName,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: openSansFontFamily),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Was möchtest du heute kochen?",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontFamily: openSansFontFamily),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                          child: CircleAvatar(
                            backgroundImage:
                                authService.getUser().photoURL == null ||
                                        authService.getUser().photoURL == ''
                                    ? const AssetImage('assets/profilePNG.png')
                                    : CachedNetworkImageProvider(
                                        authService.getUser().photoURL,
                                      ),
                            backgroundColor: Colors.white,
                            radius: size.width * 0.09,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage(
                                              recipeCount: recipeCount,
                                              cookBookCount:
                                                  userCookbooks.length,
                                            )));
                              },
                              child: null,
                            ),
                          ),
                        )
                      ],
                    ),
                    TextField(
                        onChanged: (value) {
                          //TODO insert filtered value
                        },
                        showCursor: true,
                        decoration: InputDecoration(
                          hintText: "Nach Rezept suchen",
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black54),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                const Text("Unsere Vorschläge ☺️",
                    style: TextStyle(
                        fontFamily: openSansFontFamily,
                        fontSize: 14,
                        color: Colors.black)),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
            ),
            SizedBox(
              height: size.height * 0.2,
              width: size.width,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: suggestionRecipes.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () => _openRecipeDetailPage(context, index),
                      child: _buildFeaturedItem(
                          image: suggestionRecipes.elementAt(index).image,
                          title: suggestionRecipes.elementAt(index).name,
                          subtitle: '',
                          isSuggestion: true));
                },
              ),
            ),
            // Feed Me Cookbook
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                const Text("Feed Me's Kochbuch 🌿",
                    style: TextStyle(
                        fontFamily: openSansFontFamily,
                        fontSize: 14,
                        color: Colors.black)),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
            ),
            GestureDetector(
                onTap: () => _openDestinationPage(
                    context,
                    plantFoodFactory,
                    Cookbook(
                        'https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/recipe_images%2FRed%20Curry%2F1.png?alt=media&token=bcfdf574-b959-45ff-a251-a171b2969161',
                        'Plant Food Factory',
                        plantFoodFactory),
                    cookbookCount,
                    favs),
                child: _buildFeaturedItem(
                    image:
                        "https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/recipe_images%2FRed%20Curry%2F1.png?alt=media&token=bcfdf574-b959-45ff-a251-a171b2969161",
                    title: "Feed Me's Kochbuch",
                    subtitle: 'Gesund & Lecker',
                    isSuggestion: false)),
            SizedBox(height: size.height * 0.005),
            // User Cookbooks
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                const Text("Meine Kochbücher 🍽",
                    style: TextStyle(
                        fontFamily: openSansFontFamily,
                        fontSize: 14,
                        color: Colors.black)),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
            ),
            GestureDetector(
                onTap: () => _openDestinationPage(context, favs,
                    Cookbook('', 'favorites', favs), cookbookCount, favs),
                child: _buildFavoriteItem(
                    icon: const Icon(Icons.favorite,
                        color: Colors.red, size: 100),
                    title: "Meine Favoriten",
                    subtitle: '',
                    size: size)),
            FutureBuilder<List<Cookbook>>(
              future: getUpdates(),
              builder: (context, AsyncSnapshot<List<Cookbook>> snap) {
                if (snap.data == null) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: basicColor,
                  ));
                }

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snap.data.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => _openDestinationPage(
                              context,
                              snap.data.elementAt(index).recipes,
                              snap.data.elementAt(index),
                              snap.data.length + 1,
                              favs),
                          child: _buildFeaturedItem(
                              image: snap.data.elementAt(index).image == ''
                                  ? 'https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/assets%2Fstandard_cookbook.jpg?alt=media&token=d0347438-e243-47ee-96a9-9287cd451dc3'
                                  : snap.data.elementAt(index).image,
                              title: snap.data.elementAt(index).name,
                              subtitle: "",
                              isSuggestion: false));
                    });
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Kochbuch\nhinzufügen',
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: size.width * 0.1,
            color: basicColor,
          ),
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateNewCookbook()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  _openRecipeDetailPage(BuildContext context, int index) {
    Cookbook cookBook = Cookbook('', 'plant_food_factory', []);
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DetailPage(
                  recipe: suggestionRecipes.elementAt(index),
                  recipeSteps: filterSteps(suggestionRecipes.elementAt(index)),
                  ingredients:
                      filterIngredients(suggestionRecipes.elementAt(index)),
                  favs: favs,
                  fromHome: true,
                  isUserBook: false,
                  cookbook: cookBook,
                )));
  }

  Container _buildFeaturedItem(
      {String image, String title, String subtitle, bool isSuggestion}) {
    return Container(
      padding: const EdgeInsets.only(
          left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
      child: Material(
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: basicColor,
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: !isSuggestion
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      color: Colors.black.withOpacity(0.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: openSansFontFamily)),
                          Text(subtitle,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: openSansFontFamily)),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      color: Colors.black.withOpacity(0.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(title,
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: openSansFontFamily,
                              )),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildFavoriteItem(
      {Icon icon, String title, String subtitle, Size size}) {
    return Container(
      height: size.height * 0.4,
      width: size.width * 0.9,
      padding: const EdgeInsets.only(
          left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
      child: Material(
        color: Colors.white54,
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Stack(
          children: <Widget>[
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Center(child: icon)),
            ),
            Positioned(
                bottom: 20.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  color: Colors.black.withOpacity(0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily)),
                      Text(subtitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: openSansFontFamily)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _openDestinationPage(BuildContext context, List<Recipe> recipes,
      Cookbook cookbook, int cookBookCount, List<Recipe> favs) {
    bool isUserCookbook = true;
    if (cookbook.name == 'Plant Food Factory' || cookbook.name == 'favorites') {
      isUserCookbook = false;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => RecipePage(
                recipes: recipes,
                cookBookCount: cookBookCount - 1,
                recipeCount: recipeCount,
                cookBook: cookbook,
                isUserCookbook: isUserCookbook,
                favs: favs)));
  }

  void getAllPlantFoodFactoryRecipes() async {
    plantFoodFactory = await RecipeDbObject()
        .getRecipesFromPlantFoodFactory("plant_food_factory")
        .elementAt(0);
    getSuggestions();
    setState(() {});
  }

  void getUserFavs() async {
    favs = await favsAndShoppingListDbHelper
        .getRecipesFromUsersFavsCollection()
        .first;
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

  Future<void> getCookBooks() async {
    RecipeDbObject recipeDbObject = RecipeDbObject();
    userCookbooks = await await recipeDbObject.getAllCookBooksFromUser();
    cookbookCount = userCookbooks.length;
    userCookbooks.forEach((element) {
      recipeCount = recipeCount + element.recipes.length;
    });
    setState(() {});
  }

  Future<List<Cookbook>> getUpdates() async {
    RecipeDbObject recipeDbObject = RecipeDbObject();
    List<Cookbook> recipes =
        await await recipeDbObject.getAllCookBooksFromUser();
    recipes.removeWhere((element) => element.image == 'none');
    //setState is needed here. If we give back the recipes object directly the books will not appear instantly
    setState(() {});
    return recipes;
  }

  void getSuggestions() {
    List<int> suggestions = [];
    var random = Random();
    while (suggestions.length < 5) {
      int randomNumber = random.nextInt(plantFoodFactory.length);
      if (!suggestions.contains(randomNumber)) {
        suggestions.add(randomNumber);
      }
    }

    suggestions.forEach((element) {
      suggestionRecipes.add(plantFoodFactory.elementAt(element));
    });
    setState(() {});
  }
}
