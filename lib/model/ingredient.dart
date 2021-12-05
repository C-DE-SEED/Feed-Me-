class Ingredient {
  String _title;
  String _amount;
  String _unit;

  Ingredient(this._title, this._amount, this._unit);

  String get unit => _unit;

  set unit(String value) {
    _unit = value;
  }

  String get amount => _amount;

  set amount(String value) {
    _amount = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  @override
  String toString() {
    return 'Ingredient{_title: $_title, _amount: $_amount, _unit: $_unit}';
  }
}
