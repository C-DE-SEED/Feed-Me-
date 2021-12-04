import 'package:feed_me/model/recipe_object.dart';

class Cookbook {
  String image;
  String name;
  List<Recipe> recipes;

  Cookbook(this.image, this.name, this.recipes);

  Cookbook.withAttributes(
    this.image,
    this.name,
    this.recipes,
  );

  Cookbook.fromDatabase(
      this.image,
      this.name,
      );

  @override
  String toString() {
    return 'Cookbook{image: $image, name: $name, recipes: $recipes}';
  }
}
