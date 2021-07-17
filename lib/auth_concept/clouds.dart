import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Clouds extends StatefulWidget {
  const Clouds({Key? key}) : super(key: key);

  @override
  _CloudsState createState() => _CloudsState();
}

class _CloudsState extends State<Clouds> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController cloudController;

  @override
  initState() {
    super.initState();
    cloudController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 80, end: 100).animate(cloudController);
    // controller.repeat();
    cloudController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (ctx, child) {
        return Container(
          child: Image(
            image:
                const AssetImage("packages/flutter_blog_gg/assets/cloud.png"),
            height: 25.h,
            width: 25.h,
          ),
          alignment: Alignment.center,
          width: animation.value,
          height: animation.value,
        );
      },
    );
  }

  @override
  void dispose() {
    // release resources
    cloudController.dispose();
    super.dispose();
  }
}
