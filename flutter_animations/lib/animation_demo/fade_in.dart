import 'package:flutter/cupertino.dart';
import 'package:flutter_animations/models/datas.dart';

class FadeInDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: FadeInImage(
          placeholder: AssetImage(Datas().flutter),
          image: NetworkImage("https://cdn.pixabay.com/photo/2017/04/01/02/06/surfing-2192775_960_720.jpg"),
        fadeInCurve: Curves.linear,
        //fadeOutCurve: Curves.linear,
        fadeInDuration: Duration(seconds: 1),
        //fadeOutDuration: Duration(seconds: 1),
      ),
    );
  }

}