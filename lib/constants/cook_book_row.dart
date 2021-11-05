import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/screens/create_new_cooking_book.dart';
import 'package:feed_me/screens/recipt_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'cook_book.dart';

class CookBookRow extends StatelessWidget {
  final String name1;
  final String name2;
  final String objectID1;
  final String objectID2;
  final Function newBook;

  const CookBookRow(
      {Key key, this.name1, this.name2, this.objectID1, this.objectID2,this.newBook})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return name2 != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CookBook(
                  text: name1,
                  onPress: () {

                  }),
              CookBook(
                  text: name2,
                  onPress: () {
                  }),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CookBook(
                  text: name1,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReciptOverview()));
                  }),
              TextButton(
                
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateNewCookingBook()));
                },
                child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: BasicGreen,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                          child: Container(
                            width: size.width * 0.4,
                            height: size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.add,color:Colors.black),
                          ),
                        ),
                        const Text(
                          "Neues Kochbuch",
                          style: TextStyle(
                              fontFamily: openSansFontFamily,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    )),
              )
            ],
          );
  }
}
