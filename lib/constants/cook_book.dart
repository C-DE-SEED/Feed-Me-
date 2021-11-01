import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CookBook extends StatelessWidget {
  const CookBook({Key key, this.text, this.onPress}) : super(key: key);

  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: onPress,
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
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    fontFamily: openSansFontFamily,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )
            ],
          )),
    );
  }
}
