import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedTextStyleDemo extends StatefulWidget {
  _TextState createState() => _TextState();
}

class _TextState extends State<AnimatedTextStyleDemo> {

  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            isFirst = !isFirst;
          });
        },
        child: AnimatedDefaultTextStyle(
            child: Text("Tap to change"),
            style: (isFirst) ? firstStyle(): secondStyle(),
            duration: Duration(seconds: 2)
        ),
      )
    );
  }

  TextStyle firstStyle() {
    return TextStyle(
      color: Colors.orange,
      fontSize: 40,
      fontWeight: FontWeight.w100,
      //fontStyle: FontStyle.italic
    );
  }

  TextStyle secondStyle() {
    return TextStyle(
        color: Colors.teal,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        //fontStyle: FontStyle.normal
    );
  }
}