import 'dart:io';

import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/user/model/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  final User user;

  const ProfileWidget({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _ProfileWidget createState() => _ProfileWidget();
}

class _ProfileWidget extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    String imagePath = '';
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: getImage(widget.user),
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
                    var xFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1800,
                      maxHeight: 1800,
                    );
                    setState(() {
                      widget.user.imagePath = xFile.path;
                      getImage(widget.user);
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

  ImageProvider getImage(User user) {
    if (user.imagePath.isEmpty) {
      return const AssetImage('assets/feedmelogo.png');
    } else {
      return FileImage(File(user.imagePath));
    }
  }
}
