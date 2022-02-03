import 'package:dotted_border/dotted_border.dart';
import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:feed_me/model/cookbook_db_object.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/recipe_db_object.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
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
  Cookbook cookbook = Cookbook('', '', []);
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
                        autofocus: true,
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
                        await addCookbookToDatabase(cookbook);
                        var userCookbooks = await getUpdates();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                      userCookbooks: userCookbooks,
                                    )));
                      } else {
                        await uploadFile(image, _authService);
                        var userCookbooks = await getUpdates();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                      userCookbooks: userCookbooks,
                                    )));
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

  Future<void> addCookbookToDatabase(Cookbook cookbook) async {
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
              color: Colors.transparent,
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
                                        chooseFile(ImageSource.gallery, size);
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
                                        chooseFile(ImageSource.camera, size);
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
        },
        child: hasImage
            ? null
            : DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(15),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: deepOrange,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_outlined,
                          color: deepOrange, size: 80),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Foto auswählen',
                        style: TextStyle(
                            fontFamily: openSansFontFamily,
                            fontSize: 18,
                            color: deepOrange.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future chooseFile(ImageSource imageSource, Size size) async {
    await ImagePicker.platform
        .pickImage(source: imageSource, imageQuality: 10)
        .then((file) {
      _cropImage(file.path, size);
    });
  }

  Future<void> uploadFile(File img, AuthService auth) async {
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
      await addCookbookToDatabase(cookbook);
    }
  }

  Future<void> _cropImage(String sourcePath, Size size) async {
    var cropAspectRatio = const CropAspectRatio(ratioX: 1.0, ratioY: 1.0);
    File croppedFile = await ImageCropper.cropImage(
        aspectRatio: cropAspectRatio,
        sourcePath: sourcePath,
        /*aspectRatioPresets: Platform.isAndroid
            ? [
                // pre set einstellung für das format der bildauswahl
                //CropAspectRatioPreset.square,
                //CropAspectRatioPreset.ratio3x2,
                //CropAspectRatioPreset.original,
                //CropAspectRatioPreset.ratio4x3,
                //CropAspectRatioPreset.ratio16x9
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],*/
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Bild zuschneiden',
          lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(
          title: 'Bild zuschneiden',
          aspectRatioLockEnabled: false,
          resetAspectRatioEnabled: false,
          aspectRatioLockDimensionSwapEnabled: true,
        ));
    if (croppedFile != null) {
      setState(() {
        image = File(croppedFile.path);
        hasImage = true;
      });
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
