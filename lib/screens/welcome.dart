import 'dart:async';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/screens/registration_and_login/sign_in.dart';
import 'package:feed_me/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      color: basicColor,
      child: Image.asset(
        "assets/feedMeOrange.gif",
        height: size.height * 1.0,
        width: size.width * 1.0,
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 3, milliseconds: 350);
    return Timer(duration, route);
  }

  route() {
    var auth = FirebaseAuth.instance;
    auth.authStateChanges().listen(
      (user) async {
        if (user != null) {
          var updates = await getUpdates();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        userCookbooks: updates,
                      )));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignIn(
                        fromRegistration: false,
                      )));
        }
      },
    );
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

  @override
  void dispose() {
    super.dispose();
  }
}
