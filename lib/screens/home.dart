import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/cook_book.dart';
import 'package:feed_me/constants/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/search_text_form_field.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

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
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: BasicGreen,
            height: size.height * 0.4,
            width: size.width,
            child: Column(
              children: [FeedMeCircleAvatar(radius: 120), SearchTextFormField(hintText: "Nach Rezepten suchen",)],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CookBook(text: "Leckeres Essen", onPress: () {print("test");}),
              CookBook(text: "Leckeres Essen2", onPress: () {}),
            ],
          )
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
