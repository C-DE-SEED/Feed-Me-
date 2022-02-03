import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_platform_interface/src/providers/email_auth.dart'
    as emailPv;

class FirebaseDbService {
  AuthService auth = AuthService();

  Future<void> deleteUserAccountWithData(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(auth.getUser().uid)
        .snapshots()
        .forEach((element) {
      element.docs.forEach((element) {
        element.reference.delete();
      });
    });

    //remove favorites
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

    Navigator.pop(context);
  }
}
