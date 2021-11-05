import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/screens/recipt_overview.dart';
import 'package:flutter/material.dart';

class ChooseKindOfFood extends StatelessWidget {
  const ChooseKindOfFood({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BasicGreen,
      appBar: AppBar(backgroundColor: BasicGreen,elevation: 0,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              food_kind_button(
                  "assets/food_kinds/starters.png", "Vorspeisen", size, () {}),
              food_kind_button("assets/food_kinds/main_course.png",
                  "Hauptgerichte", size, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReciptOverview()));
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              food_kind_button(
                  "assets/food_kinds/fast.png", "Schnell", size, () {}),
              food_kind_button(
                  "assets/food_kinds/dessert.png", "Nachspeisen", size, () {}),
            ],
          ),

          button_no_filter("Alle Gerichte",size,(){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReciptOverview()));
          })

        ],
      ),
    );
  }

  Widget food_kind_button(
      String image, String text, Size size, Function onPress) {
    return TextButton(
      onPressed: onPress,
      child: Container(
        height: size.height * 0.3,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white60,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: openSansFontFamily,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget button_no_filter(String text, Size size, Function onPress) {
    return TextButton(
      onPressed: onPress,
      child: Container(
        height: size.height * 0.075,
        width: size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white60,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontFamily: openSansFontFamily,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
