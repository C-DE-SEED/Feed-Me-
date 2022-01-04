import 'dart:io';

import 'package:feed_me/constants/alerts/alert_with_function.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../home.dart';

class CookBookSettings extends StatefulWidget {
  Cookbook cookbook;
  String oldName;
  String oldImage;

  CookBookSettings({Key key, this.cookbook, this.oldName, this.oldImage})
      : super(key: key);

  @override
  _CookBookSettingsState createState() => _CookBookSettingsState();
}

class _CookBookSettingsState extends State<CookBookSettings> {
  File image;
  bool hasImage = false;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: basicColor,
        elevation: 0,
        actions: [
          SizedBox(
            width: size.width * 0.9,
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Colors.deepOrange, size: 40),
                  onPressed: () async {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertWithFunction(
                          title: "❗️Achtung❗",
                          text: "Willst du dein Kochbuch wirklich löschen?️",
                          buttonText: "Ja, bitte",
                          onPressed: (){
                            deleteCookbook(
                                widget.cookbook.name);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const Home()));
                          },
                        );
                      },
                    );

                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return Dialog(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20.0),
                    //         ),
                    //         elevation: 0,
                    //         backgroundColor: Colors.transparent,
                    //         child: Stack(
                    //           children: <Widget>[
                    //             Container(
                    //               padding: const EdgeInsets.only(
                    //                   left: 20,
                    //                   top: 20.0 + 20,
                    //                   right: 20,
                    //                   bottom: 20),
                    //               margin: const EdgeInsets.only(top: 20),
                    //               decoration: BoxDecoration(
                    //                   shape: BoxShape.rectangle,
                    //                   color: Colors.white,
                    //                   borderRadius: BorderRadius.circular(20),
                    //                   boxShadow: const [
                    //                     BoxShadow(
                    //                         color: Colors.black,
                    //                         offset: Offset(0, 10),
                    //                         blurRadius: 10),
                    //                   ]),
                    //               child: Column(
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 children: <Widget>[
                    //                   const Text(
                    //                     'Willst du dein Kochbuch wirklich löschen?',
                    //                     textAlign: TextAlign.center,
                    //                     style: TextStyle(
                    //                         fontFamily: openSansFontFamily,
                    //                         fontSize: 22,
                    //                         fontWeight: FontWeight.w600,
                    //                         color: basicColor),
                    //                   ),
                    //                   const SizedBox(
                    //                     height: 15,
                    //                   ),
                    //                   Align(
                    //                     alignment: Alignment.bottomCenter,
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceEvenly,
                    //                       children: [
                    //                         TextButton(
                    //                             onPressed: () {
                    //                               deleteCookbook(
                    //                                   widget.cookbook.name);
                    //                               Navigator.push(
                    //                                   context,
                    //                                   MaterialPageRoute(
                    //                                       builder: (context) =>
                    //                                           const Home()));
                    //                             },
                    //                             child: const Text(
                    //                               '🗑 Kochbuch löschen',
                    //                               style: TextStyle(
                    //                                   fontFamily:
                    //                                       openSansFontFamily,
                    //                                   fontSize: 18,
                    //                                   fontWeight:
                    //                                       FontWeight.bold,
                    //                                   color: basicColor),
                    //                             )),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             Positioned(
                    //               left: 20,
                    //               right: 20,
                    //               child: CircleAvatar(
                    //                 backgroundColor: Colors.transparent,
                    //                 radius: 20,
                    //                 child: ClipRRect(
                    //                     borderRadius: const BorderRadius.all(
                    //                         Radius.circular(20)),
                    //                     child: Image.asset(
                    //                         "assets/logoHellOrange.png")),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       );







                        // });
                  },
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text("Namen des Kochbuchs ändern:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontFamily: openSansFontFamily)),
                  ),
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
                        decoration: InputDecoration(
                          hintText: widget.cookbook.name,
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: fontSize),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.cookbook.name = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  const Center(
                    child: Text("Titelbild für das Kochbuch ändern:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontFamily: openSansFontFamily)),
                  ),
                  SizedBox(height: size.height * 0.02),
                  photoContainer(size),
                  SizedBox(height: size.height * 0.1),
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(color: deepOrange),
                        color: basicColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () async {
                        await updateCookbook();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      },
                      child: const Text(
                        "Übernehmen",
                        style: TextStyle(
                          color: deepOrange,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  deleteCookbook(String name) {
    RecipeDbObject db = RecipeDbObject();
    db.removeCookbook(name);
  }

  updateCookbook() async {
    if (hasImage == true) {
      await uploadFile(image, _authService);
    }
    if (widget.cookbook.name == null ||
        widget.cookbook.name == '' ||
        widget.cookbook.name.isEmpty == true) {
      setState(() {
        widget.cookbook.name = widget.oldName;
      });
    }
    await deleteCookbook(widget.oldName);
    for (var recipe in widget.cookbook.recipes) {
      await RecipeDbObject().updateRecipe(
          "1",
          recipe.category,
          recipe.description,
          recipe.difficulty,
          recipe.image,
          recipe.ingredientsAndAmount,
          recipe.name,
          recipe.origin,
          recipe.persons,
          recipe.shortDescription,
          recipe.time,
          widget.cookbook.name,
          //recipe.userNotes,
          hasImage ? widget.cookbook.image : widget.oldImage);
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
              borderRadius: BorderRadius.circular(20))
          : BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: () {
          chooseFile();
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

  Future chooseFile() async {
    await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 10)
        .then((file) {
      setState(() {
        image = File(file.path);
        hasImage = true;
      });
    });
  }

  Future<void> uploadFile(File img, AuthService auth) async {
    var user = auth.getUser();
    String refChildPath = '';
    String filePath = user.uid + widget.cookbook.name;
    refChildPath = 'recipe_images_user/' + filePath;
    String downloadUrl = '';
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot uploadFile = await ref.child(refChildPath).putFile(img);
    if (uploadFile.state == TaskState.success) {
      Reference refStorage = FirebaseStorage.instance.ref().child(refChildPath);
      downloadUrl = await refStorage.getDownloadURL();
      widget.cookbook.image = downloadUrl;
    }
  }
}
