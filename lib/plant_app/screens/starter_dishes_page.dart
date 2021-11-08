import 'package:feed_me/constants/text_style.dart';
import 'package:feed_me/plant_app/model/data_model.dart';
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
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.search,size: size.width * 0.08),
                onPressed: () {},
              )
            ],
          ),
          const Text('Vorspeisen', style: TextStyle(color: Colors.grey,
              fontSize: 22, fontFamily: openSansFontFamily)),
          SizedBox(height: size.height * 0.01),
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
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        plants[index].discription,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
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