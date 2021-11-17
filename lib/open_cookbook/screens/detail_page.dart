import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/open_cookbook/model/data_model.dart';
import 'package:flutter/material.dart';

import '../../recipt_object.dart';

class DetailPage extends StatelessWidget {
  final Recipt recipt;

  const DetailPage({Key key, this.recipt, Recipe plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: basicColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: recipt.name,
                child: Image.network(recipt.image),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: ClipOval(
                  child: Container(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.file_download,
                        size: 40,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        //TODO insert share function
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  // radius for left side orange
                  bottomLeft: Radius.circular(size.width * 0.4),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 70),
                children: [
                  SizedBox(height: size.height * 0.005),
                  Text(
                    recipt.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: openSansFontFamily,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    recipt.description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: openSansFontFamily,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    children: [
                      Text(
                        'Für ' + recipt.persons + ' Personen',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily,
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 22,
                              ),
                              onPressed: () {
                                // TODO insert person counter
                                setState() {}
                              }),
                          IconButton(
                              icon: const Icon(
                                Icons.remove,
                                size: 22,
                              ),
                              onPressed: () {
                                // TODO insert person counter
                                setState() {}
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0,2.0,10.0,5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //TODO insert additonal data
                buildCard(
                    "Schwierigkeit", Icons.settings, recipt.difficulty, size),
                buildCard("Dauer", Icons.alarm, recipt.time, size),
                buildCard("Kalorien", Icons.align_vertical_bottom_outlined,
                    "100", size),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, IconData icon, String data, Size size) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 25),
        SizedBox(height: size.height * 0.01),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: openSansFontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          data,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: openSansFontFamily,
          ),
        )
      ],
    );
  }
}
