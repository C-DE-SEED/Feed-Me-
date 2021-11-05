import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/cook_book_row.dart';
import 'package:feed_me/constants/search_text_form_field.dart';
import 'package:feed_me/registration_and_login/auth_service.dart';
import 'package:feed_me/screens/create_new_cooking_book.dart';
import 'package:feed_me/screens/create_new_recipt.dart';
import 'package:feed_me/user/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicorndial/unicorndial.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthService authService = AuthService();
    List<UnicornButton> childButtons = [];

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Neues Rezeptbuch",
        currentButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateNewCookingBook()));
          },
          heroTag: "book",
          backgroundColor: BasicGreen,
          mini: true,
          child: const Icon(Icons.menu_book),
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Neues Rezept",
        currentButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateNewRecipt()));
            },
            heroTag: "recipt",
            backgroundColor: Colors.white,
            mini: true,
            child:
                const Icon(Icons.sticky_note_2_outlined, color: BasicGreen))));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Mein Profil",
        currentButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
          heroTag: "profile",
          backgroundColor: Colors.grey,
          mini: true,
          child: CircleAvatar(
            backgroundImage: NetworkImage(authService.getUser().photoURL),
            radius: 40,
            backgroundColor: Colors.black,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              },
              child: null,
            ),
          ),
        )));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: BasicGreen,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(authService.getUser().photoURL),
              radius: 40,
              backgroundColor: Colors.black,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                child: null,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.6, 0.0, 0.0, 0.0),
        child: UnicornDialer(
            backgroundColor: Colors.transparent,
            parentButtonBackground: BasicGreen,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: const Icon(Icons.add),
            childButtons: childButtons),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.3,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.zero, bottom: Radius.circular(30)),
                  color: BasicGreen,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: BasicGreen,
                      radius: size.width * 0.15,
                      child: CircleAvatar(
                          backgroundImage: const AssetImage(
                              'assets/feedmelogo_without_border'
                              '.png'),
                          radius: size.width * 0.2125,
                          backgroundColor: Colors.transparent),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    const SearchTextFormField(
                      hintText: "Nach Rezepten suchen",
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return const CookBookRow(
                        name1: "Leckeres Essen",
                        // name2: "Vegie 4Life",
                        objectID1: "objectId1",
                        // objectID2: "objectid2",
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
