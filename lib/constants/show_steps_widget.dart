import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

class ShowSteps extends StatelessWidget {
  const ShowSteps({Key key, this.step,this.colors}) : super(key: key);

  final String step;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          step,
          style:
          const TextStyle(fontSize: 12.0, fontFamily: openSansFontFamily),
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          children: [
            Container(
              height: size.height * 0.01,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  color: colors.elementAt(0),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Container(
              height: size.height * 0.01,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  color: colors.elementAt(1),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Container(
              height: size.height * 0.01,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  color: colors.elementAt(2),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Container(
              height: size.height * 0.01,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  color: colors.elementAt(3),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Container(
              height: size.height * 0.01,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                  color: colors.elementAt(4),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ],
        ),
      ],
    );
  }
}
