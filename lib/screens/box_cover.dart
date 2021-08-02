import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BoxCover extends StatelessWidget {
  final String image_id;
  final String title;
  const BoxCover({Key? key, required this.image_id, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: 50.w,
          height: 100.h,
          child: Image(
            image: NetworkImage(
                'https://images.igdb.com/igdb/image/upload/t_cover_big/$image_id.jpg'),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      // bottomLeft
                      offset: Offset(-0.5, -0.5),
                      color: Colors.black),
                  Shadow(
                      // bottomRight
                      offset: Offset(0.5, -0.5),
                      color: Colors.black),
                  Shadow(
                      // topRight
                      offset: Offset(0.5, 0.5),
                      color: Colors.black),
                  Shadow(
                      // topLeft
                      offset: Offset(-0.5, 0.5),
                      color: Colors.black),
                ]),
          ),
        )
      ],
    );
  }
}
