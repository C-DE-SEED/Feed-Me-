import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/cook_book_row.dart';
import 'package:feed_me/constants/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/profile_button.dart';
import 'package:feed_me/constants/search_text_form_field.dart';
import 'package:feed_me/user/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicorndial/unicorndial.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<UnicornButton> childButtons = [];

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Neues Rezeptbuch",
        currentButton: FloatingActionButton(
          onPressed: () {
          },
          heroTag: "book",
          backgroundColor: Colors.grey,
          mini: true,
          child: const Icon(Icons.menu_book),
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Neues Rezept",
        currentButton: FloatingActionButton(
            onPressed: () {
            },
            heroTag: "recipt",
            backgroundColor: BasicGreen,
            mini: true,
            child: const Icon(Icons.sticky_note_2_outlined))));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Mein Profil",
        currentButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            heroTag: "profile",
            backgroundColor: Colors.grey,
            mini: true,
            child: const Icon(Icons.person_rounded))));

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: UnicornDialer(
          backgroundColor: Colors.transparent,
          parentButtonBackground: BasicGreen,
          orientation: UnicornOrientation.VERTICAL,
          parentButton: const Icon(Icons.add),
          childButtons: childButtons),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: BasicGreen,
                ),
                child: Column(
                  children: const [
                    FeedMeCircleAvatar(radius: 120),
                    SearchTextFormField(
                      hintText: "Nach Rezepten suchen",
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return const CookBookRow(
                        name1: "Leckeres Essen",
                        // name2: "Vegie 4Life",
                        objectID1: "objectId1",
                        // objectID2: "objectid2",
                      );
                    }),
              ),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: ProfileButton(
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              )),
        ],
      ),
    );
  }
}
