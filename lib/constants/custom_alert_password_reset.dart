import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomAlertPWReset extends StatefulWidget {
  final String title, text;
  final Image img;

  const CustomAlertPWReset(
      {Key key, this.title, this.text, this.img})
      : super(key: key);

  @override
  _CustomAlertPWResetState createState() => _CustomAlertPWResetState();
}

class _CustomAlertPWResetState extends State<CustomAlertPWReset> {
  AuthService auth = AuthService();
  String email='';
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
             const EdgeInsets.only(left: 20, top: 40, right: 20, bottom:
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
                  fontFamily: openSansFontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: basicColor),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  onChanged: (value) {
email=value;                  },
                  showCursor: true,
                  decoration: InputDecoration(
                    hintText: "E-Mail eingeben",
                    prefixIcon:
                    const Icon(Icons.mail, color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  )),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      auth.sendPasswordResetEmail(email);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: const TextStyle(fontFamily:openSansFontFamily,
                          fontSize: 15, color:
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
                child: Image.asset("assets/logoHellOrange.png")),
          ),
        ),
      ],
    );
  }
}
