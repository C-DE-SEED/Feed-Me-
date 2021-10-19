import 'package:firebase_auth/firebase_auth.dart';

import 'UserLocal.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//  Create User Object based on Firebase User
  UserLocal _userFromFireBaseUser(User user) {
    return user != null ? UserLocal(uid: user.uid) : null;
  }

//auth change user stream
  Stream<UserLocal> get user {
    return _auth.authStateChanges()
    // .map((FirebaseUser user) => _userFromFireBaseUser(user));   this is the same as the line below
        .map(_userFromFireBaseUser);
  }

//  Sign in anonym
  Future signInAnonym() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign in with mail and pw
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

//register with mail and pw
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }
//Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
