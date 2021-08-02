import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/screens/box_cover.dart';

class GameMenu extends StatefulWidget {
  GameMenu({Key? key}) : super(key: key);

  @override
  _GameMenuState createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: GridView.builder(
        itemCount: 100,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return BoxCover(image_id: 'co34ky', title: 'Nuclear2040 ke $index');
        },
      ),
    );
  }
}
