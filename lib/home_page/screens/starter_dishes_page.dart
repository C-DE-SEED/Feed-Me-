import 'package:feed_me/constants/text_fields/search_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/home_page/model/data_model.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';

class StarterDishesPage extends StatelessWidget {
  const StarterDishesPage({Key key}) : super(key: key);

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
            child: Text('Vorspeisen', style: TextStyle(color: Colors.grey,
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
              itemCount: plants.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(
                          //TODO change Plants with recipes
                          plant: plants[index],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: plants[index].title,
                        child: Image.network(plants[index].image),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        plants[index].title,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily,

                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        plants[index].discription,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: openSansFontFamily,

                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text(
                            "\$${plants[index].price}",
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily,

                            ),
                          ),
                          TextButton(
                            child: const Text(
                              "+",
                              style: TextStyle(fontSize: 22),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
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