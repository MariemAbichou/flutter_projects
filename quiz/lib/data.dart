import 'models/patient.dart';


Patient patient1 = new Patient('NourIi','   marie', Gender.FEMALE, DateTime(1982, 12, 26),  '003361214296968');

enum OrganeCible {Membre_Superieur,Membre_Inferieur,Tronc,Tete}
enum Gender { FEMALE, MALE }
enum Role { PATIENT, DOCTOR, ADMIN }
enum AvcType { Ischemique, Hemorragique}
enum AvcPosition {Hemisphere_Droit,Hemisphere_Gauche}
enum Trouble { Moteurs, Cognitifs }
enum Secteur {Public,Prive,Liberal,Autre}
enum Profession {Kinesitherapeute, Orthophoniste, Ergotherapeute, Medecin_MPR, Neurologue, Generaliste, Autre}

