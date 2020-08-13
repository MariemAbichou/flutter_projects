import 'package:flutter/material.dart';
import 'package:flutter_animations/animation_demo/animation_controller.dart';
import 'package:flutter_animations/models/material_design.dart';
import 'package:flutter_animations/models/section.dart';
import 'package:flutter_animations/models/transition_type.dart';
import 'package:flutter_animations/widgets/tile.dart';

class TransitionList extends StatelessWidget {
  final List<Section> _sections = [
    Section(name: "DecoratedBox", icon: Icons.compare_arrows, destination: AnimationControllerDemo(TransitionType.decoratedBox)),
    Section(name: "Fade", icon: Icons.compare_arrows, destination: AnimationControllerDemo(TransitionType.fade)),
    Section(name: "Positionned", icon: Icons.compare_arrows, destination: AnimationControllerDemo(TransitionType.positionned)),
    Section(name: "Rotation", icon: Icons.compare_arrows, destination: AnimationControllerDemo(TransitionType.rotation)),
    Section(name: "Scale", icon: Icons.compare_arrows, destination: AnimationControllerDemo(TransitionType.scale)),
    Section(name: "Size", icon: Icons.compare_arrows, destination: AnimationControllerDemo(TransitionType.size)),
    Section(name: "Slide", icon: Icons.compare_arrows, destination: AnimationControllerDemo(TransitionType.slide)),
  ];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: ((context, i) => Tile(_sections[i])),
        separatorBuilder: ((context, i) => MyDivider()), 
        itemCount: _sections.length
    );
  }
  
  
}