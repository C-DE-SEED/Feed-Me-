import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/plant_app/model/data_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Plant plant;

  const DetailPage({Key key, this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: BasicGreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.045),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.file_download,
                          size: 30,
                        ),
                        onPressed: () {
                          //TODO insert share function
                        },
                      ),
                    ],
                  ),
                  Hero(
                    tag: plant.title,
                    child: Image.network(plant.image),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.005),
                        Text(
                          plant.title,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily,
                          ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        Text(
                          plant.discription,
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
                              'Für ' + plant.price + ' Personen',
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
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //TODO insert additonal data
                    buildCard("Schwierigkeit", Icons.settings, plant.temprature,
                        size),
                    buildCard("Dauer", Icons.alarm, plant.height, size),
                    buildCard("Kalorien", Icons.align_vertical_bottom_outlined,
                        plant.port, size),
                  ],
                ),
              ),
            ),
          ],
        ),
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
            fontSize: 20,
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
            fontFamily: openSansFontFamily,
          ),
        )
      ],
    );
  }
}