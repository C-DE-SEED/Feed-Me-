import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '35', 'Rezepte'),
          buildDivider(),
          buildButton(context, '3', 'Kochbücher'),
          //TODO show how many friends every user have (implement addFriends()
          // -Method)
          /*buildDivider(),
      buildButton(context, '50', 'Followers'),*/
        ],
      );

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                  fontFamily: openSansFontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black54,
                  fontFamily: openSansFontFamily, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
