import 'package:score_counter_app/models/architect.dart';
import 'package:score_counter_app/models/city.dart';

/// Represent a party of Akropolis.
class AkropolisPartyModel {
  AkropolisPartyModel({
    required this.architects,
  });
  final List<Architect> architects;
  bool partyStarted = false;

  Map<Architect,CityModel> architects2CityModel = {};

  /// Build the cityModel for each architect.
  void startParty(){
    for(var player in architects){
      architects2CityModel[player] = CityModel();
    }
    partyStarted = true;
  }

  void endParty(){
    if(partyStarted){
      var winners = getWinners();
      for(var architect in architects)
      {
        if(winners.contains(architect)){
          architect.incrementVictory();
        }
        architect.incrementGamePlayed();
      }
    }
    partyStarted = false;
  }

  void stopParty(){
    architects2CityModel = {};
    partyStarted = false;
  }
  
  /// Return the cityModel for [architect]
  CityModel? getCity(Architect architect){
    return architects2CityModel[architect];
  }

  List<Architect> getWinners(){
    var winners = architects2CityModel;
    if(partyStarted){
      // Trouver le score maximum
      int maxScore = architects2CityModel.values.reduce((a, b) => a.score > b.score ? a : b).score;
      // Filtrer les joueurs avec ce score maximum
      winners.removeWhere((architect,model)=>model.score < maxScore);
    }
    return winners.keys.toList();
  }

  //Doit renvoyer une map avec le classement pour pouvoir avoir des doublons de classement
  List<Architect> getRanking(){
    var playerSorted = architects2CityModel;
    // Convertir la Map en une liste de MapEntry
    playerSorted.entries.toList().sort((a, b) => b.value.score.compareTo(a.value.score)); // Tri en ordre décroissant
    return playerSorted.keys.toList();
  }

  int getArchitectRanking(Architect architect){
    return getRanking().indexOf(architect);
  }
}

  
