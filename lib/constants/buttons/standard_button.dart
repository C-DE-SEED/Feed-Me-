import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({Key key, this.text, this.onPressed, this.color})
      : super(key: key);

  final Color color;
  final String text;
  final Function onPressed;

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
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: openSansFontFamily,
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
              ),
            ),
          )),
    );
  }
}
