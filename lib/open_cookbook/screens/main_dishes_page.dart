import 'package:feed_me/constants/text_fields/search_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/open_cookbook/model/data_model.dart';
import 'package:flutter/material.dart';
import '../../recipt_object.dart';
import 'detail_page.dart';

class MainDishesPage extends StatefulWidget {
  List<Recipt> plant_food_factory;
  MainDishesPage({Key key,this.plant_food_factory}) : super(key: key);

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
            child: Text('Hauptgerichte', style: TextStyle(color: Colors.grey,
                fontSize: 22, fontFamily: openSansFontFamily)),
          ),
          SizedBox(height: size.height * 0.02),
          SearchTextFormField(hintText: 'Nach Gerichten suchen', onChange:
              (value){
            //TODO insert search function
            print(value);
          },),
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
                          recipt: widget.plant_food_factory[index],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.plant_food_factory[index].name,
                        child: Image.network(widget.plant_food_factory[index]
                            .image1),
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
                        widget.plant_food_factory[index].short_discription,
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