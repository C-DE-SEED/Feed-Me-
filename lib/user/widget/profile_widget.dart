import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key key, @required this.isProfileRoot})
      : super(key: key);
  final bool isProfileRoot;

  @override
  _ProfileWidget createState() => _ProfileWidget();
}

class _ProfileWidget extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    File _image;

    final AuthService _authService = AuthService();
    Size size = MediaQuery.of(context).size;
    ModalRoute.of(context).settings.name;
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: getImage(_authService, size),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(2),
                color:
                    widget.isProfileRoot ? Colors.white54 : Colors.transparent,
                child: getStateWidget(_image, _authService, size),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getStateWidget(File _image, AuthService authService, Size size) {
    return IconButton(
        icon: Icon(
          Icons.add_a_photo_outlined,
          color: widget.isProfileRoot ? basicColor : Colors.transparent,
          size: 25,
        ),
        onPressed: () async {
          if (!widget.isProfileRoot == false) {
            chooseFile(_image, authService, size);
          }
        });
  }

  CachedNetworkImage getImage(AuthService auth, Size size) {
    setState(() {});
    if (auth.getUser().photoURL == null) {
      return CachedNetworkImage(
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/assets%2FFeed%20Me!%20Logo%20Kopie.png?alt=media&token=e012a4ee-6f75-4630-81bb-e65b939f6647',
        placeholder: (context, url) => const CircularProgressIndicator(
          color: basicColor,
        ),
        width: size.height * 0.18,
        height: size.height * 0.18,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: auth.getUser().photoURL,
        placeholder: (context, url) => const CircularProgressIndicator(
          color: basicColor,
        ),
        fit: BoxFit.cover,
        width: size.height * 0.18,
        height: size.height * 0.18,
      );
    }
  }

  Future chooseFile(File _image, AuthService auth, Size size) async {
    await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .then((image) {
      setState(() {
        _image = File(image.path);
        uploadFile(_image, auth, size);
      });
    });
  }

  Future uploadFile(File img, AuthService auth, Size size) async {
    var user = auth.getUser();
    String filePath = user.uid + '_profile_picture';
    String refChildPath = 'profile_pictures/' + filePath;
    String downloadUrl = '';
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot uploadFile = await ref.child(refChildPath).putFile(img);
    if (uploadFile.state == TaskState.success) {
      Reference refStorage = FirebaseStorage.instance.ref().child(refChildPath);
      downloadUrl = await refStorage.getDownloadURL();
      await user.updatePhotoURL(downloadUrl);
    }
    getImage(auth, size);
  }
}
