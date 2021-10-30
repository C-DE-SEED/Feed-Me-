
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPic() async {
    //Get the file from the image picker and store it
    XFile xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    //Create a reference to the location you want to upload to in firebase
      Reference reference = _storage.ref().child("profile_pictures/");
    //Upload the file to firebase;
     UploadTask uploadTask = reference.putFile(File(xFile.path));
    // Waits till the file is uploaded then stores the download url
    TaskSnapshot storageSnapshot = uploadTask.snapshot;
    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    //returns the download url
    return downloadUrl;
  }
}