import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidget(
      {Key key, @required this.isProfileRoot, @required this.isLoadingState})
      : super(key: key);
  final bool isProfileRoot;
  bool isLoadingState;

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
          Hero(
            tag: 'image',
            child: ClipOval(
              child: getImage(_authService, size),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(2),
                color:
                    widget.isProfileRoot ? Colors.white54 : Colors.transparent,
                child: widget.isLoadingState
                    ? const CircularProgressIndicator(
                        color: basicColor,
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          color: widget.isProfileRoot
                              ? basicColor
                              : Colors.transparent,
                          size: 25,
                        ),
                        onPressed: () async {
                          if (!widget.isProfileRoot == false) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              top: 20.0 + 20,
                                              right: 20,
                                              bottom: 20),
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(0, 10),
                                                    blurRadius: 10),
                                              ]),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text(
                                                'Bild auswählen:',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        openSansFontFamily,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w600,
                                                    color: basicColor),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          chooseFile(
                                                              _image,
                                                              _authService,
                                                              size,
                                                              ImageSource
                                                                  .gallery);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          '💾 Gallerie',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  openSansFontFamily,
                                                              fontSize: 18,
                                                              color:
                                                                  basicColor),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          chooseFile(
                                                              _image,
                                                              _authService,
                                                              size,
                                                              ImageSource
                                                                  .camera);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          '📸 Kamera',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  openSansFontFamily,
                                                              fontSize: 18,
                                                              color:
                                                                  basicColor),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 20,
                                          right: 20,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 20,
                                            child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20)),
                                                child: Image.asset(
                                                    "assets/logoHellOrange.png")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                        }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CachedNetworkImage getImage(AuthService auth, Size size) {
    if (auth.getUser().photoURL == null) {
      var cachedNetworkImage = CachedNetworkImage(
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/assets%2FFeed%20Me!%20Logo%20Kopie.png?alt=media&token=e012a4ee-6f75-4630-81bb-e65b939f6647',
        placeholder: (context, url) => const CircularProgressIndicator(
          color: basicColor,
        ),
        width: size.height * 0.18,
        height: size.height * 0.18,
        fit: BoxFit.cover,
      );
      setState(() {});
      return cachedNetworkImage;
    } else {
      var cachedNetworkImage = CachedNetworkImage(
        imageUrl: auth.getUser().photoURL,
        placeholder: (context, url) => const CircularProgressIndicator(
          color: basicColor,
        ),
        fit: BoxFit.cover,
        width: size.height * 0.18,
        height: size.height * 0.18,
      );
      setState(() {});
      return cachedNetworkImage;
    }
  }

  Future chooseFile(
      File _image, AuthService auth, Size size, ImageSource imageSource) async {
    await ImagePicker.platform
        .pickImage(source: imageSource, imageQuality: 10)
        .then((image) {
      setState(() {
        widget.isLoadingState = true;
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
      getImage(auth, size);
    }
    widget.isLoadingState = false;
  }
}
