import 'package:feed_me/constants/styles/colors.dart';
import 'package:flutter/material.dart';

class FeedMeCircleAvatar extends StatelessWidget {
  const FeedMeCircleAvatar({Key key, this.radius}) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: const AssetImage('assets/logoAccentOrange.png'),
      radius: radius,
      backgroundColor: Colors.transparent,
    );
  }
}
