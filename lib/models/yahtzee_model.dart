
///Represent the model of a Yahtzee Game
class YahtzeeModel {

  /// Represents the number of dice for the [DiceValue]
  Map<DiceValue,int> numberOfDiceValue = {};

  /// Stock the [State] of the [Figures]. 
  /// Si la figure n'est pas dans la map c'est qu'elle n'est pas encore traité.
  Map<Figures,State> figuresState = {};
  
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
  Dice1,
  Dice2,
  Dice3,
  Dice4,
  Dice5,
  Dice6,
}

/// Represent the differents figures existing in the game Yahtzee 
enum State{
  Succeed,
  Failed
}

/// Represent the differents figures existing in the game Yahtzee 
enum Figures{
  /// 3 identical dice and 2 more identical dice
  Full_house,
  /// 4 identical dice
  Four_of_a_kind,
  /// 5 dice consecutive (1,2,3,4,5 or 2,3,4,5,6)
  Long_straight,
  /// 4 dice consecutive (1,2,3,4,5 or 2,3,4,5,6)
  Small_straight,
  /// 3 dentical dice
  Three_of_a_kind,
  /// 5 identical dice
  Yahtzee,
}