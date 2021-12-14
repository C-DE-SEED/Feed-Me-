import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/services/auth_service.dart';

class CookbookDbObject {
  AuthService auth = AuthService();
  final String objectName;

  CookbookDbObject(this.objectName);


  Future<void> updateCookbook(
    String name,
    String image,
      List<Recipe> recipes,
  ) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    await collectionReference.doc(name).set({'name': name, 'image': image, 'recipes':recipes});
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


}
