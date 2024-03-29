import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/model/recipe_object.dart';

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
      String name,
      String origin,
      String persons,
      String shortDescription,
      String time,
      String userNotes,
      String documentName,
      String cookBookHeaderImage) async {
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
      'name': name,
      'origin': origin,
      'persons': persons,
      'short_discription': shortDescription,
      'time': time,
      'user_notes': userNotes
    });
    // Important: Code beneath is needed. If there is no field in the document, firebase will not recognize it as document
    await collectionReference
        .doc(documentName)
        .set({'name': documentName, 'image': cookBookHeaderImage});
  }

  Future<void>  removeCookbook(String name) async {
    //remove collection of recipes first
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
    .snapshots()
    .first
    .then((element) => element.docs.forEach((element) {
      if(element.id == name){
        element.reference.delete();
      }
    }));
    //remove fields of cookbook
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc(name)
        .delete();
  }

  Future<void> removeRecipeFromCookbook(String cookbookName, String recipeName)async{
    await FirebaseFirestore.instance
    .collection(auth.getUser().uid)
        .doc(cookbookName)
        .collection('recipes')
        .get()
        .then((value) => value.docs.forEach((element) {
            if(element.id == recipeName){
              element.reference.delete();
            }
    }));
  }

//  Recipe list from snapshot for plantFoodFactory cooking book
  List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    var list = snapshot.docs.map((doc) {
      return Recipe.withAttributes(
          doc['id'] ?? '',
          doc['category'] ?? '',
          doc['description'] ?? '',
          doc['difficulty'] ?? '',
          doc['image'] ?? '',
          doc['ingredients_and_amount'] ?? '',
          doc['name'] ?? '',
          doc['origin'] ?? '',
          doc['persons'] ?? '',
          doc['short_discription'] ?? '',
          doc['time'] ?? '',
          doc['user_notes'] ?? '');
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
    print('books: $books');
    
    for (int i = 0; i < books.length; i++) {
      var recipesFromUserCookbook =
          getRecipesFromUserCookbook(books.elementAt(i).name);
      recipesFromCookbook = await recipesFromUserCookbook.first;
      books.elementAt(i).recipes = recipesFromCookbook;
    }

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
        .where('image', isNotEqualTo: 'shoppingList')
        .snapshots()
        .map(_cookbookFromSnapshot)
        .first;

    return cookbooks;
  }

  Future<bool> checkIfDocumentExists(String cookbookName) async {
    bool exists;
    var docRef = FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc(cookbookName);

    var documentSnapshot = await docRef.get();
    exists = documentSnapshot.exists;
    return exists;
  }

  Future<String> getCookBookAttributes(String name) async {
    String imagePath = '';
    var cookbooks = FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .snapshots()
        .map(_cookbookFromSnapshot);

    var books = await await cookbooks.first;

    books.forEach((book) {
      if (book.name == name) {
        imagePath = book.image;
      }
    });
    return imagePath;
  }
}
