import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_local.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Create User Object based on Firebase User
  UserLocal _userFromFireBaseUser(User user) {
    return user != null
        ? UserLocal(uid: user.uid, description: "", books: 0, recipes: 0)
        : null;
  }

// auth change user stream
  Stream<UserLocal> getUserLocal() {
    return _auth
        .authStateChanges()
        // .map((FirebaseUser user) => _userFromFireBaseUser(user));   this is the same as the line below
        .map(_userFromFireBaseUser);
  }


  User getUser() {
    return _auth.currentUser;
  }

  void updateUserPassword(String newPassword) async {
    await _auth.currentUser.updatePassword(newPassword);
  }

  Future<void> deleteUser() async {
    await _auth.currentUser.delete();
  }

// Sign in anonymize
  Future signInAnonymize() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign in with mail and pw
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

// register with mail and pw
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // create a new document for the user with the uid
      User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

// Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }


}
