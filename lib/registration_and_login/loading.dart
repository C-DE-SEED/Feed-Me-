import 'package:feed_me/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: const Center(
        child: SpinKitChasingDots(
          color: basicColor,
          size: 50.0,
        ),
      ),
    );
  }
}
