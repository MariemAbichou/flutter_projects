import 'package:flutter/material.dart';

class CustomTextForTitle extends Text{
//constructeur
  CustomTextForTitle(String data, {textScaleFactor:1.5,color:Colors.pink, textAlign:TextAlign.center}):
        super(data,
        textAlign:textAlign,
        style:TextStyle(color:color),
        textScaleFactor:textScaleFactor,

      );
}

class CustomTextForDescription extends Text{
//constructeur
  CustomTextForDescription(String data, {textScaleFactor:1.0,color:Colors.black54, textAlign: TextAlign.justify}):
        super(data,
        textAlign:textAlign,
        style:TextStyle(color:color),
          textScaleFactor:textScaleFactor,
      );
}