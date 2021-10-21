import 'package:feed_me/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedMeCircleAvatar extends StatelessWidget {
  const FeedMeCircleAvatar({Key key, this.radius}) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: LightBasicGreen,
      radius: radius + 1.0,
      child: CircleAvatar(
          backgroundImage: const AssetImage('assets/feedmelogo.png'),
          radius: radius,
          backgroundColor: Colors.transparent),
    );
  }
}
