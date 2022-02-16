import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/screens/registration_and_login/sign_in.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_platform_interface/src/providers/email_auth.dart'
    as emailPv;

class FirebaseDbService {
  AuthService auth = AuthService();

  Future<void> deleteUserAccountWithData(
      BuildContext context, String email, String password) async {
    // delete favorites
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc('favorites')
        .collection('favorites')
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .doc('favorites')
        .delete();

    // delete all UserCookbooks
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .snapshots()
        .first
        .then((element) => element.docs.forEach((element) {
              element.reference.delete();
            }));

    // delete user from firebase auth
    var user = auth.getUser();
    var credentials =
        emailPv.EmailAuthProvider.credential(email: email, password: password);
    var result = await user
        .reauthenticateWithCredential(credentials)
        .onError((error, stackTrace) => showDialog(
              context: context,
              builder: (BuildContext context) {
                return RoundedAlert(
                  title: "Achtung",
                  text:
                      "Dein übergebenes Passwort stimmt nicht mit dem hinterlegten überein!",
                );
              },
            ));
    await result.user.delete().whenComplete(() => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignIn(
                  fromRegistration: false,
                ))));
  }
}
