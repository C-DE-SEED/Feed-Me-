import 'package:feed_me/constants/alerts/alert_with_function.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/model/favs_and_shopping_list_db.dart';
import 'package:feed_me/model/shopping_list.dart';
import 'package:feed_me/model/shopping_list_object.dart';
import 'package:flutter/material.dart';

class ShoppingListCheck extends StatefulWidget {
  ShoppingListCheck({Key key}) : super(key: key);

  @override
  _ShoppingListCheckState createState() => _ShoppingListCheckState();
}

class _ShoppingListCheckState extends State<ShoppingListCheck> {
  List<ShoppingList> shoppingLists = [];
  List<String> recipeNames = [];
  List<List<bool>> checkLists = [];
  FavsAndShoppingListDbHelper shoppingListDbHelper =
      FavsAndShoppingListDbHelper();
  @override
  void initState() {
    setState(() {
      getShoppingListData().then((value) => {shoppingLists = value});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: basicColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
          title: const Text('Meine Einkaufsliste 👨🏻‍🍳',style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: openSansFontFamily)),
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [basicColor, deepOrange])),
          child: FutureBuilder<List<ShoppingList>>(
              future: getShoppingListData(),
              builder: (context, AsyncSnapshot<List<ShoppingList>> snap) {
                if (recipeNames.isEmpty) {
                  return const Center(
                      child: Text(
                          "Es gibt noch keine Einträge auf deine Einkaufsliste",style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontFamily: openSansFontFamily)));
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: shoppingLists.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return shoppingListWidget(shoppingLists.elementAt(index));
                    });
              })),
    );
  }

  Widget shoppingListWidget(ShoppingList shoppingList) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(shoppingList.name,style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: openSansFontFamily)),
            const Spacer(),
            IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertWithFunction(
                        title: "❗️Achtung❗",
                        text:
                            "Willst du das Rezept wirklich aus deiner Einkaufsliste löschen?️",
                        buttonText: "Ja, bitte",
                        onPressed: () {
                          Navigator.pop(context);
                          deleteRecipeFromShoppingList(shoppingList.name);
                          getShoppingListData();
                        },
                      );
                    },
                  );
                  setState(() {});
                }),
            const SizedBox(width: 10),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: const Divider(
              color: Colors.black38,
              height: 0,
              thickness: 2,
            )),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: shoppingList.shoppingList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox(
                      shape: const CircleBorder(),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      value: shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked ==
                              '1'
                          ? true
                          : false,
                      onChanged: (newValue) {
                        setState(() {
                          if (shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked ==
                              '1') {
                            shoppingListDbHelper.updateShoppingList(
                                shoppingList.shoppingList
                                    .elementAt(index)
                                    .ingredient,
                                '0',
                                shoppingList.name);
                            setState(() {
                              shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked = '0';
                              print(shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked);
                            });
                          } else if (shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked ==
                              '0') {
                            shoppingListDbHelper.updateShoppingList(
                                shoppingList.shoppingList
                                    .elementAt(index)
                                    .ingredient,
                                '1',
                                shoppingList.name);
                            setState(() {
                              shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked = '1';
                              print(shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked);
                            });
                          }
                        });
                      }),
                  Text(shoppingList.shoppingList.elementAt(index).ingredient,style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: openSansFontFamily)),
                ],
              );
            }),
        const SizedBox(height: 30)
      ],
    );
  }

  Future<List<ShoppingList>> getShoppingListData() async {
    List<ShoppingList> shoppingLists = [];
    recipeNames = await shoppingListDbHelper.getCollectionNames();
    for (int i = 0; i < recipeNames.length; i++) {
      List<ShoppingListObject> ingredients = await await shoppingListDbHelper
          .getRecipesFromShoppingListCollection(recipeNames.elementAt(i))
          .first;
      ShoppingList shoppingList =
          ShoppingList(ingredients, recipeNames.elementAt(i));
      shoppingLists.add(shoppingList);
    }
    setState(() {});
    return shoppingLists;
  }

  void deleteRecipeFromShoppingList(String collectionName) {
    setState(() {
      shoppingListDbHelper.removeRecipeFromShoppingList(collectionName);
      recipeNames.removeWhere((element) => element == collectionName);
      shoppingLists.removeWhere((element) => element.name == collectionName);
    });
  }
}
