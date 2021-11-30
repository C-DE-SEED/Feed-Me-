import 'package:feed_me/constants/animated_text_field_list.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/show_steps_widget.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'create_new_recipt_2.dart';

class CreateNewRecipe_1 extends StatefulWidget {
  const CreateNewRecipe_1({Key key}) : super(key: key);

  @override
  _CreateNewRecipe_1State createState() => _CreateNewRecipe_1State();
}

class _CreateNewRecipe_1State extends State<CreateNewRecipe_1> {
  File image;
  String inputText;
  List<String> items = [];
  bool hasImage = false;
  List<Color> colors = [
    Colors.green,
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
  ];
  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String reciptName = '';
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowSteps(
                  colors: colors,
                  step:
                      "1.Schritt: Rezeptnamen und  Bild des fertigen Gerichtes festlegen"),
              SizedBox(height: size.height * 0.05),
              Center(
                child: SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    obscureText: false,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Rezeptname eingeben',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        reciptName = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              const Text("Titelbild für das Rezept festlegen:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: openSansFontFamily)),
              SizedBox(height: size.height * 0.02),
              photoContainer(size),
              SizedBox(height: size.height * 0.1),
              buttonRow(size)
            ],
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
                children:  const [
                  Icon(Icons.camera_alt_outlined, color: DeepOrange, size: 100)
                ],
              ),
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

  Widget buttonRow(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height*0.08,
          width: size.width*0.4,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20)),

          child: TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Zurück",style: TextStyle(
              color: DeepOrange,
              fontSize: 18.0,
            ),),
          ),
        ),
        SizedBox(
          width: size.width*0.1,
        ),
        Container(
          height: size.height*0.08,
          width: size.width*0.4,
          decoration: BoxDecoration(
              color: DeepOrange,
              borderRadius: BorderRadius.circular(20)),
          child: TextButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const CreateNewRecipe_2()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text("Weiter",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),),
                SizedBox(
                  width: size.width*0.01
                ),
                const Icon(Icons.arrow_forward_outlined, color: Colors.white,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
