
import 'package:quiz/models/question.dart';


class Evaluation {

  //-------- attributes
  DateTime dateEval;
  String nom;
  String description;
  String reference;
 // OrganeCible organeCible;
  List<Question> questionnaire;
  int score;


  //-------- Constructor, with params
  Evaluation(String nom, String description, int score
      //OrganeCible organeCible
      ) {
    var _nom = nom.trim();
    var _description = description.trim();
    this.nom = _nom.toUpperCase();
    this.description = _description.substring(0, 1).toUpperCase() +_description.substring(1, _description.length).toLowerCase();
    //this.organeCible=organeCible;
    this.questionnaire = questionnaire;
    this.score=score;
  }

}
