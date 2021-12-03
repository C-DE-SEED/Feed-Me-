import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/recipe_object.dart';
import 'create_new_recipt_3.dart';

class CreateNewRecipe_2 extends StatefulWidget {
  Recipe recipe;

  CreateNewRecipe_2({Key key, this.recipe}) : super(key: key);

  @override
  _CreateNewRecipe_2State createState() => _CreateNewRecipe_2State();
}

class _CreateNewRecipe_2State extends State<CreateNewRecipe_2> {
  int counter = 1;
  List<Color> colors = [
    deepOrange,
    deepOrange,
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
  ];
  List<String> unitList = ["Gramm", "Kilogramm", "Liter", "Daumen", "Zehe"];
  List<String> items = ["test"];
  List<TextEditingController> controller = [];
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  String unit = "test";

  @override
  void initState() {
    print(widget.recipe.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ShowSteps(
                      colors: colors,
                      step: "2.Schritt: Zutaten und Mengen eingeben"),
                  SizedBox(height: size.height * 0.01),
                  AnimatedList(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    key: listKey,
                    initialItemCount: items.length,
                    itemBuilder: (context, index, anim) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1, 0), end: Offset.zero)
                            .animate(anim),
                        child: ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)),
                            height: size.height * 0.15,
                            child: Column(
                              children: [
                                TextFormField(
                                  obscureText: false,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Zutat eingeben',
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                  ),
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width * 0.3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: 'Menge eingeben',
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.1,
                                    ),
                                    Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.white))),
                                        width: size.width * 0.3,
                                        height: size.height * 0.058,
                                        child: TextButton(
                                            onPressed: () {
                                              showUnits(context, size);
                                            },
                                            child: Center(
                                                child: Text(
                                              unit,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                              ),
                                            )))),
                                  ],
                                )
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              items.remove(items.elementAt(index));
                              listKey.currentState.removeItem(
                                index,
                                (context, animation) {
                                  return SizeTransition(
                                    sizeFactor: animation,
                                    axis: Axis.vertical,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                          width: 1,
                                          style: BorderStyle.solid,
                                          color: Colors.transparent,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(40)),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 0.0),
                                    ),
                                  );
                                },
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.01),
                  addAnotherIngredientButton(size),
                  SizedBox(height: size.height * 0.2)
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: ButtonRow(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateNewRecipe_3()));
                  },
                ))
          ],
        ),
      ),
    );
  }

  void insertItem(int index, String item) {
    items.insert(index, item);
    listKey.currentState.insertItem(index);
  }

  Widget addAnotherIngredientButton(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width * 0.7,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: deepOrange),
              borderRadius: BorderRadius.circular(20)),
          child: TextButton(
              onPressed: () {
                setState(() {
                  insertItem(items.length, counter.toString());
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: deepOrange),
                  Text("Weitere Zutat hinzufügen",
                      style: TextStyle(
                          color: deepOrange,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily)),
                ],
              )),
        ),
        SizedBox(
          width: size.width * 0.15,
        )
      ],
    );
  }

  void showUnits(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              width: size.width,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: deepOrange,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: unitList
                    .map((item) => Center(
                          child: Text(item),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    unit = unitList.elementAt(value);
                  });
                },
              ),
            ));
  }
}
