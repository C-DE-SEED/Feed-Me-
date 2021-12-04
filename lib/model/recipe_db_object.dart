import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/material.dart';

import 'cookbook.dart';

class RecipeDbObject {
  AuthService auth = AuthService();
  final String objectName;

  RecipeDbObject({this.objectName});

  Future<void> updateRecipe(
      String id,
      String category,
      String description,
      String difficulty,
      String image,
      String ingredientsAndAmount,
      String kitchenUtensils,
      String name,
      String origin,
      String persons,
      String shortDescription,
      String spices,
      String time,
      String documentName) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    await collectionReference
        .doc(documentName)
        .collection("recipes")
        .doc(name)
        .set({
      'id': id,
      'category': category,
      'description': description,
      'difficulty': difficulty,
      'image': image,
      'ingredients_and_amount': ingredientsAndAmount,
      'kitchen_utensils': kitchenUtensils,
      'name': name,
      'origin': origin,
      'persons': persons,
      'short_discription': shortDescription,
      'spices': spices,
      'time': time
    });
    // Important: Code beneath is needed. If there is no field in the document, firebase will not recognize it as document
    await collectionReference
        .doc(documentName)
        .set({'name': documentName, 'image': image});
  }

/*  getCookbooksFromFirebaseDb() async {
    List<String> cookBookNames = await getCookBookNames();
    List<Cookbook> cookBooks = [];

    cookBookNames.forEach((element) async {
      getCookBookObject(element);
    });
  }*/

//  Recipt list from snapshot for plantFoodFactory cooking book

  List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Recipe.withAttributes(
          doc['id'] ?? '',
          doc['category'] ?? '',
          doc['description'] ?? '',
          doc['difficulty'] ?? '',
          doc['image'] ?? '',
          doc['ingredients_and_amount'] ?? '',
          doc['kitchen_utensils'] ?? '',
          doc['name'] ?? '',
          doc['origin'] ?? '',
          doc['persons'] ?? '',
          doc['short_discription'] ?? '',
          doc['spices'] ?? '',
          doc['time'] ?? '');
    }).toList();
  }

  List<Cookbook> _cookbookFromSnapshot(QuerySnapshot snapshot) {
    List<Cookbook> cookBooks = [];
    List<Future<Cookbook>> futureCookbook =  snapshot.docs.map((doc) async {
      var cookbook =
          Cookbook.fromDatabase(doc['image'] ?? '', doc['name'] ?? '');
      await getRecipesFromUserCookbook(cookbook.name).first.then((value) => cookbook.recipes = value);
      return cookbook;
    }).toList();

    for (var cookBook in futureCookbook) {
      cookBook.then(
              (value) => {
                print(value);
              }
      );
    }
    print(cookBooks);
    return cookBooks;
  }

  Stream<List<Recipe>> getRecipesFromPlantFoodFactory(String objectName) {
    CollectionReference recipesCollection =
        FirebaseFirestore.instance.collection(objectName);
    return recipesCollection.snapshots().map(_recipeListFromSnapshot);
  }

  Stream<List<Recipe>> getRecipesFromUserCookbook(String docName) {
    CollectionReference recipesCollection =
        FirebaseFirestore.instance.collection(auth.getUser().uid);

    return recipesCollection
        .doc(docName)
        .collection('recipes')
        .snapshots()
        .map(_recipeListFromSnapshot);
  }

  List<Cookbook> getAllCookBooksFromUser() {
    List<Cookbook> finalCookbooks = [];
    var cookbooks = FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .snapshots()
        .map(_cookbookFromSnapshot);

    cookbooks.first.then((value) => print(value));
    return finalCookbooks;

    // cookbooks.first.then((futureCookbookList) =>
    //     futureCookbookList.forEach((futureCookbook) async {
    //       Cookbook cookbook = await futureCookbook;
    //       finalCookbooks.add(cookbook);
    //     }));
    // return finalCookbooks;
  }

  Future<List<String>> getCookBookNames() async {
    List<String> books = [];
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .get()
        .then((snapshot) => {
              snapshot.docs.forEach((element) {
                books.add(element.id);
              })
            });
    return books;
  }

/*  Stream<List<Cookbook>> getCookBookObject(String objectName) {
    CollectionReference recipesCollection =
        FirebaseFirestore.instance.collection(objectName);
    return recipesCollection.snapshots().map(_cookBookListFromSnapshot);
  }*/
}
