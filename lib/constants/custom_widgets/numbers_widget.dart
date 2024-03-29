import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/recipe_db_object.dart';

class NumbersWidget extends StatefulWidget {
  const NumbersWidget(
      {Key key, @required this.recipeCount, @required this.cookBookCount})
      : super(key: key);
  final int recipeCount;
  final int cookBookCount;

  @override
  State<NumbersWidget> createState() => _NumbersWidgetState();
}

class _NumbersWidgetState extends State<NumbersWidget> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height:size.height*0.15,
      width: size.width*0.9,
      decoration: const BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.all(Radius.circular(40)),
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
                auth
                    .getUser()
                    .email,
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
              buildButton(context, widget.recipeCount.toString(), 'Rezepte'),
              buildDivider(),
              buildButton(
                  context, widget.cookBookCount.toString(), 'Kochbücher'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDivider() => const SizedBox(
        height: 40,
        child: VerticalDivider(color: Colors.black54,),
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
                  fontFamily: openSansFontFamily,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
