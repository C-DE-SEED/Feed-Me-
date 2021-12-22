class Recipe {
  String _id;
  String _category;
  String _description;
  String _difficulty;
  String _image;
  String _ingredientsAndAmount;
  String _kitchenStuff;
  String _name;
  String _origin;
  String _persons;
  String _shortDescription;
  String _spices;
  String _time;

  //FIXME unserNotes
  //String _userNotes;

  Recipe();

  Recipe.withAttributes(
    this._id,
    this._category,
    this._description,
    this._difficulty,
    this._image,
    this._ingredientsAndAmount,
    this._kitchenStuff,
    this._name,
    this._origin,
    this._persons,
    this._shortDescription,
    this._spices,
    this._time,
    //this._userNotes
  );

  @override
  String toString() {
    return 'Recipe{_id: $_id, _category: $_category, _description: $_description, _difficulty: $_difficulty, _image: $_image, _ingredientsAndAmount: $_ingredientsAndAmount, _kitchenStuff: $_kitchenStuff, _name: $_name, _origin: $_origin, _persons: $_persons, _shortDescription: $_shortDescription, _spices: $_spices, _time: $_time}';
  }

  //String get userNotes => _userNotes;
//
  //set userNotes(String value) {
  //  _userNotes = value;
  //}

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get spices => _spices;

  set spices(String value) {
    _spices = value;
  }

  String get shortDescription => _shortDescription;

  set shortDescription(String value) {
    _shortDescription = value;
  }

  String get persons => _persons;

  set persons(String value) {
    _persons = value;
  }

  String get origin => _origin;

  set origin(String value) {
    _origin = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get kitchenStuff => _kitchenStuff;

  set kitchenStuff(String value) {
    _kitchenStuff = value;
  }

  String get ingredientsAndAmount => _ingredientsAndAmount;

  set ingredientsAndAmount(String value) {
    _ingredientsAndAmount = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get difficulty => _difficulty;

  set difficulty(String value) {
    _difficulty = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
