import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/recipt_object.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReciptDbObject {
  AuthService auth = AuthService();
  final String objectName;

  ReciptDbObject({this.objectName});

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
        .set({
      'name': documentName,
      'image': image
    });
  }

  Future<List<String>> getCookingBooks() async {
    List<String> books = [];
    // final CollectionReference collectionReference = FirebaseFirestore.instance.collection(auth.getUser().uid);
    await FirebaseFirestore.instance.collection(auth.getUser().uid).get().then((snapshot) => {

        snapshot.docs.forEach((element) {
          books.add(element.id);
        })
    });
    return books;
  }

//  Recipt list from snapshot for plantFoodFactory cooking book
  List<Recipt> _reciptListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Recipt.withAttributes(
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

//  get recipt stream for plantFoddFactory cooking book
  Stream<List<Recipt>> getReciptObject(String objectName) {
    CollectionReference recipesCollection =
        FirebaseFirestore.instance.collection(objectName);
    return recipesCollection.snapshots().map(_reciptListFromSnapshot);
  }
}
