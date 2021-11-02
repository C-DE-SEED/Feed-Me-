import 'package:feed_me/constants/add_image_button.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:feed_me/constants/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'home.dart';

class CreateNewRecipt extends StatefulWidget {
  const CreateNewRecipt({Key key}) : super(key: key);

  @override
  _CreateNewReciptState createState() => _CreateNewReciptState();
}

class _CreateNewReciptState extends State<CreateNewRecipt> {
  bool hasImage = false;
  File image;
  int ingedients = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: BasicGreen,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: size.height * 0.3,
                width: size.width,
                decoration: hasImage
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        image: DecorationImage(
                          image: new AssetImage(image.path),
                          fit: BoxFit.cover,
                        ))
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                child: !hasImage
                    ? AddImageButton(
                        hasImage: hasImage,
                        onPressed: () async {
                          await chooseFile();
                        },
                      )
                    : null),
            TextFormField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: 'Namen des Rezeptes eingeben'),
            ),

            _buildList(),


            StandardButton(
                color: Colors.white,
                text: "Eingabe speichern",
                onPress: () {
                  //TODO: Save recipt
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                }),
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

  Widget _buildList() {
    return Container(
      height: 120+(30*ingedients.toDouble()),
      color: Colors.transparent,
      child: Column(
          children:[
            Expanded(
              child: ListView.builder(
                  itemCount: ingedients,
                  itemBuilder: (context, index) {
                    return Center(child:  TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:
                          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Zutaten eingeben'),
                    ),);
                  }),
            ),
            IconButton(onPressed: (){
              setState(() {
                ingedients++;
              });
            }, icon: const Icon(Icons.add)),
          ]),
    );
  }
}
