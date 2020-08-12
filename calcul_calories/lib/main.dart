import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcul de calories',
      theme:  ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Calcul de calories'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int calorieBase;
  int calorieAvecActivite;
  int radioSelectionnee;
  double poids;
  double age;
  bool genre = false;
  double taille = 170.0;
  Map mapActivite = {
    0: "Faible",
    1: "Modere",
    2: "Forte"
  };

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus( FocusNode())),
      child:  Scaffold(
        appBar:  AppBar(
          title:  Text(widget.title),
          backgroundColor: setColor(),
        ),
        body:  Container(
          color: Colors.black54,

          child:SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              padding(),
              texteAvecStyle("Remplissez tous les champs pour obtenir votre besoin journalier en calories.",fontSize: 15.0,color:Colors.white),
              padding(),
              Card(
                elevation: 20.0,
                child:  Column(
                  children: <Widget>[
                    padding(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        texteAvecStyle("Femme", color: Colors.redAccent),
                        Switch(
                            value: genre,
                            inactiveTrackColor: Colors.redAccent,
                            activeTrackColor: Colors.blueGrey,
                            onChanged: (bool b) {
                              setState(() {
                                genre = b;
                              });
                            }),
                        texteAvecStyle("Homme", color: Colors.blueGrey)
                      ],
                    ),
                    padding(),
                    RaisedButton(
                        color: setColor(),
                        child: texteAvecStyle((age == null)? "Appuyez pour entrer votre age": "Votre age est de : ${age.toInt()}",
                            color: Colors.white
                        ),
                        onPressed: (() => montrerPicker())
                    ),
                    padding(),
                    texteAvecStyle("Votre taille est de: ${taille.toInt()} cm.", color: setColor()),
                    padding(),
                    Slider(
                      value: taille,
                      divisions: 10,
                      activeColor: setColor(),
                      onChanged: (double d) {
                        setState(() {
                          taille = d;
                        });
                      },
                      max: 215.0,
                      min: 100.0,
                    ),
                    padding(),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String string) {
                        setState(() {
                          poids = double.tryParse(string);
                        });
                      },
                      decoration:  InputDecoration(
                          labelText: "Entrez votre poids en kilos."
                      ),
                    ),
                    padding(),
                    texteAvecStyle("Quelle est votre activité sportive?", color: setColor()),
                    padding(),
                    rowRadio(),
                    padding()
                  ],
                ),
              ),
              padding(),
              RaisedButton(
                color: setColor(),
                child: texteAvecStyle("Calculer", color: Colors.white),
                onPressed: calculerNombreDeCalories,
              )
            ],
          ),
        ),
      ),
    ),);


  }


  Padding padding() {
    return  Padding(padding: EdgeInsets.only(top: 10.0));
  }

  Future<Null> montrerPicker() async {
    DateTime choix = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate:  DateTime(1900),
        lastDate:  DateTime.now(),
        initialDatePickerMode: DatePickerMode.year
    );
    if (choix != null) {
      var difference =  DateTime.now().difference(choix);
      var jours = difference.inDays;
      var ans = (jours / 365);
      setState(() {
        age = ans;
      });
    }
  }


  Color setColor() {
    if (genre) {
      return Colors.blueGrey;
    } else {
      return Colors.redAccent;
    }
  }

  Text texteAvecStyle(String data, {color: Colors.black, fontSize: 15.0}) {
    return  Text(
        data,
        textAlign: TextAlign.center,
        style:  TextStyle(
            color: color,
            fontSize: fontSize
        )
    );
  }

  Row rowRadio() {
    List<Widget> l = [];
    mapActivite.forEach((key, value) {
      Column colonne =  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
              activeColor: setColor(),
              value: key,
              groupValue: radioSelectionnee,
              onChanged: (Object i) {
                setState(() {
                  radioSelectionnee = i;

                });
              }),
          texteAvecStyle(value, color: setColor())
        ],
      );
      l.add(colonne);
    });
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

  void calculerNombreDeCalories() {
    if (age != null && poids != null && radioSelectionnee != null) {
      //Calculer
      if (genre) {
        calorieBase = (66.4730 + (13.7516 * poids) + (5.0033 * taille) - (6.7550 * age)).toInt();
      } else {
        calorieBase = (655.0955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age)).toInt();
      }
      switch(radioSelectionnee) {
        case 0:
          calorieAvecActivite = (calorieBase * 1.2).toInt();
          break;
        case 1:
          calorieAvecActivite = (calorieBase * 1.5).toInt();
          break;
        case 2:
          calorieAvecActivite = (calorieBase * 1.8).toInt();
          break;
        default:
          calorieAvecActivite = calorieBase;
          break;
      }

      setState(() {
        dialogue();
      });

    } else {
      alerte();
    }
  }

  Future<Null> dialogue() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            title: texteAvecStyle("Votre besoin en calories", color: setColor()),
            contentPadding: EdgeInsets.all(15.0),
            children: <Widget>[
              padding(),
              texteAvecStyle("Votre besoin de base est de: $calorieBase"),
              padding(),
              texteAvecStyle("Votre besoin avec activité sportive est de : $calorieAvecActivite"),
              RaisedButton(onPressed: () {
                Navigator.pop(buildContext);
              },
                child: texteAvecStyle("OK", color: Colors.white),
                color: setColor(),
              )
            ],
          );
        }
    );
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return  AlertDialog(
            title: texteAvecStyle("Erreur"),
            content: texteAvecStyle("Tous les champs ne sont pas remplis"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(buildContext);
                  },
                  child: texteAvecStyle("OK", color: Colors.red))
            ],
          );
        }
    );
  }
}
