import 'package:feed_me/constants/buttons/add_image_button.dart';
import 'package:feed_me/constants/animated_text_field_list.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'choose_cookbook.dart';

class CreateNewRecipe extends StatefulWidget {
  const CreateNewRecipe({Key key}) : super(key: key);

  @override
  _CreateNewRecipeState createState() => _CreateNewRecipeState();
}

class _CreateNewRecipeState extends State<CreateNewRecipe> {
  bool hasImage = false;
  File image;
  int ingredients = 1;
  String inputText;
  String recipeName;
  List<String> items = [];
  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BasicGreen,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [ Container(
                  height: size.height * 0.25,
                  width: size.width * 0.91,
                  decoration: hasImage
                      ? BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:  Colors.white54,
                      image: DecorationImage(
                        image: new AssetImage(image.path),
                        fit: BoxFit.cover,
                      ))
                      : BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:  Colors.white54,
                  ),
                  child: !hasImage
                      ? AddImageButton(
                    hasImage: hasImage,
                    onPressed: () async {
                      await chooseFile();
                    },
                  )
                      : null),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(
                      width: 15,
                      color: BasicGreen,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Name des Rezeptes eingeben'),
                    onChanged: (value) {
                      recipeName = value;
                      // authService.getUser().updateDisplayName(value);
                    },
                    //TODO find a way to add external User data
                  ),
                ),
                AnimatedListOnePage(listKey:listKey),],
            ),
          ],
        ),
      ),
      floatingActionButton:
       Row(
          children: [
            SizedBox(width: size.width * 0.09,),
            Expanded(
              child: StandardButton(
                  color: Colors.white,
                  text: "Eingabe speichern",
                  onPressed: () {
                    //TODO: Save recipt
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChooseCookbook()
                          ));
                  }),
            ),
            FloatingActionButton(
              foregroundColor: BasicGreen,
              focusColor: BasicGreen.withOpacity(0.5),
              backgroundColor: Colors.white,
              hoverColor: BasicGreen.withOpacity(0.5),
              splashColor: BasicGreen.withOpacity(0.5),
              child: const Icon(Icons.add),
              onPressed: () {
                listKey.currentState.insertItem(items.length);
                setState(() {});
              },
            ),
          ],
        ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .then((file) {
      setState(() {
        image = File(file.path);
        hasImage = true;
      });
    });
  }

}
