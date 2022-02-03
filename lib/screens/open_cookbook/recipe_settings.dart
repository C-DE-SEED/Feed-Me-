import 'dart:io';

import 'package:feed_me/constants/alerts/alert_with_function.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../home.dart';

class RecipeSettings extends StatefulWidget {
  final Cookbook cookbook;
  final Recipe recipe;

  const RecipeSettings({Key key, this.cookbook, this.recipe}) : super(key: key);

  @override
  _RecipeSettingsState createState() => _RecipeSettingsState();
}

class _RecipeSettingsState extends State<RecipeSettings> {
  String oldName;
  String oldImage;
  File image;
  bool hasImage = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    oldName = widget.recipe.name;
    oldImage = widget.recipe.image;
    super.initState();
  }

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
                          text: "Willst du dein Rezept wirklich löschen?️",
                          buttonText: "Ja, bitte",
                          onPressed: () async {
                            await deleteRecipe(widget.cookbook.name, oldName);
                            var userCookbooks = await getUpdates();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                          userCookbooks: userCookbooks,
                                        )));
                          },
                        );
                      },
                    );
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
                    child: Text("Namen des Rezepts ändern:",
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
                          hintText: widget.recipe.name,
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: fontSize),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            widget.recipe.name = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  const Center(
                    child: Text("Titelbild des Rezepts ändern:",
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
                        await updateRecipe();
                        var userCookbooks = await getUpdates();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home(userCookbooks: userCookbooks)));
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

  Future<void> deleteRecipe(String cookbookName, String recipeName) async {
    RecipeDbObject db = RecipeDbObject();
    await db.removeRecipeFromCookbook(cookbookName, recipeName);
  }

  updateRecipe() async {
    if (hasImage == true) {
      await uploadFile(image, _authService);
    }
    if (widget.recipe.name == null || widget.recipe.name.isEmpty) {
      setState(() {
        widget.recipe.name = oldName;
      });
    }
    await deleteRecipe(widget.cookbook.name, oldName);
    print(widget.recipe);
    print('name : ' + widget.cookbook.name);
    await RecipeDbObject().updateRecipe(
        "1",
        widget.recipe.category,
        widget.recipe.description,
        widget.recipe.difficulty,
        widget.recipe.image,
        widget.recipe.ingredientsAndAmount,
        widget.recipe.name,
        widget.recipe.origin,
        widget.recipe.persons,
        widget.recipe.shortDescription,
        widget.recipe.time,
        widget.recipe.userNotes,
        widget.cookbook.name,
        widget.cookbook.image);
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
    String filePath = user.uid + widget.recipe.name;
    refChildPath = 'recipe_images_user/' + filePath;
    String downloadUrl = '';
    Reference ref = FirebaseStorage.instance.ref();
    TaskSnapshot uploadFile = await ref.child(refChildPath).putFile(img);
    if (uploadFile.state == TaskState.success) {
      Reference refStorage = FirebaseStorage.instance.ref().child(refChildPath);
      downloadUrl = await refStorage.getDownloadURL();
      widget.recipe.image = downloadUrl;
    }
  }

  Future<List<Cookbook>> getUpdates() async {
    RecipeDbObject recipeDbObject = RecipeDbObject();
    FavsAndShoppingListDbHelper favsAndShoppingListDbHelper =
        FavsAndShoppingListDbHelper();

    List<Cookbook> tempCookbooks = [];
    List<Recipe> favs = [];
    favs = await favsAndShoppingListDbHelper
        .getRecipesFromUsersFavsCollection()
        .first;
    List<Cookbook> cookbooksUpdate =
        await await recipeDbObject.getAllCookBooksFromUser();

    cookbooksUpdate.removeWhere((element) =>
        element.image == 'none' || element.image == 'shoppingList');
    // FIXME check in database why this additional cookbook is inserted
    // remove additional Plant Food Factory Cookbook
    cookbooksUpdate
        .removeWhere((element) => element.name == 'Plant Food Factory');
    cookbooksUpdate
        .removeWhere((element) => element.name == 'plant_food_factory');

    tempCookbooks.addAll(cookbooksUpdate);
    cookbooksUpdate.clear();

    cookbooksUpdate.add(Cookbook('', 'users favorites', favs));
    cookbooksUpdate.addAll(tempCookbooks);
    cookbooksUpdate.add(Cookbook('', 'add', []));

    //setState is needed here. If we give back the recipes object directly the books will not appear instantly
    setState(() {});
    return cookbooksUpdate;
  }
}
