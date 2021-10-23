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
        //TODO insert feedMe gif as loading animation
        child: SpinKitChasingDots(
          color: BasicGreen,
          size: 50.0,
        ),
      ),
    );
  }
}
