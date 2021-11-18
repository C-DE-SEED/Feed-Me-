import 'package:cached_network_image/cached_network_image.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_fields/search_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';
import '../../recipe_object.dart';
import 'detail_page.dart';

class MainDishesPage extends StatefulWidget {
  List<Recipe> plant_food_factory;

  MainDishesPage({Key key, this.plant_food_factory}) : super(key: key);

  @override
  State<MainDishesPage> createState() => _MainDishesPageState();
}

class _MainDishesPageState extends State<MainDishesPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.08),
          const Center(
            child: Text('Hauptgerichte',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontFamily: openSansFontFamily)),
          ),
          SizedBox(height: size.height * 0.02),
          TextField(
              onChanged: (value) {
                //TODO insert filtered value
              },
              showCursor: true,
              decoration: InputDecoration(
                hintText: "Nach Gerichten suchen",
                prefixIcon:
                const Icon(Icons.search, color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              )),
          Expanded(
            child: ListView.builder(
              itemCount: widget.plant_food_factory.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          recipe: widget.plant_food_factory[index],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.plant_food_factory[index].name,
                        child: CachedNetworkImage(
                               imageUrl: widget.plant_food_factory[index].image,
                            placeholder: (context, url) => const CircularProgressIndicator(
                              color: basicColor,
                            ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        widget.plant_food_factory[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        widget.plant_food_factory[index].shortDescription,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: openSansFontFamily,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      const SizedBox(height: 30),
                      const Divider(),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
