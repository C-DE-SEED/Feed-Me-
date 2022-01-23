class ShoppingListObject {
  String _ingredient;
  String _isChecked;

  ShoppingListObject(this._ingredient, this._isChecked);

  set ingredient(String value) {
    _ingredient = value;
  }

  String get ingredient => _ingredient;

  String get isChecked => _isChecked;

  set isChecked(String value) {
    _isChecked = value;
  }
}
