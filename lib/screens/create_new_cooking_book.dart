import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/standard_button.dart';
import 'package:feed_me/screens/create_new_recipt.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class CreateNewCookingBook extends StatefulWidget {
  const CreateNewCookingBook({Key key}) : super(key: key);

  @override
  _CreateNewCookingBookState createState() => _CreateNewCookingBookState();
}

class _CreateNewCookingBookState extends State<CreateNewCookingBook> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: BasicGreen,
      appBar: AppBar(
        backgroundColor: BasicGreen,
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
                hintText: 'Namen deines Rezeptbuchs eingeben'),
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          StandardButton(
              color: Colors.white,
              text: "Eingabe speichern",
              onPressed: () {
                //TODO: Save new book in Database
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CreateNewRecipt()));
              }),
        ],
      ),
    );
  }
}
