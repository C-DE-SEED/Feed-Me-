import 'package:animate_do/animate_do.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [basicColor, deepOrange])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Über uns",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: openSansFontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
          body: Center(
            child: SizedBox(
              width: size.width*0.8,
              child: Column(
                children: [
                  FadeInDown(
                    from: 100,
                    duration: const Duration(milliseconds: 1000),
                    child: Center(
                      child: Container(
                        height: size.height*0.2,
                        width: size.width*0.8,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/CodeSeedLogo.png",
                            ),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                    )
                  ),

                  SizedBox(height: size.height*0.02),

                  FadeInUp(
                    from: 100,
                    duration: const Duration(milliseconds: 1000),
                    child: const Text('FeedMe! ist das erste Produkt des Würzburger Startups CodeSeed. Wir (Maximilian Drescher und Tobias Neidhardt) sind beide selbst leidenschaftliche vegetarische Köche. Bei den angebotenen Rezepten handelt es sich um unsere persönlichen Lieblingsgerichte. Mit FeedMe! wollen wir eine minimalistische, nutzerfreundliche und moderne alternative zu den bereits bestehenden Apps dieser Kategorie bieten. '
                        'Wir wünschen euch viel Spaß mit unserer App und einen guten Hunger!☺️👨🏻‍🍳',
                        style: TextStyle(
                            fontFamily: openSansFontFamily,
                            fontSize: 15)),
                  ),
                  SizedBox(height: size.height*0.02),
                  FadeInUp(
                    from: 100,
                    duration: const Duration(milliseconds: 1000),
                    child: const Text('Bei Fragen einfach melden bei:',
                        style:
                        TextStyle(fontFamily: openSansFontFamily, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  FadeInUp(
                    from: 100,
                    duration: const Duration(milliseconds: 1000),
                    child: const Text('codeseed.wue@gmail.com',
                        style:
                        TextStyle(fontFamily: openSansFontFamily, fontSize: 14)),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
