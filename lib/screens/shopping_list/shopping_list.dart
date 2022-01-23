import 'package:feed_me/constants/styles/colors.dart';
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
  List<String> recipeNames= [];
  FavsAndShoppingListDbHelper shoppingListDbHelper =
      FavsAndShoppingListDbHelper();

  //TODO: Implement updaet method to check or uncheck ingredients
  //Todo: load page if data is loaded
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
          title: const Text('Meine Einkaufsliste'),
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
                if (snap.data == null) {
                  return const Center(
                      child: Text("Es gibt noch keine Einträge auf deine Einkaufsliste"));
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
    return shoppingLists;
  }

  Widget shoppingListWidget(ShoppingList shoppingList) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(shoppingList.name),
            const Spacer(),
            IconButton(
                icon: const Icon(Icons.delete, color: Colors.black),
                onPressed: () {
                  setState(() {
                    deleteRecipeFromShoppingList(shoppingList.name);
                    getShoppingListData();
                  });
                }),
            const SizedBox(width: 10),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: const Divider(
              color: Colors.black,
              height: 36,
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
                      value: shoppingList.shoppingList
                                  .elementAt(index)
                                  .isChecked ==
                              '1'
                          ? true
                          : false,
                      onChanged: (newValue) {
                        setState(() {
                          //TODO: Change value  of item in database
                        });
                      }),
                  Text(shoppingList.shoppingList.elementAt(index).ingredient),
                ],
              );
            }),
        const SizedBox(height: 30)
      ],
    );
  }

  void deleteRecipeFromShoppingList(String collectionName) {
    shoppingListDbHelper.removeRecipeFromShoppingList(collectionName);
  }
}
