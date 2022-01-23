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
//TODO: Implement remove method for single recipe
  //TODO: Implement updaet method to check or uncheck ingredients
  //Todo: load page if data is loaded
  @override
  void initState() {
    setState(() {
      getShoppingListData().then((value) => {
        shoppingLists = value
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: basicColor,
      appBar: AppBar(title:const Text('Meine Einkaufsliste'),
      backgroundColor: Colors.transparent,
      elevation: 0.0),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [basicColor, deepOrange])
        ),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: shoppingLists.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return shoppingListWidget(shoppingLists.elementAt(index));
            }),

      ),
    );
  }

  Future<List<ShoppingList>> getShoppingListData() async {
    List<ShoppingList> shoppingLists = [];
    FavsAndShoppingListDbHelper shoppingListDbHelper = FavsAndShoppingListDbHelper();
    List<String> recipeNames = await shoppingListDbHelper.getCollectionNames();
    for (int i = 0; i<recipeNames.length; i++){
      List <ShoppingListObject> ingredients = await await shoppingListDbHelper.getRecipesFromShoppingListCollection(recipeNames.elementAt(i)).first;
      ShoppingList shoppingList =  ShoppingList(ingredients, recipeNames.elementAt(i));
      shoppingLists.add(shoppingList);
    }
    return shoppingLists;
  }

  Widget shoppingListWidget(ShoppingList shoppingList){
    return Column(
      children: [
        Text(shoppingList.name),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: shoppingList.shoppingList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox(value: shoppingList.shoppingList.elementAt(index).isChecked == '1' ? true : false, onChanged: (newValue){
                    setState(() {
                      //TODO: Change value  of item in database
                    });
                  }),
                  Text(shoppingList.shoppingList.elementAt(index).ingredient),
                ],
              );
            }),
      ],
    );
  }
}


