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

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

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
            }, icon: Icon(Icons.add)),
          ]),
    );
  }
}
