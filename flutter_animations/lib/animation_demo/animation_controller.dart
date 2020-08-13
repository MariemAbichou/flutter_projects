import 'package:flutter/material.dart';
import 'package:flutter_animations/models/datas.dart';
import 'package:flutter_animations/models/material_design.dart';
import 'package:flutter_animations/models/transition_type.dart';

class AnimationControllerDemo extends StatefulWidget {
  final TransitionType type;

  AnimationControllerDemo(this.type);

  _DemoState createState() => _DemoState();
}

class _DemoState extends State<AnimationControllerDemo> with SingleTickerProviderStateMixin {

  Image _image = Image.asset(Datas().flutter);
  AnimationController _animationController;
  Duration _duration = Duration(seconds: 1);
  DecorationTween _decorationTween;
  Animation<Decoration> _animationDecoration;
  CurvedAnimation _curvedAnimation;
  bool isAnim = false;
  double max;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _duration,
        vsync: this
    );
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.linear);
    setupDecoration();
  }

  setupDecoration() {
    BoxDecoration begin = BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(15));
    BoxDecoration end = BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(500));
    _decorationTween = DecorationTween(begin: begin, end: end);
    _animationDecoration = _decorationTween.animate(_curvedAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    max = size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: max,
          width: max,
          child: Center(
            child: transition(),
          ),
        ),
        FlatButton(
          child: Text("Faire la transition"),
          onPressed: () {
            performTransition();
          },
        )
      ],
    );
  }

  Widget transition() {
    switch(widget.type) {
      case TransitionType.decoratedBox: return decoratedBox();
      case TransitionType.fade: return fade();
      case TransitionType.positionned: return positioned();
      case TransitionType.rotation: return rotation();
      case TransitionType.scale: return scale();
      case TransitionType.size: return size();
      case TransitionType.slide: return slide();
      default: return EmptyWidget();
    }
  }

  DecoratedBoxTransition decoratedBox() {
    return DecoratedBoxTransition(
      decoration: _animationDecoration,
      child: _image,
    );
  }

  FadeTransition fade() {
    return FadeTransition(
      child: _image,
        opacity: CurvedAnimation(parent: _animationController,curve: Curves.easeOut)
        //Tween<double>(begin: 1, end: 0.33).animate(CurvedAnimation(parent: _animationController,curve: Curves.easeOut))
    );
  }

  Widget positioned() {
    return Stack(
      children: <Widget>[

        PositionedTransition(
          child: Container(color: Colors.orange),
          rect: RelativeRectTween(
            begin: RelativeRect.fromLTRB(0, 0, 0, 0),
            end: RelativeRect.fromLTRB(max, max, max, max)
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear)),
        ),
        PositionedTransition(
            rect: RelativeRectTween(
                begin: RelativeRect.fromLTRB(0, 0, 0, 0),
                end: RelativeRect.fromLTRB(200, 250, 0, 0)
            ).animate(_curvedAnimation),
            child: _image
        ),
      ],
    );
  }
  RotationTransition rotation() {
    Tween<double> tween = Tween<double>(begin: 0, end: 0.5);
    return RotationTransition(
        turns: tween.animate(_curvedAnimation),
      child: _image,
    );
  }

  ScaleTransition scale() {
    return ScaleTransition(
      child: _image,
        scale: Tween<double>(begin: 1, end: 0.15).animate(_curvedAnimation));
  }

  SizeTransition size() {
    return SizeTransition(
      child: _image,
      sizeFactor: Tween<double>(begin: 1, end: 0.2).animate(_curvedAnimation),
      axis: Axis.horizontal,
    );
  }
  
  SlideTransition slide() {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(-0.5, -0.5), end: Offset(0, 0)).animate(_curvedAnimation),
      child: _image,
    );
  }



  performTransition() {
    if (isAnim) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    isAnim = !isAnim;
  }
}