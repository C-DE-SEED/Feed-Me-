import 'package:feed_me/constants/styles/colors.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final Function onPressed;

  const ButtonRow({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.08,
          width: size.width * 0.4,
          decoration: BoxDecoration(
              border: Border.all(color: deepOrange),
              color: basicColor,
              borderRadius: BorderRadius.circular(15)),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Zurück",
              style: TextStyle(
                color: deepOrange,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.1,
        ),
        Container(
          height: size.height * 0.08,
          width: size.width * 0.4,
          decoration: BoxDecoration(
              color: deepOrange, borderRadius: BorderRadius.circular(15)),
          child: TextButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Weiter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                /*SizedBox(width: size.width * 0.01),
                const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.white,
                )*/
              ],
            ),
          ),
        )
      ],
    );
  }
}
