import 'package:feed_me/constants/alerts/custom_alert.dart';
import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:feed_me/constants/styles/colors.dart';
import '../../model/recipe_object.dart';
import 'create_new_recipe_2.dart';

class CreateNewRecipe_1 extends StatefulWidget {
  Cookbook cookbook;

  CreateNewRecipe_1({Key key, this.cookbook}) : super(key: key);

  @override
  _CreateNewRecipe_1State createState() => _CreateNewRecipe_1State();
}

class _CreateNewRecipe_1State extends State<CreateNewRecipe_1> {
  Recipe recipe = Recipe();
  File image;
  String inputText;
  bool hasImage = false;
  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  String recipeName = '';
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
                  Hero(
                    tag: 'steps',
                    child: ShowSteps(colors: step1),
                  ),
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
                          hintText: 'Rezeptname eingeben',
                          hintStyle: TextStyle(
                              color: Colors.white, fontSize: fontSize),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            recipeName = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  const Center(
                    child: Text("Titelbild für das Rezept festlegen:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontFamily: openSansFontFamily)),
                  ),
                  SizedBox(height: size.height * 0.02),
                  photoContainer(size),
                  const Spacer(),
                  Hero(
                    tag: 'buttonRow',
                    child: ButtonRow(
                      onPressed: () {
                        if (recipeName == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RoundedAlert(
                                title: "❗️Achtung❗",
                                text: "Benne dein Rezept bitte ☺️",
                              );
                            },
                          );
                        } else if(!hasImage){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RoundedAlert(
                                title: "❗️Achtung❗",
                                text: "Vergiss nicht dein Rezept mit einem Bild zu unterstützen ☺️",
                              );
                            },
                          );
                        }
                        else {
                          recipe.name = recipeName;
                          uploadFile(image, _authService);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewRecipe_2(
                                      recipe: recipe,
                                      cookbook: widget.cookbook)));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
    String filePath = user.uid + recipe.name;
    refChildPath = 'recipe_images_user/' + filePath;
    String downloadUrl = '';
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot uploadFile = await ref.child(refChildPath).putFile(img);
    if (uploadFile.state == TaskState.success) {
      Reference refStorage = FirebaseStorage.instance.ref().child(refChildPath);
      downloadUrl = await refStorage.getDownloadURL();
      recipe.image = downloadUrl;
    }
  }
}
