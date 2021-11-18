
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/recipe_object.dart';


class RecipeDbObject {
  final String uid;
  final String objectName;

  RecipeDbObject({this.uid, this.objectName});

//  Club list from snapshot
  List<Recipe> _recipeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Recipe(
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
          doc['time'] ?? ''
      );
    }).toList();
  }

//  get clubs stream
  Stream<List<Recipe>> getRecipeObject(String objectName) {
    CollectionReference recipeCollection =
    FirebaseFirestore.instance.collection(objectName);
    return recipeCollection.snapshots().map(_recipeListFromSnapshot);
  }
}

