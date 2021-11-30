import 'dart:io';
import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steps/steps.dart';

class StepsTest extends StatefulWidget {
  const StepsTest({Key key}) : super(key: key);

  @override
  _StepsTestState createState() => _StepsTestState();
}

class _StepsTestState extends State<StepsTest> {
  File image;
  String inputText;
  bool hasImage = false;
  int counter = 1;
  List<String> items = ["test", "test2"];
  List<TextEditingController> controller = [];
  bool easy = false;
  bool medium = false;
  bool hard = false;
  String time = "0";
  String persons = "1";
  List<String> timeList = [
    "5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
    "55",
    "60",
  ];
  List<String> personList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
  ];
  final List<String> keys = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    String reciptName = '';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            child: Steps(
              direction: Axis.vertical,
              size: 20.0,
              path: {'color': Colors.deepOrange, 'width': 3.0},
              steps: [
                {
                  'color': Colors.white,
                  'background': Colors.deepOrange,
                  'label': '1',
                  'content': Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text("Titelbild und Namen festlegen",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily)),
                      Center(
                        child: SizedBox(
                          width: size.width * 0.9,
                          child: TextFormField(
                            obscureText: false,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Rezeptname eingeben',
                              hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                reciptName = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.1),
                      const Text("Titelbild für das Rezept festlegen:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily)),
                      SizedBox(height: size.height * 0.02),
                      photoContainer(size),
                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
                },
                {
                  'color': Colors.white,
                  'background': Colors.deepOrange,
                  'label': '2',
                  'content': Column(
                      children: <Widget>[
                        const Text("Zutaten und Menge festlegen",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: openSansFontFamily)),
                        SizedBox(height: size.height*0.02),
                        Column(
                          children: [
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
                                                width: size.width * 0.2,
                                                child: TextFormField(
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
                                                width: size.width * 0.2,
                                                child: TextFormField(
                                                  obscureText: false,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                  ),
                                                  decoration: const InputDecoration(
                                                    hintText: 'Einheit auswählen',
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
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    //TODO: replace with remove on slide
                                    // trailing: IconButton(
                                    //   icon: const Icon(Icons.clear),
                                    //   onPressed: () {
                                    //     items.remove(items.elementAt(index));
                                    //     listKey.currentState.removeItem(
                                    //       index,
                                    //           (context, animation) {
                                    //         return SizeTransition(
                                    //           sizeFactor: animation,
                                    //           axis: Axis.vertical,
                                    //           child: Container(
                                    //             margin: const EdgeInsets.symmetric(
                                    //               vertical: 4.0,
                                    //               horizontal: 8.0,
                                    //             ),
                                    //             decoration: BoxDecoration(
                                    //               color: Colors.transparent,
                                    //               border: Border.all(
                                    //                 width: 1,
                                    //                 style: BorderStyle.solid,
                                    //                 color: Colors.transparent,
                                    //               ),
                                    //               borderRadius: const BorderRadius.all(
                                    //                   Radius.circular(40)),
                                    //             ),
                                    //             padding: const EdgeInsets.fromLTRB(
                                    //                 0.0, 0.0, 0.0, 0.0),
                                    //           ),
                                    //         );
                                    //       },
                                    //     );
                                    //     setState(() {});
                                    //   },
                                    // ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            addAnotherIngredientButton(size),
                            SizedBox(height: size.height * 0.2)
                          ],
                        ),
                      ],
                    )
                },
                {
                  'color': Colors.white,
                  'background': Colors.deepOrange,
                  'label': '3',
                  'content': Column(
                    children: [
                      SizedBox(height: size.height * 0.01),
                      const Text("Kurzbeschreibung hinzufügen:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily)),
                      SizedBox(height: size.height * 0.01),
                      Container(
                        height: size.height * 0.2,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5)),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          maxLines: 10,
                          onChanged: (value) {},
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Kurzbeschreibung hinzufügen',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      const Text("Schwierigkeit:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: openSansFontFamily)),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          difficultyButton(size, "Einfach", BasicGreen, easy, () {
                            setState(() {
                              easy = !easy;
                              if (easy == true) {
                                medium = false;
                                hard = false;
                              }
                            });
                          }),
                          SizedBox(width: size.width * 0.05),
                          difficultyButton(size, "Mittel", BasicGreen, medium, () {
                            setState(() {
                              medium = !medium;
                              if (medium == true) {
                                easy = false;
                                hard = false;
                              }
                            });
                          }),
                          SizedBox(width: size.width * 0.05),
                          difficultyButton(size, "Schwer", BasicGreen, hard, () {
                            setState(() {
                              hard = !hard;
                              if (hard == true) {
                                medium = false;
                                easy = false;
                              }
                            });
                          }),
                        ],
                      ),
                      SizedBox(height: size.height * 0.09),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width*0.4,
                            child: const Text("Zubereitungszeit: ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: openSansFontFamily)),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Container(
                            width: size.width*0.25,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                _showMinutesPicker(context, size);
                              },
                              child: Text(time + " Minuten",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: openSansFontFamily)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height*0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width*0.4,
                            child: const Text("Anzahl der Personen:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: openSansFontFamily)),
                          ),
                          SizedBox(width: size.width * 0.05),
                          Container(
                            width: size.width*0.25,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () {
                                _showPersonsPicker(context, size);
                              },
                              child: Text(persons + " Personen",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: openSansFontFamily)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                },
                {
                  'color': Colors.white,
                  'background': Colors.deepOrange,
                  'label': '4',
                  'content': Column(
                    children: [
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
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
                                          height: size.height * 0.1,
                                          child: Column(
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      width: size.width * 0.1,
                                                      child: Text((index+1).toString()+". Schritt", style: const TextStyle(
                                                          color: BasicGreen,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: openSansFontFamily))
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.1,
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.4,
                                                    child: TextFormField(
                                                      obscureText: false,
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                      ),
                                                      decoration: const InputDecoration(
                                                        hintText: 'Schritt',
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
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        // trailing: IconButton(
                                        //   icon: const Icon(Icons.clear),
                                        //   onPressed: () {
                                        //     items.remove(items.elementAt(index));
                                        //     listKey.currentState.removeItem(
                                        //       index,
                                        //           (context, animation) {
                                        //         return SizeTransition(
                                        //           sizeFactor: animation,
                                        //           axis: Axis.vertical,
                                        //           child: Container(
                                        //             margin: const EdgeInsets.symmetric(
                                        //               vertical: 4.0,
                                        //               horizontal: 8.0,
                                        //             ),
                                        //             decoration: BoxDecoration(
                                        //               color: Colors.transparent,
                                        //               border: Border.all(
                                        //                 width: 1,
                                        //                 style: BorderStyle.solid,
                                        //                 color: Colors.transparent,
                                        //               ),
                                        //               borderRadius: const BorderRadius.all(
                                        //                   Radius.circular(40)),
                                        //             ),
                                        //             padding: const EdgeInsets.fromLTRB(
                                        //                 0.0, 0.0, 0.0, 0.0),
                                        //           ),
                                        //         );
                                        //       },
                                        //     );
                                        //     setState(() {});
                                        //   },
                                        // ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: size.height * 0.01),
                                addNewStep(size),
                                SizedBox(height: size.height * 0.2)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                },
                {
                  'color': Colors.white,
                  'background': Colors.deepOrange,
                  'label': '5',
                  'content':  TextButton(
                      onPressed:(){

                      },
                      child: Text("Speichern")
                  )
                },
              ],
            ),
          ),
        ));
  }

  Widget photoContainer(Size size) {
    return Container(
      height: size.height * 0.4,
      width: size.width * 0.9,
      decoration: hasImage
          ? BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image.path),
            fit: BoxFit.cover,
          ),
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20))
          : BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20)),
      child: TextButton(
        onPressed: () {
          chooseFile();
        },
        child: hasImage
            ? null
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.camera_alt, color: Colors.white, size: 100)
          ],
        ),
      ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .then((file) {
      setState(() {
        image = File(file.path);
        hasImage = true;
      });
    });
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
          width: size.width * 0.6,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white),
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
                  Icon(Icons.add, color: Colors.white),
                  Text("Weitere Zutat hinzufügen",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily)),
                ],
              )),
        ),

      ],
    );
  }

  void _showMinutesPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
          width: size.width,
          height: 250,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 1),
            children: timeList
                .map((item) => Center(
              child: Text(item),
            ))
                .toList(),
            onSelectedItemChanged: (value) {
              setState(() {
                time = timeList.elementAt(value);
              });
            },
          ),
        ));
  }

  void _showPersonsPicker(BuildContext ctx, Size size) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
          width: size.width,
          height: 250,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: 1),
            children: personList
                .map((item) => Center(
              child: Text(item),
            ))
                .toList(),
            onSelectedItemChanged: (value) {
              setState(() {
                persons = personList.elementAt(value);
              });
            },
          ),
        ));
  }

  Widget difficultyButton(
      Size size, String text, Color color, bool isChosen, Function onPressed) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.2,
      decoration: BoxDecoration(
          color: isChosen ? color : Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: openSansFontFamily))),
      ),
    );
  }


  Widget addNewStep(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width * 0.6,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white),
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
                  Icon(Icons.add, color: Colors.white),
                  Text("Weiteren Schritt hinzufügen",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: openSansFontFamily)),
                ],
              )),
        ),

      ],
    );
  }

}
