import 'package:score_counter_app/models/city.dart';
import 'package:score_counter_app/models/player.dart';

/// Represent a party of Akropolis.
class AkropolisPartyModel {
  AkropolisPartyModel({
    required this.players,
  });
  final List<Player> players;
  Map<Player,CityModel> players2CityModel = Map();


  void initParty(){
    for(var player in players){
      players2CityModel[player] = CityModel();
    }
  }

  CityModel? getCity(Player player){
    return players2CityModel[player];
  }
}

  
