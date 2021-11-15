import 'package:feed_me/constants/text_fields/search_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';
import '../../recipt_object.dart';
import 'detail_page.dart';

class StarterDishesPage extends StatefulWidget {
  List<Recipt> plantFoodFactory;

  StarterDishesPage({Key key, this.plantFoodFactory})
      : super(key: key);

  @override
  State<StarterDishesPage> createState() => _StarterDishesPageState();
}

class _StarterDishesPageState extends State<StarterDishesPage> {
  List<String> reciptSteps = [];
  List<String> ingredients = [];

  void filterSteps(Recipt recipe) {
    reciptSteps = recipe.description.split("/");
  }

  void filterIngredients(Recipt recipe) {
    ingredients = recipe.ingredients_and_amount.split("/");
  }


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
            child: Text('Vorspeisen',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                    fontFamily: openSansFontFamily)),
          ),
          SizedBox(height: size.height * 0.02),
          SearchTextFormField(
            hintText: 'Nach Gerichten suchen',
            onChange: (value) {
              //TODO insert search function
              print(value);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.plantFoodFactory.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    filterSteps(widget.plantFoodFactory[index]);
                    filterIngredients(widget.plantFoodFactory[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          recipt: widget.plantFoodFactory[index],
                          reciptSteps: reciptSteps,
                          ingredients: ingredients,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.plantFoodFactory[index].name,
                        child: Image.network(widget.plantFoodFactory[index].image),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        widget.plantFoodFactory[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        widget.plantFoodFactory[index].short_discription,
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
