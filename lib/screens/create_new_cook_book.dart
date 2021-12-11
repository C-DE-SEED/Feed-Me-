import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/images/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/alerts/rounded_custom_alert.dart';
import 'package:feed_me/model/cookbook.dart';
import 'package:flutter/material.dart';
import 'create_recipe/create_new_recipe_1.dart';

class CreateNewCookingBook extends StatefulWidget {
  const CreateNewCookingBook({Key key}) : super(key: key);

  @override
  _CreateNewCookingBookState createState() => _CreateNewCookingBookState();
}

class _CreateNewCookingBookState extends State<CreateNewCookingBook> {
  String cookbookName = "";
  Cookbook cookbook = Cookbook('', '', []);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: basicColor,
      appBar: AppBar(
        backgroundColor: basicColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: FeedMeCircleAvatar(
              radius: size.height * 0.2,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, size.height * 0.05, 15.0, 0.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white12,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: 'Gib deinem Kochbuch einen Namen:'),
              onChanged: (value) {
                setState(() {
                  cookbookName = value;
                });
              },
            ),
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          StandardButton(
              color: Colors.white,
              text: "Eingabe speichern",
              onPressed: () {
                if (cookbookName == "") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RoundedAlert(
                        title: "❗️Achtung❗",
                        text: "Benne dein Kochbuch bitte ☺️",
                      );
                    },
                  );
                } else {
                  cookbook.name = cookbookName;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateNewRecipe_1(cookbook: cookbook)));
                }
              }),
        ],
      ),
    );
  }
}
