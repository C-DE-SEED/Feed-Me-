import 'package:flutter/material.dart';

class ReciptPreviewImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width, height;
  final bool isTitle;

  const ReciptPreviewImage({
    Key key,
    this.fit,
    this.height,
    this.width,
    this.image,
    this.isTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: isTitle
          ? BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ))
          : BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(32.0)),
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              )),
    );
  }
}
