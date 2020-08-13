import 'package:flutter/material.dart';
import 'package:flutter_animations/animation_demo/animated_builder.dart';
import 'package:flutter_animations/animation_demo/animated_container.dart';
import 'package:flutter_animations/animation_demo/animation_list_demo.dart';
import 'package:flutter_animations/animation_demo/animation_listener.dart';
import 'package:flutter_animations/animation_demo/graph.dart';
import 'package:flutter_animations/animation_demo/tinder_anim.dart';
import 'package:flutter_animations/models/datas.dart';
import 'package:flutter_animations/models/material_design.dart';
import 'package:flutter_animations/models/section.dart';
import 'package:flutter_animations/pages/hero_list.dart';
import 'package:flutter_animations/pages/menu_page.dart';
import 'package:flutter_animations/pages/other_animated_list.dart';
import 'package:flutter_animations/pages/transition_list.dart';
import 'package:flutter_animations/widgets/tile.dart';

class HomePage extends StatelessWidget {

  List<Section> _sections = [
    Section(name: "Animated Container", icon: Icons.score, destination: AnimatedContainerDemo()),
    Section(name: "Les autres animated", icon: Icons.local_movies, destination: OtherAnimatedList()),
    Section(name: "Hero", icon: Icons.flash_on, destination: HeroList()),
    Section(name: "Animated List", icon: Icons.list, destination: AnimationListDemo()),
    Section(name: "Transitions", icon: Icons.compare_arrows, destination: TransitionList()),
    Section(name: "Animated Builder", icon: Icons.build, destination: AnimatedBuilderDemo()),
    Section(name: "Graphique", icon: Icons.show_chart, destination: Graph()),
    Section(name: "Animation Listener", icon: Icons.hearing, destination: AnimationListenerDemo()),
    Section(name: "Menu animé", icon: Icons.menu, destination: MenuPage()),
    Section(name: "Animation Tinder", icon: Icons.photo_library, destination: TinderAnimDemo())
  ];
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: Image.asset(Datas().flutter),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          margin: EdgeInsets.all(5),
        ),
        title: Text("Les animations avec Flutter"),
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) => Tile(_sections[index])),
          separatorBuilder: ((context, index) => MyDivider()), 
          itemCount: _sections.length
      ),
    );
  }
  

}