import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/orange_box_decoration.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/services/auth_service.dart';
import 'package:feed_me/screens/home.dart';
import 'package:feed_me/screens/user/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../model/recipe_object.dart';
import 'fast_dishes_page.dart';
import 'main_dishes_page.dart';
import 'dessert_dishes_page.dart';
import 'starter_dishes_page.dart';

class RecipePage extends StatefulWidget {
  final List<Recipe> plantFoodFactory;
  final int recipeCount;
  final int cookBookCount;

  const RecipePage(
      {Key key,
      @required this.plantFoodFactory,
      @required this.recipeCount,
      @required this.cookBookCount})
      : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<Recipe> plantFoodFactory;
  List<Recipe> fast = [];
  List<Recipe> main = [];
  List<Recipe> dessert = [];
  List<Recipe> starter = [];
  AuthService authService = AuthService();
  int currentIndex = 0;

  void filterRecipes(List<Recipe> recipts) {
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
    filterRecipes(widget.plantFoodFactory);
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
            decoration: orangeBoxDecoration,
            width: size.width * 0.18,
            padding: const EdgeInsets.symmetric(vertical: 55),
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
                                      const Home()));
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
                      backgroundImage: CachedNetworkImageProvider(
                        authService.getUser().photoURL,
                      ),
                      radius: size.width * 0.065,
                      backgroundColor: Colors.black,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                recipeCount: widget.recipeCount,
                                cookBookCount: widget.cookBookCount,
                              ),
                            ),
                          );
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
