import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/screens/open_cookbook/recipe_page.dart';
import 'package:feed_me/screens/shopping_list/shopping_list.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/screens/user/profile_page.dart';
import 'package:feed_me/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../constants/alerts/rounded_custom_alert.dart';
import '../model/recipe_db_object.dart';
import '../model/recipe_object.dart';
import 'create_new_cook_book.dart';
import 'open_cookbook/detail_page.dart';

class Home extends StatefulWidget {
  final List<Cookbook> userCookbooks;

  const Home({Key key, @required this.userCookbooks}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RecipeDbObject recipeDbObject = RecipeDbObject();

  int selectedIndex = 0;
  AuthService authService = AuthService();
  int recipeCount = 0;
  int cookbookCount = 0;
  List<Recipe> plantFoodFactory = [];
  List<Recipe> suggestionRecipes = [];
  List<Cookbook> tempCookbooks = [];
  List<Recipe> allRecipes = [];
  List<Recipe> usersFavs = [];
  final textFieldController = TextEditingController();
  String shoppingListFromUser = '';

  final TextEditingController _typeAheadController = TextEditingController();

  @override
  void initState() {
    getAllPlantFoodFactoryRecipes();
    widget.userCookbooks.forEach((element) {
      if (element.name == 'users favorites') {
        for (int i = 0; i < element.recipes.length; i++) {
          usersFavs.insert(i, element.recipes.elementAt(i));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    usersFavs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
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
              const SizedBox(height: 10),
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
                              backgroundImage: authService.getUser().photoURL ==
                                          null ||
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
                                                    widget.userCookbooks.length,
                                              )));
                                },
                                child: null,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: size.width * 0.025),
                          const Icon(Icons.search),
                          SizedBox(width: size.width * 0.025),
                          SizedBox(
                            width: size.width * 0.8,
                            child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                  decoration: const InputDecoration(
                                    hintText: 'Nach Rezept suchen',
                                    hintStyle: TextStyle(
                                        fontFamily: openSansFontFamily,
                                        fontSize: 14,
                                        color: Colors.black),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                  ),
                                  controller: _typeAheadController,
                                ),
                                suggestionsCallback: (pattern) {
                                  return SearchService(
                                          recipes: plantFoodFactory)
                                      .getSuggestions(pattern);
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  _typeAheadController.text = suggestion;
                                  var recipe = findRecipe(suggestion);
                                  Cookbook cookbook = Cookbook('', '', []);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => DetailPage(
                                                recipe: recipe,
                                                recipeSteps:
                                                    filterSteps(recipe),
                                                ingredients:
                                                    filterIngredients(recipe),
                                                favs: usersFavs,
                                                fromHome: true,
                                                isUserCookbook: false,
                                                cookbook: cookbook,
                                              )));
                                }),
                          )
                        ],
                      )
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
                            isSuggestion: true,
                            size: size,
                            isFavorite: false));
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
                      Cookbook('', 'Plant Food Factory', plantFoodFactory),
                      cookbookCount,
                      usersFavs),
                  child: _buildFeaturedItem(
                      image:
                          "https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/recipe_images%2FIndisches%20Tandoori%2F1.png?alt=media&token=3c2179a6-a164-442e-a9b1-d95788792e5b",
                      title: "Feed Me's Kochbuch",
                      subtitle: 'Gesund & Lecker',
                      isSuggestion: false,
                      size: size,
                      isFavorite: false)),
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
              SizedBox(
                height: size.height * 0.4,
                width: size.width * 0.9,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 0.9,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.userCookbooks.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () => _openDestinationPage(
                                      context,
                                      widget.userCookbooks
                                          .elementAt(index)
                                          .recipes,
                                      widget.userCookbooks.elementAt(index),
                                      widget.userCookbooks.length + 1,
                                      usersFavs,
                                    ),
                                child: _buildFeaturedItem(
                                    image: widget.userCookbooks
                                                .elementAt(index)
                                                .image ==
                                            ''
                                        ? 'https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/assets%2Fstandard_cookbook.jpg?alt=media&token=d0347438-e243-47ee-96a9-9287cd451dc3'
                                        : widget.userCookbooks
                                            .elementAt(index)
                                            .image,
                                    title: widget.userCookbooks
                                                .elementAt(index)
                                                .name ==
                                            'users favorites'
                                        ? 'Meine Favoriten'
                                        : widget.userCookbooks
                                            .elementAt(index)
                                            .name,
                                    subtitle: "",
                                    isSuggestion: false,
                                    size: size,
                                    isFavorite: widget.userCookbooks
                                            .elementAt(index)
                                            .name ==
                                        'users favorites'));
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Einkaufsliste\nöffnen',
            backgroundColor: Colors.white,
            //elevation: size.width * 0.1,
            child: Icon(
              Icons.shopping_basket_outlined,
              size: size.width * 0.1,
              color: basicColor,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ShoppingListCheck()));
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
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
                  favs: usersFavs,
                  fromHome: true,
                  isUserCookbook: false,
                  cookbook: cookBook,
                )));
  }

  Container _buildFeaturedItem(
      {String image,
      String title,
      String subtitle,
      bool isSuggestion,
      bool isFavorite,
      Size size}) {
    return isFavorite
        ? Container(
            height: size.height * 0.4,
            width: size.width * 0.8,
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
            child: Material(
              color: Colors.white54,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: const Center(
                            child: Icon(Icons.favorite,
                                color: Colors.red, size: 100))),
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
          )
        : Container(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
            child: title == 'add'
                ? Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.white.withOpacity(0.5),
                    child: SizedBox(
                      height: size.height * 0.4,
                      width: size.width * 0.8,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: size.width * 0.3,
                          color: basicColor,
                        ),
                        tooltip: 'Kochbuch\nhinzufügen',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewCookbook()));
                        },
                      ),
                    ),
                  )
                : Material(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

  _openDestinationPage(BuildContext context, List<Recipe> recipes,
      Cookbook cookbook, int cookBookCount, List<Recipe> favs) {
    bool isUserCookbook = true;
    if (cookbook.name == 'Plant Food Factory' ||
        cookbook.name == 'users favorites') {
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

  Recipe findRecipe(String valueFromTextField) {
    widget.userCookbooks.forEach((cookbook) {
      allRecipes.addAll(cookbook.recipes);
    });
    allRecipes.addAll(plantFoodFactory);

    final recipe = allRecipes.firstWhere(
        (recipe) => recipe.name
            .toLowerCase()
            .contains(valueFromTextField.toLowerCase()), orElse: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return RoundedAlert(
              title: 'Schade 😕',
              text: 'Leider wurde kein Rezept mit diesem Namen gefunden');
        },
      );
      return null;
    });
    allRecipes.clear();
    return recipe;
  }
}
