import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RoundedAlert extends StatelessWidget {

  String title;
  String text;


  RoundedAlert({Key key, this.title,this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 20.0),
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(MdiIcons.exclamationThick,color:deepOrange,size: 60,),
                ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Text(
                      title,style: const TextStyle(
                         color: Colors.black,
                         fontSize: 14.0,
                         fontWeight: FontWeight.bold,
                         fontFamily: openSansFontFamily)
                    ),
                    const SizedBox(height: 10.0),
                     Flexible(
                      child: Text(
                          text,style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontFamily: openSansFontFamily)),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 40,
                      width: 90,
                      decoration: const BoxDecoration(
                        color: basicColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextButton(
                        child: const Text("OK",style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontFamily: openSansFontFamily)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}