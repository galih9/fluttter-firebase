import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/auth_concept/clouds.dart';
import 'package:flutter_blog_gg/auth_concept/stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class LoginPageConcept extends StatefulWidget {
  LoginPageConcept({Key? key}) : super(key: key);

  @override
  _LoginPageConceptState createState() => _LoginPageConceptState();
}

class _LoginPageConceptState extends State<LoginPageConcept>
    with SingleTickerProviderStateMixin {
  late AnimationController starsController;
  var random = Random();
  String type = "day";

  @override
  initState() {
    starsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          starsController.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    starsController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setAnimation());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          (type == "night") ? Colors.black : Colors.lightBlueAccent,
      body: Stack(
        children: [
          if (type == "night") ...[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            ...makeStar(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            Padding(
              padding: EdgeInsets.only(left: 6.h, top: 6.h),
              child: Image(
                image: const AssetImage(
                    "packages/flutter_blog_gg/assets/moon.png"),
                height: 15.h,
                width: 15.h,
              ),
            )
          ] else ...[
            Padding(
              padding: EdgeInsets.only(left: 30.h, top: 15.h),
              child: const Clouds(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.h, top: 20.h),
              child: const Clouds(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.h, top: 6.h),
              child: Image(
                image:
                    const AssetImage("packages/flutter_blog_gg/assets/sun.png"),
                height: 15.h,
                width: 15.h,
              ),
            )
          ],
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                children: [
                  Text(
                    "Welcome",
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(fontSize: 30.sp),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> makeStar(double width, double height) {
    double starsInRow = width / 50;
    double starsInColumn = height / 50;
    double starsNum = starsInRow != 0
        ? starsInRow * (starsInColumn != 0 ? starsInColumn : starsInRow)
        : starsInColumn;

    List<Widget> stars = [];

    for (int i = 0; i < starsNum; i++) {
      stars.add(Star(
        top: random.nextInt(height.floor()).toDouble(),
        right: random.nextInt(width.floor()).toDouble(),
        animationController: starsController,
      ));
    }

    return stars;
  }
}
