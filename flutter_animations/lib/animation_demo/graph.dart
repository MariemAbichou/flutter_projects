import 'package:flutter/material.dart';
import 'package:flutter_animations/models/exercise.dart';
import 'dart:math' as math;

class Graph extends StatefulWidget {
 _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  List<Exercise>  exercises = [
    Exercise(0),
    Exercise(1),
    Exercise(2),
    Exercise(3)
  ];

  int currentWeek = 0;


  @override
  Widget build(BuildContext context) {
    double max = MediaQuery.of(context).size.width* 0.9;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Semaine numéro ${currentWeek + 1}"),
        Container(width: max, height: max, child: Card(
          child: charts(max, exercises[currentWeek]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text("Précédent"),
              onPressed: () {
                setState(() {
                  if (currentWeek > 0) {
                    currentWeek -= 1;
                  }
                });
              },
            ),
            FlatButton(
              child: Text("Suivant"),
              onPressed: () {
                setState(() {
                  if (currentWeek < exercises.length - 1) {
                    currentWeek += 1;
                  }
                });

              },
            ),
          ],
        )

      ],
    );
  }

  Row charts(double max, Exercise exercise) {
    print(exercise.runs.length);
    double width = max / 10;
    int maxRun = exercise.runs.reduce(math.max);
    double ratio = max / maxRun;
    List<AnimatedContainer> containers = [];
    exercise.runs.forEach((run) {
      Color color = getColor(run, maxRun);
      containers.add(container(width, ratio * run, run, color));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: containers,
    );
  }

  Color getColor(int value, int max) {
    if ((max * 0.75) < value) {
      return Colors.green;
    } else if ((max * 0.5) < value) {
      return Colors.yellow;
    } else if ((max * 0.25) < value) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  AnimatedContainer container(double width, double height, int value, Color color) {
    return AnimatedContainer(
      width: width,
      height: height,
      color: color,
      curve: Curves.linear,
        duration: Duration(seconds: 1),
      child: Center(child: Text(value.toString()),),
    );
  }
}