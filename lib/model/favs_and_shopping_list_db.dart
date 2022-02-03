import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/model/shopping_list.dart';
import 'package:feed_me/model/shopping_list_object.dart';
import 'package:feed_me/services/auth_service.dart';

class FavsAndShoppingListDbHelper {
  AuthService auth = AuthService();
  List<ShoppingListObject> ingredients = [];

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
      String userNotes) async {
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
      'user_notes': userNotes
    });
    // Important: Code beneath is needed. If there is no field in the document, firebase will not recognize it as document
    await collectionReference
        .doc('favorites')
        .set({'name': 'users favorites', 'image': 'none'});
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
        doc['user_notes'] ?? '',
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

  // Shopping List part
  Future<void> updateShoppingList(
    String ingredient,
    String isChecked,
    String name,
  ) async {
    if (name.isEmpty) {
      name = 'shoppingListName';
    } else if (name == 'shoppingListName') {
      name = name.substring(16);
    }
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    await collectionReference
        .doc('shoppingList')
        .collection(name)
        .doc(ingredient)
        .set({
      'ingredients': ingredient,
      'isChecked': isChecked,
    });

    // Important: At the moment there is no method to get name of all subcollections. So we add the name of the subcollection to the field 'name'. The field can be read easy and we have all collection names saved.
    await collectionReference.doc('shoppingList').get().then((value) async {
      if (!value.exists) {
        await collectionReference
            .doc('shoppingList')
            .set({'image': 'shoppingList', 'name': name});
      } else {
        String oldName;
        final CollectionReference collectionReference =
            FirebaseFirestore.instance.collection(auth.getUser().uid);
        await collectionReference
            .doc('shoppingList')
            .get()
            .then((value) => {oldName = value['name']});
        if (!oldName.contains(name)) {
          await collectionReference
              .doc('shoppingList')
              .set({'image': 'shoppingList', 'name': oldName + '/' + name});
        }
      }
    });
  }

  Future<List<String>> getCollectionNames() async {
    String fieldValue;
    List<String> names;
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    await collectionReference
        .doc('shoppingList')
        .get()
        .then((value) => {fieldValue = value['name']});

    names = fieldValue.split('/');
    for (int i = 0; i < names.length; i++) {
      if (names.elementAt(i) == '') {
        names.removeAt(i);
      }
    }
    return names;
  }

//get all shoppingListObjects
  Stream<List<ShoppingListObject>> getRecipesFromShoppingListCollection(
      String docName) {
    CollectionReference recipesCollection =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    return recipesCollection
        .doc('shoppingList')
        .collection(docName)
        .snapshots()
        .map(_shoppingListObjectFromSnapshot);
  }

  List<ShoppingListObject> _shoppingListObjectFromSnapshot(
      QuerySnapshot snapshot) {
    var list = snapshot.docs.map((doc) {
      return ShoppingListObject(
        doc['ingredients'] ?? '',
        doc['isChecked'] ?? '',
      );
    }).toList();

    return list;
  }

  void removeRecipeFromShoppingList(String collectionName) async {
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc('shoppingList')
        .collection(collectionName)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    String name;
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    await collectionReference
        .doc('shoppingList')
        .get()
        .then((value) => {name = value['name']});

    //beneath ist needad to change the field which includes all recipe names of the shopping list
    name = name.replaceAll(collectionName, '');
    name = name.replaceAll('//', '');
    if (name.endsWith('/')) {
      name = name.substring(0, name.length - 1);
    }
    if (name.startsWith('/')) {
      name = name.substring(1, name.length);
    }

    if (name == collectionName) {
      removeWholeShoppingList(collectionName);
    }

    await collectionReference
        .doc('shoppingList')
        .set({'image': 'shoppingList', 'name': name});
  }

  void removeWholeShoppingList(String collectionName) async {
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc('shoppingList')
        .collection(collectionName)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc('shoppingList')
        .delete();
  }
}
