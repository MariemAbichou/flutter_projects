import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'dart:math' as math;

class AnimatedMenu extends StatefulWidget {
  _AnimatedMenuState createState() => _AnimatedMenuState();
}

class _AnimatedMenuState extends State<AnimatedMenu> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Duration _duration = Duration(seconds: 1);
  Animation<double> _scale;
  Animation<double> _move;
  Animation<double> _rotation;


  CurvedAnimation _curvedAnimation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _duration);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _scale = Tween<double>(begin: 1, end: 0).animate(_curvedAnimation);
    _move = Tween<double>(begin: 0, end: 75).animate(_curvedAnimation);
    _rotation = Tween<double>(begin: 0, end: math.pi * 4).animate(_curvedAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, builder) {
        return Transform.rotate(
            angle: _rotation.value,
          child: stack(),
        );
      },
    );
  }

  Stack stack() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        menuChoice(Icons.hearing, Colors.teal, "0", closeMenu, 0),
        menuChoice(Icons.hearing, Colors.deepPurpleAccent, "1", closeMenu, 90),
        menuChoice(Icons.hearing, Colors.white, "2", closeMenu, 180),
        menuChoice(Icons.hearing, Colors.green, "3", closeMenu, 270),
        Transform.scale(
            scale: _scale.value - 1,
          child: fab(Icons.close, Colors.red, "Close", closeMenu),
        ),
        Transform.scale(
            scale: _scale.value,
          child: fab(Icons.menu, Colors.blue, "Open", openMenu),
        ),
      ],
    );
  }

  FloatingActionButton fab(IconData icon, Color color, String tag, VoidCallback onPressed) {
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: onPressed,
      backgroundColor: color,
      heroTag: tag,
    );
  }

  FloatingActionButton menuFab(IconData icon, Color color, String tag) {
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: () {
        menuSelected(color);
      },
      backgroundColor: color,
      heroTag: tag,
    );
  }

  menuChoice(IconData icon, Color color, String tag, VoidCallback onPressed, double angle) {
    double radian = radians(angle);
    double x = (_move.value) * math.cos(radian);
    double y = (_move.value) * math.sin(radian);
    return Transform(
        transform: Matrix4.identity()..translate(x, y),
      child: menuFab(icon, color, tag),
    );
  }

  openMenu() {
    _animationController.forward();
  }

  closeMenu() {
    _animationController.reverse();
  }

  menuSelected(Color color) {
    closeMenu();
    Datas().pusher(context, color.toString(), Container(
      color: color,
    ));
  }
}