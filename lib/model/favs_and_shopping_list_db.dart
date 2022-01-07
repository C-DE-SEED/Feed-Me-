import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/services/auth_service.dart';

class FavsAndShoppingListDbHelper {
  AuthService auth = AuthService();

  Future<void> updateFavs(
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
    // String userNotes
  ) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    await collectionReference
        .doc('favorites')
        .collection("favorites")
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
      //'user_notes' : userNotes
    });
    // Important: Code beneath is needed. If there is no field in the document, firebase will not recognize it as document
    await collectionReference.doc('favorites').set({'name': 'users favorites', 'image': 'none'});
  }

  Stream<List<Recipe>> getRecipesFromUsersFavsCollection() {
    CollectionReference recipesCollection =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    return recipesCollection
        .doc('favorites')
        .collection('favorites')
        .snapshots()
        .map(_recipeListFromSnapshot);
  }

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
        // doc['user_notes'] ?? '',
      );
    }).toList();
    return list;
  }

  void removeRecipesFromFavs(String name) async {
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc('favorites')
        .collection('favorites')
        .get()
        .then((value) => value.docs.forEach((element) {
              if (element.id == name) {
                element.reference.delete();
              }
            }));
  }
}
