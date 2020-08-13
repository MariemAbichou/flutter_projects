import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';

class AnimatedOpacityDemo extends StatefulWidget {
 _OpacityState createState() => _OpacityState();
}

class _OpacityState extends State<AnimatedOpacityDemo> {
  bool isOpacity = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children(),
    );
  }

  List<Widget> children() {
    List<Widget> c = [];
    c.add(Text("Opacité"));
    c.add(AnimatedOpacity(
        opacity: (isOpacity) ? 0: 1,
        duration: Duration(seconds: 3),
      child: Image.asset(Datas().flutter),
    )
    );
    c.add(FlatButton(onPressed: () {
        setState(() {
          isOpacity = !isOpacity;
        });
      },
          child: Text((isOpacity)? "Montrer": "cacher")));
      return c;
  }
}