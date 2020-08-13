import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';
class AnimatedPositionningDemo extends StatefulWidget {
  _PosState createState() => _PosState();
}

class _PosState extends State<AnimatedPositionningDemo> {

  bool isConnected = false;
  Duration duration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double max = size.width * 0.8;
    double centerTop = max / 2 - 20;
    double centerBottom = max / 2 - 20;
    return Center(
      child: Container(
          height: max,
          width: max,
          child: Card(
            elevation: 8,
            child: InkWell(
              onTap: () {
                setState(() {
                  isConnected = !isConnected;
                });
              },
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    child: TextField(decoration: InputDecoration(hintText: "Entrez mail"),),
                    left: 10,
                    right: 10,
                    bottom: centerBottom,
                    top: centerTop,
                    duration: duration,
                  ),
                  AnimatedPositioned(
                    child: TextField(decoration: InputDecoration(hintText: "Entrez mot de passe"),),
                    left: 10,
                    right: 10,
                    bottom: (isConnected) ? centerBottom : 10,
                    top: (isConnected) ? centerTop : max - 40,
                    duration: duration,
                  ),
                  AnimatedPositioned(
                    child: AnimatedContainer(
                      child: Image.asset(Datas().flutter, fit: BoxFit.contain,),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                          borderRadius: BorderRadius.circular(isConnected ? 0 : 50)),
                      duration: duration,
                    ),
                    top: (isConnected) ? 0 : 10,
                    bottom: (isConnected) ? 0 : max - 100,
                    left: (isConnected) ? 0 : 10,
                    right: (isConnected) ? 0 : max - 100,
                    duration: duration,
                  )

                ],
              ),
            )
          )
      )
    );
  }

}