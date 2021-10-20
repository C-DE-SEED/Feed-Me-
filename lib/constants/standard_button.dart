import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({Key key, this.text, this.onPress, this.color})
      : super(key: key);

  final Color color;
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: onPress,
      child: Container(
          height: 50,
          width: size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              color: color,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 5.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 1,
              ),
            ),
          )),
    );
  }
}
