import 'package:flutter/material.dart';
import 'package:flutter_animations/animation_demo/hero_widget.dart';
import 'package:flutter_animations/models/greek_city.dart';

class HeroDetail extends StatelessWidget {
  final HeroWidget hero;
  final GreekCity city;
  HeroDetail(this.city, this.hero);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        hero,
        Text(city.description)
      ],
    );
  }
}