import 'package:cloud_firestore/cloud_firestore.dart';

import 'cooking_book_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

//  collection reference
  final CollectionReference cookingBookCollection =
      FirebaseFirestore.instance.collection("cooking_books");

  Future updateUserData(String name) async {
    return await cookingBookCollection.doc(uid).set({
      'name': name,
    });
  }

  // Cooking Book list from snapshot
  List<CookingBookModel> _clubListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CookingBookModel(
        name: doc['name'] ?? '',
      );
    }).toList();
  }

//  get clubs stream
  Stream<List<CookingBookModel>> get cookingBooks {
    return cookingBookCollection.snapshots().map(_clubListFromSnapshot);
  }
}
