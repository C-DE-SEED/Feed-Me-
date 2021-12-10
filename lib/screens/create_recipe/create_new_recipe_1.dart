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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: size.height*0.9,
              width: size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'steps',
                    child: ShowSteps(
                        colors: step1),
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
                        recipe.name = recipeName;
                        uploadFile(image, _authService);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateNewRecipe_2(
                                    recipe: recipe, cookbook: widget.cookbook)));
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
