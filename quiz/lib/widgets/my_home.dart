
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
                        child:Text( "Commencez l'évaluation",style: TextStyle(color:Colors.white), )
                    ),
                  ]),)


              ),

            Divider(),
            CustomTextForTitle('Description'),
            CustomTextForDescription("Cette évaluation de l’extrémité supérieure permet de vérifier l’utilisation du bras et d'associer amplitudes passives, tonus musculaire, examen de la douleur, dynamométrie de la pince pouce-index.",
                ),

            Divider(),
            CustomTextForTitle("Matériel nécessaire:"),
            CustomTextForDescription("""
    - Crayon en graphite ou stylo, règle, feuille de papier
    - Cylindre (12 mm x 5 cm)
    - Gobelet
    - Pince à linge à ressort
    - bâton de 10 mm de diamètre
    - Peigne à cheveux. """),
            Divider(),
            Column(children: <Widget>[
              CustomTextForTitle("Référence"),
              CustomTextForDescription(" Heller A, Wade DT, Wood VA, Sunderland A, Langton-Hewer R, Ward E. Arm function after stroke : measurement and recovery after the first three months. J Neurol Neurosurg Psychiatry 1987 ; 50 : 714-9"),
            ],),
          ],
        ),
      ),
      ),
    );
  }

}
