import 'package:flutter/material.dart';

import 'cook_book.dart';

class CookBookRow extends StatelessWidget {
  final String name1;
  final String name2;
  final String objectID1;
  final String objectID2;

  const CookBookRow(
      {Key key, this.name1, this.name2, this.objectID1, this.objectID2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return name2 != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CookBook(
                  text: name1,
                  onPress: () {
                    print(objectID1);
                  }),
              CookBook(
                  text: name2,
                  onPress: () {
                    print(objectID2);
                  }),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CookBook(
                  text: name1,
                  onPress: () {
                    print(objectID1);
                  }),
            ],
          );
  }
}
