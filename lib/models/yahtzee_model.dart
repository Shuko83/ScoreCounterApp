
///Represent the model of a Yahtzee Game
class YahtzeeModel {

  /// Represents the number of dice for the [DiceValue]
  Map<DiceValue,int> numberOfDiceValue = {};

  /// Stock the [State] of the [YahtzeeFigure]. 
  /// Si la figure n'est pas dans la map c'est qu'elle n'est pas encore traité.
  Map<YahtzeeFigure,YahtzeeState> figuresState = {};
  
  /// Summ of all dice stock in the [maximum] value
  /// 
  /// It's use for the score [difference] => [maximum] - [minimum]
  int? maximum;

  /// Summ of all dice stock in the [minimum] value
  /// 
  /// It's use for the score [difference] => [maximum] - [minimum]
  int? minimum;

  ///Summ of all dice stock in a lucky Value
  int? lucky;
}

/// Represent the differents figures existing in the game Yahtzee 
enum DiceValue{
  dice1,
  dice2,
  dice3,
  dice4,
  dice5,
  dice6,
}

/// Represent the differents figures existing in the game Yahtzee 
enum YahtzeeState{
  succeed,
  failed
}

/// Represent the differents figures existing in the game Yahtzee 
enum YahtzeeFigure{
  /// 3 identical dice and 2 more identical dice
  fullHouse,
  /// 4 identical dice
  fourOfAKind,
  /// 5 dice consecutive (1,2,3,4,5 or 2,3,4,5,6)
  longStraight,
  /// 4 dice consecutive (1,2,3,4,5 or 2,3,4,5,6)
  smallStraight,
  /// 3 dentical dice
  threeOfAKind,
  /// 5 identical dice
  yahtzee,
}