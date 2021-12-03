import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/images/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/buttons/standard_button.dart';
import 'package:feed_me/constants/rounded_custom_alert.dart';
import 'package:flutter/material.dart';
import 'create_new_recipt_1.dart';

class CreateNewCookingBook extends StatefulWidget {
  const CreateNewCookingBook({Key key}) : super(key: key);

  @override
  _CreateNewCookingBookState createState() => _CreateNewCookingBookState();
}

class _CreateNewCookingBookState extends State<CreateNewCookingBook> {
  String cookbookName = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            onChanged: (value){
              setState(() {
                cookbookName = value;
              });
            },
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          StandardButton(
              color: Colors.white,
              text: "Eingabe speichern",
              onPressed: () {
                if(cookbookName == ""){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RoundedAlert(title: "Achtung",text: "Bitte gebe deinem Kochbuch einen Namen",);
                    },
                  );
                }
                else{

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                           CreateNewRecipe_1(cookBookName: cookbookName)));
                }
              }),
        ],
      ),
    );
  }
}
