import 'package:feed_me/model/recipe_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/services/auth_service.dart';

class Cookbook {
  String _image;
  String _name;
  List<Recipe> _recipes;
  AuthService auth = AuthService();

  Cookbook(this._image, this._name, this._recipes);

  Cookbook.fromDatabase(
    this._image,
    this._name,
  );

  String get image => _image;

  set image(String value) {
    _image = value;
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

  Future<void> addCookbookToDb(
      String documentName, String cookBookHeaderImage) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(auth.getUser().uid);
    // Important: Code beneath is needed. If there is no field in the document, firebase will not recognize it as document
    await collectionReference
        .doc(documentName)
        .set({'name': documentName, 'image': cookBookHeaderImage});
  }

  @override
  String toString() {
    return 'Cookbook{image: $_image, name: $_name, recipes: $_recipes}';
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<Recipe> get recipes => _recipes;

  set recipes(List<Recipe> value) {
    _recipes = value;
  }
}
