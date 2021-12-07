import 'dart:io';

import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../home.dart';

class CookBookSettings extends StatefulWidget {
  Cookbook cookbook;

  CookBookSettings({Key key, this.cookbook}) : super(key: key);

  @override
  _CookBookSettingsState createState() => _CookBookSettingsState();
}

class _CookBookSettingsState extends State<CookBookSettings> {
  File image;
  String inputText;
  bool hasImage = false;
  String recipeName = '';
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              deleteCookbook();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            icon: const Icon(Icons.delete),
            color: deepOrange,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const Text("Titelbild für das Rezept ändern:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontFamily: openSansFontFamily)),
              SizedBox(height: size.height * 0.02),
              photoContainer(size),
              SizedBox(height: size.height * 0.1),
              TextButton(
                onPressed: () {
                  updateCookbook();
                },
                child: const Text("Übernehmen"),
              )
            ],
          ),
        ),
      ),
    );
  }

  deleteCookbook() {
    RecipeDbObject db = RecipeDbObject();
    db.removeCookbook(widget.cookbook.name);
  }

  updateCookbook() async {
    RecipeDbObject db = RecipeDbObject();
    db.removeCookbook(widget.cookbook.name);
    widget.cookbook.recipes.forEach((recipe) {
      db.updateRecipe(
          "1",
          recipe.category,
          recipe.description,
          recipe.difficulty,
          recipe.image,
          recipe.ingredientsAndAmount,
          '',
          recipe.name,
          recipe.origin,
          recipe.persons,
          recipe.shortDescription,
          '',
          recipe.time,
          widget.cookbook.name,
          recipe.image);
    });
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

  void uploadFile(File img, AuthService auth) async {
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
