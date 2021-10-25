import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/cook_book_row.dart';
import 'package:feed_me/constants/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/profile_button.dart';
import 'package:feed_me/constants/search_text_form_field.dart';
import 'package:feed_me/user/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: BasicGreen,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
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
                  children: [
                    FeedMeCircleAvatar(radius: 120),
                    SearchTextFormField(
                      hintText: "Nach Rezepten suchen",
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return CookBookRow(
                            name1: "Leckeres Essen",
                            name2: "Vegie 4Life",
                            objectID1: "objectId1",
                            objectID2: "objectid2");
                      }),
                ),
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

    //
    //   TextButton(
    //   onPressed: () async {
    //     await _auth.signOut();
    //   },
    //   child: const Text("logout"),
    // );
  }
}
