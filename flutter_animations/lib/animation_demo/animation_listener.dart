import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';

class AnimationListenerDemo extends StatefulWidget {
  _ListenerState createState() => _ListenerState();
}

class _ListenerState extends State<AnimationListenerDemo> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Duration _duration = Duration(seconds: 3);
  Animation<double> _animation;
  bool opacity = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _duration);
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear))
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          opacity = true;
        });
        //_animationController.reverse();
        //Datas().pusher(context, "Apres animation", Center(child: Text("Nouvelle page"),));
      } else if (status == AnimationStatus.dismissed) {
        //_animationController.forward();
      }
    });
//    ..addListener(() {
//      print(_animationController.value);
//      if (_animationController.isCompleted) {
//        _animationController.reverse();
//      } else if (_animationController.isDismissed) {
//        _animationController.forward();
//      }
//    });
    _animationController.forward();
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
      child: RotationTransition(
          turns: _animation,
        child: AnimatedOpacity(
            opacity: (opacity)? 0.2 : 1,
            duration: _duration,
          child: Image.asset(Datas().flutter),
        ),
      ),
    );
  }
}