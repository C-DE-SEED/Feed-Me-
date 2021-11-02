import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({Key key, this.hasImage, this.onPressed})
      : super(key: key);

  final bool hasImage;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
          height: size.height*0.2,
          width: size.width * 0.9,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add_a_photo,color: Colors.black,size:30),
              SizedBox(
                height: 10
              ),
              Text(
                "Titelbild hinzufügen",
                style: TextStyle(fontFamily: openSansFontFamily,fontSize: 14, color:
                Colors.black,                    fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )),
    );
  }
}
