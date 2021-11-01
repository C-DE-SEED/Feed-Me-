import 'dart:io';
import 'dart:typed_data';

import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key key,
  }) : super(key: key);

  @override
  _ProfileWidget createState() => _ProfileWidget();
}

class _ProfileWidget extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    File _image;

    final AuthService _authService = AuthService();
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: getImage(_authService),
                fit: BoxFit.cover,
                width: size.height * 0.18,
                height: size.height * 0.18,
                child: const InkWell(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(2),
                color: Colors.white60,
                child: IconButton(
                  icon: const Icon(
                    Icons.add_a_photo_outlined,
                    color: BasicGreen,
                    size: 25,
                  ),
                  onPressed: () async {
                    setState(() {
                      chooseFile(_image, _authService);
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider getImage(AuthService auth) {
    if (auth.getUser().photoURL == null) {
      return const AssetImage('assets/feedmelogo_without_border.png');
    } else {
      return NetworkImage(auth.getUser().photoURL);
    }
  }

  Future chooseFile(File _image, AuthService auth) async {
    await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .then((image) {
      setState(() {
        _image = File(image.path);
        uploadFile(_image, auth);
      });
    });
  }

  Future uploadFile(File img, AuthService auth) async {
    String filePath = auth.getUser().uid + '_profile_picture';
    String refChildPath = 'profile_pictures/' + filePath;
    String downloadUrl = '';
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot uploadFile = await ref.child(refChildPath).putFile(img);
    if (uploadFile.state == TaskState.success) {
      Reference refStorage = FirebaseStorage.instance.ref().child(refChildPath);
      downloadUrl = await refStorage.getDownloadURL();
    }
    await auth.getUser().updatePhotoURL(downloadUrl);
    getImage(auth);
    setState(() {});
  }
}
