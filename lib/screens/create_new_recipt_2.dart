import 'package:feed_me/constants/animated_text_field_list.dart';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/show_steps_widget.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:animated_textformfields/animated_textformfields.dart';

class CreateNewRecipe_2 extends StatefulWidget {
  const CreateNewRecipe_2({Key key}) : super(key: key);

  @override
  _CreateNewRecipe_2State createState() => _CreateNewRecipe_2State();
}

class _CreateNewRecipe_2State extends State<CreateNewRecipe_2> {
  bool hasImage = false;
  int counter=1;
  List<Color> colors = [
    Colors.green,
    Colors.green,
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
    Colors.white.withOpacity(0.5),
  ];
  List<String> items= ["test","test2"];
  List<TextEditingController> controller = [];
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          size: size.width * 0.11,
          color: Colors.black,
        ),
        onPressed: () {
          setState(() {
            insertItem(items.length,counter.toString());
          });
        },
      ),
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: AnimatedList(
          shrinkWrap: true,
          key: listKey,
          initialItemCount: items.length,
          itemBuilder: (context, index, anim) {
            return SlideTransition(
              position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                  .animate(anim),
              child:  ListTile(
                title: TextFormField(
                  obscureText: false,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Zutat eingeben',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  onChanged: (value) {
                    setState(() {

                    });
                  },
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
                              borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                            ),
                            padding:
                            const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),

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
      ),
    );
  }

  void insertItem(int index, String item) {
    items.insert(index, item);
    listKey.currentState.insertItem(index);
  }

}

