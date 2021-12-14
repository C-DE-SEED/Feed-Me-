import 'package:feed_me/model/recipe_object.dart';

class Cookbook {
  String _image;
  String _name;
  List<Recipe> _recipes;

  Cookbook(this._image, this._name, this._recipes);

  Cookbook.fromDatabase(
    this._image,
    this._name,
  );

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  @override
  String toString() {
    return 'Cookbook{image: $_image, name: $_name, recipes: $_recipes}';
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  List<Recipe> get recipes => _recipes;

  set recipes(List<Recipe> value) {
    _recipes = value;
  }
}
