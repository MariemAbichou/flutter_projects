import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';

class AnimatedCrossFadeDemo extends StatefulWidget {
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<AnimatedCrossFadeDemo> {

  bool cross = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: InkWell(
          child: AnimatedCrossFade(
            firstChild: Image.asset(Datas().flutter),
            secondChild: Text("Retour à l'image", style: TextStyle(fontSize: 30),),
            crossFadeState: (cross) ? CrossFadeState.showFirst: CrossFadeState.showSecond,
            duration: Duration(seconds: 1),
          ),
        onTap: () {
            setState(() {
              cross = !cross;
            });
        },
      )

    );
  }
}