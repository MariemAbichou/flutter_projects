import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';
import 'package:flutter_animations/models/section.dart';

class Tile extends StatelessWidget {

  final Section section;

  Tile(this.section);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      leading: Icon(section.icon),
      title: Text(section.name),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: (() => Datas().pusher(context, section.name, section.destination)),
    );
  }

}