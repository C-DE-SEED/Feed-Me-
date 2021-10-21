import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomAlert extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;

  const CustomAlert(
      {Key key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _CustomAlertState createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
             const EdgeInsets.only(left: 20, top: 20.0 + 20, right: 20, bottom:
    20),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: openSansTextStyle,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: BasicGreen),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: const TextStyle(fontFamily: openSansTextStyle,
                    fontSize: 15, color:
                BasicGreen),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: const TextStyle(fontFamily:openSansTextStyle,
                          fontSize: 18, color:
                      Colors
                          .black),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.asset("assets/feedmelogo.png")),
          ),
        ),
      ],
    );
  }
}
