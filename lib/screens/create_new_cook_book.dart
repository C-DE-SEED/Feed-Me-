import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/cookbook_db_object.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:feed_me/constants/styles/colors.dart';
import 'home.dart';

class CreateNewCookbook extends StatefulWidget {
  CreateNewCookbook({
    Key key,
  }) : super(key: key);

  @override
  _CreateNewCookbookState createState() => _CreateNewCookbookState();
}

class _CreateNewCookbookState extends State<CreateNewCookbook> {
  File image;
  bool hasImage = false;
  Cookbook cookbook = Cookbook('','',[]);
  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final AuthService _authService = AuthService();
  ImageSource userImageSource;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: size.height * 0.9,
              width: size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: size.height * 0.05),
                  Center(
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: TextFormField(
                        obscureText: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Gib deinem Kochbuch einen Namen:',
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: fontSize),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            String name = value;
                            cookbook.name = name;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  const Center(
                    child: Text("Lege ein Titelbild für dein Kochbuch fest:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontFamily: openSansFontFamily)),
                  ),
                  SizedBox(height: size.height * 0.02),
                  photoContainer(size),
                  const Spacer(),
                  StandardButton(
                    color: Colors.white,
                    text: "Kochbuch anlegen",
                    onPressed: () async {
                      if (cookbook.name == "") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RoundedAlert(
                              title: "❗️Achtung❗",
                              text: "Benne dein Kochbuch bitte ☺️",
                            );
                          },
                        );
                      } else if (!hasImage) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RoundedAlert(
                              title: "❗️Achtung❗",
                              text:
                                  "Vergiss nicht dein Kochbuch mit einem Bild zu unterstützen ☺️",
                            );
                          },
                        );
                      } else {
                        uploadFile(image, _authService);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addCookbookToDatabase(Cookbook cookbook) async {
    CookbookDbObject cookbookDbObject = CookbookDbObject(cookbook.name);
    bool exist = await cookbookDbObject.checkIfDocumentExists(cookbook.name);
    if (exist == false) {
      await cookbookDbObject.updateCookbook(
          cookbook.name, cookbook.image, cookbook.recipes);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return RoundedAlert(
            title: "❗️Achtung❗",
            text: "Der Name für dein Kochbuch existiert schon ☺️",
          );
        },
      );
    }
  }

  Widget photoContainer(Size size) {
    return Container(
      height: size.height * 0.4,
      width: size.width * 0.9,
      decoration: hasImage
          ? BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image.path),
                fit: BoxFit.cover,
              ),
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15))
          : BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: () {
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
                            left: 20, top: 20.0 + 20, right: 20, bottom: 20),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
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
                                  fontFamily: openSansFontFamily,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: basicColor),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        chooseFile(ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        '💾 Gallerie',
                                        style: TextStyle(
                                            fontFamily: openSansFontFamily,
                                            fontSize: 18,
                                            color: basicColor),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        chooseFile(ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        '📸 Kamera',
                                        style: TextStyle(
                                            fontFamily: openSansFontFamily,
                                            fontSize: 18,
                                            color: basicColor),
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
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Image.asset("assets/logoHellOrange.png")),
                        ),
                      ),
                    ],
                  ),
                );
              });
          //chooseFile();
        },
        child: hasImage
            ? null
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt_outlined, color: deepOrange, size: 100)
                ],
              ),
      ),
    );
  }

  Future chooseFile(ImageSource imageSource) async {
    await ImagePicker.platform
        .pickImage(source: imageSource, imageQuality: 10)
        .then((file) {
      setState(() {
        image = File(file.path);
        hasImage = true;
      });
    });
  }

  void uploadFile(File img, AuthService auth) async {
    var user = auth.getUser();
    String refChildPath = '';
    String filePath = user.uid + cookbook.name;
    refChildPath = 'cookbook_title_pictures/' + filePath;
    String downloadUrl = '';
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot uploadFile = await ref.child(refChildPath).putFile(img);
    if (uploadFile.state == TaskState.success) {
      Reference refStorage = FirebaseStorage.instance.ref().child(refChildPath);
      downloadUrl = await refStorage.getDownloadURL();
      cookbook.image = downloadUrl;
      addCookbookToDatabase(cookbook);
    }
  }
}
