import 'package:score_counter_app/models/player.dart';

/// An [Architect] is a player for the game akropolis
class Architect extends Player{
  Architect({
    required super.name,
    this.gamePlayed = 0,
    this.gameWin = 0,
    super.color,
    super.icon,
  });

  int gameWin;  
  int gamePlayed;

  double get winRatio => gameWin / gamePlayed * 100;

  /// Increment the number of game played and the number of victory by one. 
  void incrementVictory(){
    gamePlayed++;
    gameWin++;
  }

  /// Increment the number of game played by one.
  void incrementGamePlayed(){
    gamePlayed++;
  }
}
