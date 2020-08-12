
import 'package:flutter/material.dart';
import 'package:quiz/models/patient.dart';
import '../data.dart';
import 'custom_text.dart';
import 'frenchay_arm_test.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  Patient patient;

  MyHomePage({Key key, this.title,this.patient}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(this.patient);
}

class _MyHomePageState extends State<MyHomePage> {
  int _nbrQuestions = 5;
  int _index=0;
  Patient _patient;
  //constructeur
  _MyHomePageState(Patient patient);

  void _incrementIndex() {
    if (_index<_nbrQuestions){setState(() { _index++; });}
    else if (_index>=_nbrQuestions){setState(() { _index=0; });}
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child:SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            Card(
              elevation: 10.0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Image.asset("assets/images/home.jpg", fit: BoxFit.cover,width: 120,),
                    Divider(),
                    RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FrenchayArmTest(patient: patient1),
                            ),
                          );

                          },
                        child:Text( "Start the quiz",style: TextStyle(color:Colors.white), )
                    ),
                  ]),)


              ),

            Divider(),
            CustomTextForTitle('Description'),
            CustomTextForDescription("This is a quick quiz in Computer Security",
                ),

            Divider(),

            Column(children: <Widget>[
              CustomTextForTitle("Reference:"),
              CustomTextForDescription(" https://www.studocu.com/en-us/document/new-york-city-college-of-technology/computer-systems-management-and-support/other/quiz2-sol-class-quiz-solution-with-questions/3507936/view"),
            ],),
          ],
        ),
      ),
      ),
    );
  }

}
