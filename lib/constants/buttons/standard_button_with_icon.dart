import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/material.dart';

class StandardButtonWithIcon extends StatelessWidget {
  const StandardButtonWithIcon(
      {Key key, this.text, this.onPressed, this.color, this.icon})
      : super(key: key);

  final Color color;
  final String text;
  final Function onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: onPressed,
      child: Container(
          height: 50,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const Spacer(),
                  Text(
                    text,
                    style: const TextStyle(
                      fontFamily: openSansFontFamily,
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )),
    );
  }
}
