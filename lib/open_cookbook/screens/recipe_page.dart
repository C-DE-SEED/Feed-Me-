import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/screens/choose_cookbook.dart';
import 'package:feed_me/user/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../recipt_object.dart';
import 'fast_dishes_page.dart';
import 'main_dishes_page.dart';
import 'dessert_dishes_page.dart';
import 'starter_dishes_page.dart';

class RecipePage extends StatefulWidget {
  List<Recipt> plant_food_factory;

  RecipePage({Key key, this.plant_food_factory}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<Recipt> plant_food_factory;
  List<Recipt> fast = [];
  List<Recipt> main = [];
  List<Recipt> dessert = [];
  List<Recipt> starter = [];
  AuthService authService = AuthService();
  int currentIndex = 0;

  void filterRecipes(List<Recipt> recipts) {
    recipts.forEach((element) {
      if (element.category == "Hauptgericht") {
        main.add(element);
      } else if (element.category == "starter") {
        main.add(element);
      } else if (element.category == "dessert") {
        main.add(element);
      } else if (element.category == "fast") {
        main.add(element);
      }
    });
  }

  @override
  void initState() {
    filterRecipes(widget.plant_food_factory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      StarterDishesPage(plant_food_factory: starter),
      MainDishesPage(plant_food_factory: main),
      DessertDishesPage(plant_food_factory: dessert),
      FastDishesPage(plant_food_factory: starter),
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.18,
            padding: const EdgeInsets.symmetric(vertical: 55),
            color: basicColor,
            child: RotatedBox(
              quarterTurns: 1,
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                      child: IconButton(
                        icon: Icon(
                          MdiIcons.chefHat,
                          color: Colors.white,
                          size: size.width * 0.1,
                        ),
                        tooltip: 'Zurück zur\n'
                            'Kochbuchübersicht',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChooseCookbook()));
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  buildMenuItem("Vorspeisen", 0),
                  buildMenuItem("Hauptgerichte", 1),
                  buildMenuItem("Nachspeisen", 2),
                  buildMenuItem("Schnell", 3),
                  const Spacer(),
                  RotatedBox(
                    quarterTurns: -1,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(authService.getUser().photoURL),
                      radius: size.width * 0.065,
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
