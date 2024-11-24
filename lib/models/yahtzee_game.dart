
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/player.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';

class YahtzeeGame {  

  YahtzeeGame({
    required this.players,
    required this.variant}
    ) : controllers = {
          for (var name in players) name: YahtzeeController(model: YahtzeeModel())
        };

  final List<Player> players;
  final Map<Player, YahtzeeController> controllers;

  YahtzeeController? getController(Player player) {
    return controllers[player];
  }
  
  Variant variant;
}