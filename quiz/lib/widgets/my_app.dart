import 'package:flutter/material.dart';
import 'my_home.dart';


class MyApp extends StatelessWidget {
  String _titre= 'Frenchay arm test';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _titre,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: _titre),
      debugShowCheckedModeBanner: false,
    );
  }
}

