import 'package:feed_me/model/recipe_object.dart';

class Cookbook{
  String image;
  String name;
  List<Recipe> recipes;
  Cookbook(this.image, this.name, this.recipes);

  @override
  String toString() {
    return 'Cookbook{image: $image, name: $name, recipes: $recipes}';
  }
}