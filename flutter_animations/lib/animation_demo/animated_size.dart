import 'package:flutter/material.dart';

class AnimatedSizeDemo extends StatefulWidget {
  _SizeState createState() => _SizeState();
}

class _SizeState extends State<AnimatedSizeDemo> with SingleTickerProviderStateMixin {

  bool isBig = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            isBig = !isBig;
          });
        },
        child: AnimatedSize(
            duration: Duration(seconds: 1),
            vsync: this,
          child: Container(
            height: (isBig) ? 300 : 150,
            width: (isBig) ? 300: 150,
            color: Colors.lightBlueAccent,
          ),
        )
      ),
    );
  }
}