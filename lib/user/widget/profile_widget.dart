import 'dart:io';

import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/user/page/image_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key key,
  }) : super(key: key);

  @override
  _ProfileWidget createState() => _ProfileWidget();
}

class _ProfileWidget extends State<ProfileWidget> {
  ImageService imageService = ImageService();

  @override
  Widget build(BuildContext context) {
    File _image;
    String _uploadedFileURL;
    final AuthService _authService = AuthService();
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: getImage(_authService, _image),
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
                    chooseFile(_image, _authService);
                    setState(() {
                      /*widget.user.imagePath = xFile.path;
                      getImage(widget.user);*/

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

  ImageProvider getImage(AuthService auth, File _image) {
    if (auth.getUser().photoURL == null) {
      return const AssetImage('assets/feedmelogo_without_border.png');
    } else {
      return FileImage(File(auth.getUser().photoURL));
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
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot uploadFile = await ref.child('profile_pictures/').putFile(img);
    if (uploadFile.state == TaskState.success) {
      final String downloadUrl = uploadFile.ref.fullPath;
      auth.getUser().updatePhotoURL(downloadUrl);
    }
  }
}
