import 'package:flutter/material.dart';

class AnimatedContainerDemo extends StatefulWidget {

  _AnimatedContainerState createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainerDemo> {

  Duration _duration = Duration(seconds: 2);
  double min = 0;
  double max = 300;
  double heightValue = 150;
  double widthValue = 150;
  Color _color = Colors.blue;
  bool shadow = true;
  bool radius = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(15),),
        AnimatedContainer(
          height: heightValue,
            width: widthValue,
            decoration: BoxDecoration(
              color:_color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: (shadow) ? Offset(3, 0): Offset(0, 0),
                  spreadRadius: (shadow) ?2.5 : 0,
                  blurRadius: (shadow)?3 : 0
                ),
              ],
              borderRadius: (radius) ? BorderRadius.circular(25) : BorderRadius.circular(0)
            ),
            duration: _duration,
          curve: Curves.linear,
        ),
        Padding(padding: EdgeInsets.all(15),),
        Expanded(
         child: ListView(
           children: <Widget>[
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 colorButton("Bleu", Colors.blue),
                 colorButton("Rouge", Colors.red),
                 colorButton("Vert", Colors.green)
               ],
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text("Hauteur: ${heightValue.round()}"),
                 Slider(
                   min: min,
                     max: max,
                     value: heightValue,
                     onChanged: ((newValue) => setState(() => heightValue = newValue)))
               ],
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text("Largeur: ${widthValue.round()}"),
                 Slider(
                     min: min,
                     max: max,
                     value: widthValue,
                     onChanged: ((newValue) => setState(() => widthValue = newValue)))
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text("Shadow: $shadow"),
                 Switch(value: shadow, onChanged: ((newValue) => setState(() =>shadow = newValue)))
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 Text("Radius: $radius"),
                 Switch(value: radius, onChanged: ((newValue) => setState(() =>radius = newValue)))
               ],
             ),
           ],
         ),
        )
      ],
    );
  }
  
  FloatingActionButton colorButton(String name, Color color) {
    return FloatingActionButton(
      backgroundColor: color,
        heroTag: name,
        onPressed: (() => setState(() => _color = color)));
  }

}