import 'package:feed_me/model/shopping_list_object.dart';

class ShoppingList {
  List<ShoppingListObject> shoppingList;
  String name;

  ShoppingList(this.shoppingList,this.name);

  String get getName => name;

  set setName(String value) {
    name = value;
  }

  List<ShoppingListObject> get getShoppingList => shoppingList;

  set setShoppingList(List<ShoppingListObject> value) {
    shoppingList = value;
  }

  @override
  String toString() {
    return 'ShoppingList{shoppingList: $shoppingList, _name: $name}';
  }
}
