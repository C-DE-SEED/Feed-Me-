import 'package:flutter/material.dart';

import 'colors.dart';

List<String> places = [
  "Nuwakot",
  "Dhaulagiri",
  "Rara",
  "Muktinath",
  "Pashupatinath"
];

class AnimatedListOnePage extends StatefulWidget {

  const AnimatedListOnePage({Key key, @required this.listKey}) : super(key: key);
  final GlobalKey<AnimatedListState> listKey;

  @override
  _AnimatedListOnePageState createState() => _AnimatedListOnePageState();
}

class _AnimatedListOnePageState extends State<AnimatedListOnePage> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      shrinkWrap: true,
      key: widget.listKey,
      initialItemCount: 0,
      itemBuilder: (context, index, anim) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(anim),
          child:  Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              border: Border.all(
                width: 15,
                color: BasicGreen,
                style: BorderStyle.solid,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
            child: ListTile(
                title: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 0, bottom: 11, top: 11, right: 0),
                      hintText: 'Gewürz und Menge eingeben'),
                  onChanged: (value) {
                    String input = value;
                    // authService.getUser().updateDisplayName(value);
                    items.add(input);
                  },
                  //TODO find away to add external User data
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    widget.listKey.currentState.removeItem(
                      index,
                      (context, animation) {
                        String removedItem = items.removeAt(index);
                        return SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.transparent,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                            ),
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            child: ListTile(
                              title: Text(removedItem),
                            ),
                          ),
                        );
                      },
                    );
                    setState(() {});
                  },
                ),
            ),
          ),
        );
      },
    );
  }
}
