import 'package:firebase_auth/firebase_auth.dart';

class UserLocal {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String uid;
  String description;
  int books;
  int recipes;

  UserLocal({this.uid, this.description, this.books, this.recipes});

  User getFireBaseUser() {
    return _auth.currentUser;
  }

  void setDescription(String newDescription) {
    description = newDescription;
  }

  String getUserName(){
    return _auth.currentUser.displayName;
  }

  String getDescription() {
    return description;
  }

  void setAmountOfBooks(int newAmount) {
    books = newAmount;
  }

  int getAmountOfBooks() {
    return books;
  }

  void setAmountOfRecipes(int newAmount) {
    recipes = newAmount;
  }

  int getAmountOfRecipts() {
    return recipes;
  }

  String getProfilePictureURL(){
    return _auth.currentUser.photoURL;
  }

  void setProfilePictureURL(String downloadUrl) async{
    await _auth.currentUser.updatePhotoURL(downloadUrl);
  }

  String getUserMail(){
    return _auth.currentUser.email;
  }

  String getUID(){
    return uid;
  }

  @override
  String toString() {
    return 'UserLocal{uid: $uid, description: $description, books: $books, recipes: $recipes}';
  }
}
