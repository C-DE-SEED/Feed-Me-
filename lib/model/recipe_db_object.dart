import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/material.dart';

import 'cookbook.dart';

class RecipeDbObject {
  AuthService auth = AuthService();
  final String objectName;
  List<Recipe> recipesFromCookbook = [];
  List<Cookbook> finalCookbooks = [];

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

//  Recipt list from snapshot for plantFoodFactory cooking book

  List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    var list = snapshot.docs.map((doc) {
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
    return list;
  }

  Future<List<Cookbook>> _cookbookFromSnapshot(QuerySnapshot snapshot) async {
    List<Cookbook> books = snapshot.docs.map((doc) {
      return Cookbook.fromDatabase(
        doc['image'] ?? '',
        doc['name'] ?? '',
      );
    }).toList();

    var recipesFromUserCookbook = getRecipesFromUserCookbook(books.first.name);
    recipesFromCookbook = await recipesFromUserCookbook.first;
    books.first.recipes = recipesFromCookbook;

    return books;
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

  Future<Future<List<Cookbook>>> getAllCookBooksFromUser() {
    var cookbooks = FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .snapshots()
        .map(_cookbookFromSnapshot);

    return cookbooks.first;
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
}