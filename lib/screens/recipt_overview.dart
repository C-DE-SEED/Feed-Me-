import 'package:feed_me/constants/colors.dart';
import 'package:feed_me/constants/feed_me_circle_avatar.dart';
import 'package:feed_me/constants/recipt_preview_image.dart';
import 'package:feed_me/constants/search_text_form_field.dart';
import 'package:feed_me/constants/text_style.dart';
import 'package:flutter/material.dart';

class ReciptOverview extends StatefulWidget {
  const ReciptOverview({Key key}) : super(key: key);

  @override
  _ReciptOverviewState createState() => _ReciptOverviewState();
}

class _ReciptOverviewState extends State<ReciptOverview> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: BasicGreen,
            expandedHeight: 150.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Hauptgerichte',
                style: TextStyle(
                  fontFamily: openSansFontFamily,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: ReciptPreviewImage(
                  isTitle: true,
                  image: "assets/testImages/11.jpg",
                  fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                color: BasicGreen,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SearchTextFormField(
                        hintText: "Nach Rezepten suchen",
                      )
                    ],
                  ),
                )),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.025)),
          SliverPadding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                  crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildItems(index, context);
                },
                childCount: 17,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: size.height * 0.025)),
          SliverToBoxAdapter(
            child: Container(
                height: size.height * 0.1,
                color: BasicGreen,
                child: const FeedMeCircleAvatar(radius: 60)),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(int index, BuildContext context) {
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () => () {},
        child: Column(
          children: <Widget>[
            Expanded(
                child: Hero(
                    tag: "item$index",
                    child: ReciptPreviewImage(
                        isTitle: false,
                        image: "assets/testImages/$index.jpg",
                        fit: BoxFit.cover))),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Gericht $index',
              softWrap: true,
              style: const TextStyle(
                  fontFamily: openSansFontFamily,
                  color: Colors.black,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
