import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/open_cookbook/screens/recipe_page.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/user/page/profile_page.dart';
import 'package:flutter/material.dart';
import '../recipe_db_object.dart';
import '../recipe_object.dart';

class ChooseCookbook extends StatefulWidget {
  const ChooseCookbook({
    Key key,
  }) : super(key: key);

  @override
  _ChooseCookbookState createState() => _ChooseCookbookState();
}

class _ChooseCookbookState extends State<ChooseCookbook> {
  int selectedIndex = 0;
  AuthService authService = AuthService();

  List<Recipe> plant_food_factory = [];

  void getAllRecipes() async {
    plant_food_factory = await RecipeDbObject()
        .getRecipeObject("plant_food_factory")
        .elementAt(0);
  }

  @override
  void initState() {
    getAllRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: basicColor,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0,0.0,16.0,15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20.0),
                        bottom: Radius.circular(0.0))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "Hallo, " + authService.getUser().displayName,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: openSansFontFamily)),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Was möchtest du heute kochen?",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontFamily: openSansFontFamily),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,10.0,10.0,0.0),
                          child: CircleAvatar(
                            backgroundImage:
                            CachedNetworkImageProvider(
                              authService.getUser().photoURL,
                            ),
                            radius: size.width * 0.09,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfilePage()));
                              },
                              child: null,
                            ),
                          ),
                        )
                      ],
                    ),
                    Material(
                        elevation: 5.0,
                        child: TextField(
                            onChanged: (value) {
                              //TODO insert filtered value
                            },
                            showCursor: true,
                            decoration: const InputDecoration(
                              hintText: "Nach Rezept suchen",
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.black54),
                              border: InputBorder.none,
                            ))),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () => _openDestinationPage(context),
                child: _buildFeaturedItem(
                    image:
                        "https://firebasestorage.googleapis.com/v0/b/feed-me-b8533.appspot.com/o/recipe_images%2FRed%20Curry%2F1.png?alt=media&token=bcfdf574-b959-45ff-a251-a171b2969161",
                    title: "Plant Food Factory's Kochbuch",
                    subtitle: "Gesund & Lecker")),
            GestureDetector(
                onTap: () => _openDestinationPage(context),
                child: _buildFeaturedItem(
                    image:
                        "https://www.takt-magazin.de/wp-content/uploads/2021/05/edgar-castrejon-1SPu0KT-Ejg-unsplash-scaled-e1622116685668-1170x855.jpg?x48126",
                    title: "Laura's Rezepte",
                    subtitle: "Frisch & Lecker")),
            GestureDetector(
                onTap: () => _openDestinationPage(context),
                child: _buildFeaturedItem(
                    image:
                        "https://i.pinimg.com/originals/cd/88/e9/cd88e9b8c1875b7813d6af93343040d8.jpg",
                    title: "Kim's Ideen",
                    subtitle: "Ausgefallen & Frech")),
            // GestureDetector(
            //     onTap: () => _openDestinationPage(context),
            //     child: _buildFeaturedItem(
            //         image:
            //         "https://www.belderbusch.de/wp-content/uploads/2018/09/vegetarisch-vegan-restaurant-essen-kln-bonn-5-von-5.jpg",
            //         title: "Pokhara",
            //         subtitle: "40 places worth to visit")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: ' Kochbuch\nhinzufügen',
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: size.width * 0.11,
          color: basicColor,
        ),
        onPressed: () {},
      ),
      //TODO ersetze den floatin action button durch normalen button der
      // durch align und padding an der position sitzt - so hat man keine
      // abgeschintte fläche unten
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container _buildFeaturedItem({String image, String title, String subtitle}) {
    return Container(
      padding: const EdgeInsets.only(
          left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => const CircularProgressIndicator(
                    color: basicColor,
                  ),
                ),),
            Positioned(
              bottom: 20.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                color: Colors.black.withOpacity(0.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: openSansFontFamily)),
                    Text(subtitle,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: openSansFontFamily)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openDestinationPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => RecipePage(
                  plant_food_factory: plant_food_factory,
                )));
  }
}
