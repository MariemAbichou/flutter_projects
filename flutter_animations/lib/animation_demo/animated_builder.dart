import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';
import 'dart:math' as math;

class AnimatedBuilderDemo extends StatefulWidget {
  _BuilderState createState()=> _BuilderState();
}

class _BuilderState extends State<AnimatedBuilderDemo> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Image _image = Image.asset(Datas().flutter);
  Animation<double> _scale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this
    )..repeat();
    _scale = Tween<double>(begin: 0.1, end: 10).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: AnimatedBuilder(
          animation: _animationController,
          child: _image,
          builder: (context, child) {
            return Transform.scale(scale: _scale.value, child: child,);
//            return Transform.rotate(
//                angle: _animationController.value * 2 * math.pi,
//              child: child,
//            );
          }),
    );
  }
}