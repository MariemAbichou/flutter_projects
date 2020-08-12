import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/evaluation.dart';
import 'package:quiz/models/patient.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/widgets/custom_text.dart';
import 'package:quiz/widgets/my_app.dart';
import 'package:quiz/widgets/my_home.dart';

import '../data.dart';

class FrenchayArmTest extends StatefulWidget {
  Patient patient;

  FrenchayArmTest({Key key, this.patient}) : super(key: key);

  @override
  _FrenchayArmTestState createState() => _FrenchayArmTestState(this.patient);
}

class _FrenchayArmTestState extends State<FrenchayArmTest> {

  _FrenchayArmTestState(Patient patient);

  Evaluation _eval= new Evaluation("Quiz", "Introduction to Computer Security", 0);
  Question question;
  List<Question> listeQuestions = [
    new Question("An advance-fee fraud attack involves the interceptionof cryptographic elements to determine keys and encryption algorithms.", false, '', 'img1.JPG'),
    new Question("Much human error or failure can be prevented with effective training and ongoing awareness activities", true, '','img2.jpg'),
    new Question("A worm requires that another program is running before it can begin functioning.", false, '', 'img3.jpg'),
    new Question("Information security’s primary mission is to ensure that systems and their contents retain their confidentiality at any cost.", false, '', 'img4.jpg'),
    new Question("With the removal of copyright protection mechanisms, software can be easily distributed and installed.", true, '', 'img5.jpg'),
  ];
  int _index=0;
  int _score=0;

  @override
  void initState(){
    super.initState();
    question=listeQuestions[_index];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: <Widget>[
          Text("Frenchay arm test",textScaleFactor: 1,),
          Spacer(),
          Text("patient ${widget.patient.name}",style: TextStyle(color: Colors.amberAccent,fontStyle: FontStyle.italic,),textScaleFactor: 0.7,),
        ],)
      ),

      body: Center(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomTextForTitle("Q${_index+1}"),
            Container(child: CustomTextForDescription("${listeQuestions[_index].question}"),height: 50,padding: EdgeInsets.all(10) ,),
            Card(
              child:Container(
                width: MediaQuery.of(context).size.width*0.6,
                height: MediaQuery.of(context).size.width*0.6,
                child: Image.asset("assets/images/${listeQuestions[_index].imagePath}",fit: BoxFit.fill,),

              ),
            ),
            Column(children: <Widget>[
             
              Row(children: <Widget>[
                Spacer(),
                FlatButton(
                  child:Text( "OUI",style: TextStyle(color:Colors.white), ),
                  color: Colors.blue,
                  onPressed: () {

                    setState(() {
                      _score++;
                      if(_index<listeQuestions.length-1){
                        _index++;}
                      else if (_index==listeQuestions.length-1) {
                        //_index=0;
                       // _eval.score=_score;
                        //widget.patient.listEvaluation.add(_eval);
                        //print(widget.patient.listEvaluation[0].score);

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text("Bravo !"),
                                content:Text("Vous avez ajouté l'évaluation à votre patient ${widget.patient.name}.\n Son score est $_score /5 \n Vous confirmez ce résultat?") ,
                                actions: <Widget>[
                                  CupertinoDialogAction(child: Text("Oui",),  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push( context,MaterialPageRoute( builder: (context) => MyApp()),);

                                  }, ),
                                  CupertinoDialogAction(child: Text("Non, Je souhaite refaire le test",),  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push( context,MaterialPageRoute( builder: (context) => FrenchayArmTest(patient: patient1)),);

                                  }, ),

                                ],
                              );
                            });


                                              }

                    });
                    print("Q${_index+1}  | score total: $_score");
                  },
                ),
                Spacer(),
                FlatButton(
                  child:Text( "NON",style: TextStyle(color:Colors.white), ),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      print("Q${_index+1}  | score total: $_score");
                      if(_index<listeQuestions.length-1){
                        _index++;}
                      else if (_index==listeQuestions.length-1) {
                        //_index=0;
                        //_eval.score=_score;
                       // widget.patient.listEvaluation.add(_eval);
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text("Bravo !"),
                                content:Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[

                                  Text("Vous avez évaluaer votre patient ${widget.patient.name}.") ,

                                  Text("\n Son score est : $_score /5 ") ,

                                  Text("\n Vous confirmez ce résultat?"),
                                ],),
                                actions: <Widget>[
                                  CupertinoDialogAction(child: Text("Oui",),  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push( context,MaterialPageRoute( builder: (context) => MyApp()),);

                                  }, ),

                                  CupertinoDialogAction(child: Text("Non, Je souhaite refaire le test",),  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push( context,MaterialPageRoute( builder: (context) => FrenchayArmTest(patient: patient1)),);

                                  }, ),

                                ],
                              );
                            });
                      }

                    });
                  },
                ),
                Spacer(),
              ],),
            ],),

            CustomTextForTitle("Score: $_score/${listeQuestions.length}"),
            //_widgetOptions.elementAt(_selectedIndex),


          ],
        ),
      )),
    );
  }
}
