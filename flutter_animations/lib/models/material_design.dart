import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';

class MyDivider extends Divider {

  MyDivider():super(
    color: Colors.blue,
    thickness: 1
  );
}

class MyScaffold extends Scaffold {

  final String title;
  final Widget destination;

  MyScaffold({this.title, this.destination}): super(
    appBar: AppBar(title: Text(title),),
    body: destination
  );

}

class EmptyWidget extends Center {
  EmptyWidget(): super(
    child: Image.asset(Datas().flutter)
  );
}