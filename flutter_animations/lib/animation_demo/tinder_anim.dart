import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';
import 'package:flutter_animations/models/greek_city.dart';

class TinderAnimDemo extends StatefulWidget {
  _TinderState createState() => _TinderState();

}

class _TinderState extends State<TinderAnimDemo>  with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Duration _duration = Duration(milliseconds: 750);
  List<GreekCity> cities = Datas().cities;
  Animation<double> _turn;
  Animation<Offset> _move;

  CurvedAnimation _animation;
  bool isDetail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _duration);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    setupRotation(0.2);
    setupMove(-1);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: cards(),
    );
  }

  List<Widget> cards() {
    List<Widget> c = [];
    for (int x = 0; x< cities.length; x++) {
      double bottom = 10.0 * x + 20;
      double top = (5.0 - x) * 10;
      Card newTinderCard = tinderCard(cities[x]);
      if (x == 0) {
        RelativeRect rect = RelativeRect.fromLTRB(10, top, 10, bottom);

        RotationTransition transition  = RotationTransition(
          turns: _turn,
          child: newTinderCard
        );

        SlideTransition slide = SlideTransition(
            position: _move,
          child: transition,
        );

        AnimatedPositioned pos = AnimatedPositioned(
          child: slide,
          left: (isDetail) ? 0: rect.left,
          right: (isDetail) ? 0: rect.right,
          top: (isDetail) ? 0: rect.top,
          bottom: (isDetail) ? 0: rect.bottom,
          duration: _duration,
        );

        c.add(pos);
      } else {
        Positioned positioned = Positioned(
          child: newTinderCard,
          top: top,
          bottom: bottom,
          left: 10,
          right: 10,
        );
        c.add(positioned);
      }

    }

    return c.reversed.toList();
  }

  Card tinderCard(GreekCity city) {
    return Card(
      color: Colors.transparent,
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
              child: Text(city.name),
            ),
            Image.asset(city.image),
            Padding(
              padding: EdgeInsets.all(10),
              child: AnimatedCrossFade(
                  firstChild: btns(city.name),
                  secondChild: InkWell(
                    onTap: (() => setState(() => isDetail = !isDetail)),
                    child: Text(city.description),
                  ),
                  crossFadeState: (isDetail) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: _duration,
              )
            )
          ],
        ),
      ),
    );
  }
  
  Row btns(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FloatingActionButton(
          heroTag: name + "Like",
          child: Icon(Icons.thumb_up),
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            setState(() {
              setupRotation(-0.2);
              setupMove(-2);
              _animationController.forward();
            });
          },
        ),

        FloatingActionButton(
          heroTag: name + "Detail",
          child: Icon(Icons.search),
          backgroundColor: Colors.blue,
          onPressed: () {
            setState(() {
              isDetail = !isDetail;
            });
          },
        ),

        FloatingActionButton(
          heroTag: name + "Dislike",
          child: Icon(Icons.thumb_down),
          backgroundColor: Colors.redAccent,
          onPressed: () {
            setState(() {
              setupRotation(0.2);
              setupMove(2);
              _animationController.forward();
            });
          },
        )
      ],
    );
  }

  setupRotation(double value) {
    _turn = Tween<double>(begin: 0, end: value).animate(_animation);
  }

  setupMove(double value) {
    _move = Tween<Offset>(begin: Offset(0, 0), end: Offset(value, 0)).animate(_animation)..addListener(() {
      if (_move.isCompleted) {
        _animationController.reset();
        setState(() {
          GreekCity firstCity = cities[0];
          cities.removeAt(0);
          cities.add(firstCity);
        });
      }
    });
  }
}
