import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key key, this.onPress}) : super(key: key);

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      decoration: const BoxDecoration(
        // borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        color: Colors.white,
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage("assets/feedmelogo.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: TextButton(
        onPressed: onPress, child: null,
      ),
    );
  }
}
