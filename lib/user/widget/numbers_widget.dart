import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/user_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key key, @required this.userMail}) : super(key: key);
  final String userMail;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.all(
          width: 15,
          color: BasicGreen,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
    child: Column(
      children: [
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.email_outlined,
              color: Colors.black54,
            ),
            const SizedBox(
              width: 7.0,
            ),
            Text(
              userMail,
              style: const TextStyle(
                fontFamily: openSansFontFamily,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButton(context,'0' ?? Provider.of<UserLocal>(context,
                    listen: false).books.toString(), 'Rezepte'),
                buildDivider(),
                buildButton(context, '0'??Provider.of<UserLocal>(context,
                    listen:
                    false).recipes.toString(), 'Kochbücher'),
                //TODO show how many friends every user have (implement addFriends()
              ],
            ),
      ],
    ),
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
