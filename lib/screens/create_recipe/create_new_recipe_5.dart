/*import 'package:feed_me/constants/custom_widgets/button_row.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/custom_widgets/show_steps_widget.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:feed_me/constants/user_options.dart';
import 'package:feed_me/model/recipe_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'create_new_recipt_4.dart';

class CreateNewRecipe_5 extends StatefulWidget {
  const CreateNewRecipe_5({Key key, @required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  _CreateNewRecipe_5State createState() => _CreateNewRecipe_5State();
}

class _CreateNewRecipe_5State extends State<CreateNewRecipe_5> {
  String shortDescription;
  List<String> items = [""];
  String origin='';
  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
        child: Column(
          children: [
            ShowSteps(
                colors: step5,
                step: "5.Schritt: Tobi tigert gerne in Kleingartenanlangen"),
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: const Text("Herkunft: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontFamily: openSansFontFamily)),
                ),
                Container(
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: deepOrange),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      _showOriginPicker(context, size);
                    },
                    child: Text(origin,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontFamily: openSansFontFamily)),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.10),
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
                              fontSize: fontSize,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Zutat eingeben',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                ingredients.elementAt(index).title =
                                    value;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: size.width * 0.3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Menge',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white)),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      ingredients
                                          .elementAt(index)
                                          .amount = value;
                                    });
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
                                        showUnits(context, size, index);
                                      },
                                      child: Center(
                                          child: Text(
                                            ingredients.elementAt(index).unit,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize,
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
            SizedBox(height: size.height * 0.2),
            ButtonRow(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateNewRecipe_4(recipe: widget.recipe)));
              },
            )
          ],
        ),
      ),
    );
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
                          fontSize: fontSize,
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
  void insertItem(int index, String item) {
    items.insert(index, item);
    ingredients.add(Ingredient('', '', ''));
    listKey.currentState.insertItem(index);
  }

  void _showOriginPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
          width: size.width,
          height: 250,
          child: CupertinoPicker(
            backgroundColor: deepOrange,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 1),
            children: originList
                .map((item) => Center(
              child: Text(item,style: const TextStyle(
                color: Colors.white,
              )),
            ))
                .toList(),
            onSelectedItemChanged: (value) {
              setState(() {
                origin = originList.elementAt(value);
              });
            },
          ),
        ));
  }
}*/
