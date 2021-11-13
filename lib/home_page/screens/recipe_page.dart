import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/registration_and_login/user_local.dart';
import 'package:feed_me/user/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'fast_dishes_page.dart';
import 'main_dishes_page.dart';
import 'dessert_dishes_page.dart';
import 'starter_dishes_page.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  AuthService authService = AuthService();

  List<Widget> widgets = [
    const StarterDishesPage(),
    const MainDishesPage(),
    const DessertDishesPage(),
    const FastDishesPage(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.222,
            padding: const EdgeInsets.symmetric(vertical: 55),
            color:BasicGreen,
            child: RotatedBox(
              quarterTurns: 1,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  buildMenuItem("Vorspeisen", 0),
                  buildMenuItem("Hauptgerichte", 1),
                  buildMenuItem("Nachspeisen", 2),
                  buildMenuItem("Schnell", 3),
                  const Spacer(),
                  RotatedBox(
                    quarterTurns: -1,
                    child:  CircleAvatar(
                      backgroundImage: NetworkImage(authService.getUser().photoURL),
                      radius: size.width * 0.085,
                      backgroundColor: Colors.black,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                        },
                        child: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              children: [
                widgets[currentIndex],
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildMenuItem(String title, int index) {
    bool isSelected = currentIndex == index;
    return TextButton(
      onPressed: () => setState(() => currentIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSelected
              ? Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              color: Colors.amberAccent,
              shape: BoxShape.circle,
            ),
          )
              : Container(height: 10),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: openSansFontFamily,
              color: isSelected ? Colors.white : Colors.white60,
              fontSize: isSelected ? 20 : 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}