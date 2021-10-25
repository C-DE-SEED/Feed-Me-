import 'package:feed_me/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({Key key, this.imagePath, this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        children: [
          buildImage(size),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(Colors.white60),
          ),
        ],
      ),
    );
  }

  Widget buildImage(Size size) {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: size.height * 0.18,
          height: size.height * 0.18,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: BasicGreen,
        all: 2,
        child: buildCircle(
          color: color,
          all: 6,
          child: const Icon(
            Icons.add_a_photo_outlined,
            color: BasicGreen,
            size: 25,
          ),
        ),
      );

  Widget buildCircle({
    @required Widget child,
    @required double all,
    @required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
