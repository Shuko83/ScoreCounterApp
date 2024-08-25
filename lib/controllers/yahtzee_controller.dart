import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';
import 'package:score_counter_app/views/yahtzee_view.dart';

import '../models/yahtzee_model.dart';

/// Controller for the model of Yahtzee.
/// Can control of the variant of Yahtzee 
class YahtzeeController {
  YahtzeeController({
    required this.model,
    this.variant = Variant.pauline, 
  });

  final YahtzeeModel model;
  final Variant variant;

  int _score = 0;

  
  final Map<Variant,Set<YahtzeeFigure>> _figuresForVariant = {
    Variant.pauline : {
      YahtzeeFigure.fourOfAKind,
      YahtzeeFigure.fullHouse,
      YahtzeeFigure.longStraight,
      YahtzeeFigure.yahtzee,},
      Variant.classic:{},
  };

  /// Set [number] of dice for the [value] if it's possible
  void setDiceNumber({required int number, required DiceValue value}){
    if(!model.numberOfDiceValue.containsKey(value)){
      model.numberOfDiceValue[value] = number;
    }
  }

  /// Return the number of dice for the [value]
  /// Return 0 if the [value] is not yet set.
  /// 
  /// Show [canSetDiceValue] to know if the value is already set.
  int getvalueForDiceValue(DiceValue value){
      return model.numberOfDiceValue[value]?? 0;
  }

  /// Return true if the controller can set a [value].
  bool canSetDiceValue(DiceValue value){
    return !model.numberOfDiceValue.containsKey(value);
  }

  /// Clean the model for the specific [value]
  void resetValue(DiceValue value){
    model.numberOfDiceValue.remove(value);
  }

  /// Set [value] on the maximum if it's possible
  void setMaximum(int value){
    switch(variant){
      case Variant.pauline:
        model.maximum??=value;
        break;
      default:
        throw "not yet defined";
    }
  }

  /// Return the maximum of the model
  /// Return 0 if the value is not yet set.
  /// 
  /// Show [canSetMaximum] to know if the value is already set.
  int getMaximum(){
    return model.maximum??0;
  }

  /// Return true if the controller can set the maximum
  bool canSetMaximum(){
        switch(variant){
      case Variant.pauline:
        return model.maximum == null;
      default:
        throw "not yet defined";
    }
  }

  /// Reset the data save into the maximum
  void resetMaximum(){
    model.maximum=null;
  }

  /// Set [value] on the minimum if it's possible
  void setMinimum(int value){
    switch(variant){
      case Variant.pauline:
        model.minimum??=value;
        break;
      default:
        throw "not yet defined";
    }
  }

  /// Return the minimum of the model
  /// Return 0 if the value is not yet set.
  /// 
  /// Show [canSetMinimum] to know if the value is already set.
  int getMinimum(){
    return model.minimum??0;
  }

  /// Return true if the controller can set the minimum
  bool canSetMinimum(){
    switch(variant){
      case Variant.pauline:
        return model.minimum == null;
      default:
        throw "not yet defined";
    }
  }

  /// Reset the data save into the minimum
  void resetMinimum(){
    model.minimum=null;
  }
    
  /// Return true if the goal for bonus is reach.
  bool bonusSuccess(){
    return distanceToBonus() <= 0;
  }

  /// Return the score needed to add to reach the goal.
  int distanceToBonus(){
    var scoreNeeded = 0;
    switch(variant){
      case Variant.pauline: 
        scoreNeeded = 60;
        break;
      default:

    }
    return scoreNeeded - _score;
  }


  
  /// Set the [state] for the [figure] if it's possible
  /// 
  /// Show [figureCanBeSet] to know if it's possible
  void setFigureState(YahtzeeFigure figure, YahtzeeState state){
    /// on ne peut ajout une figure dans le model que si elle existe dans la version du jeu
    var availableFigures = _figuresForVariant[variant] ?? {};
    if(availableFigures.contains(figure)){
      /// On peut modifier une valeur si on est en editMode
      if(!model.figuresState.containsKey(figure)){
        model.figuresState[figure] = state;
      }        
    }
  }
  
  /// Reset the stat of the [figure]
  void resetFigure(YahtzeeFigure figure){
    model.figuresState.remove(figure);
  }

  ///Return true if [figure] can be set
  bool figureCanBeSet(YahtzeeFigure figure){
    return !model.figuresState.containsKey(figure);
  }

  /// Return the state of the [figure] if it's possible
  YahtzeeState? getState(YahtzeeFigure figure){
    return model.figuresState[figure];
  }

  /// Return a set of figure available
  /// 
  /// By default return a set for this controller
  /// Set [variant] to specified a variant.
  Set<YahtzeeFigure> availableFigures({Variant? variant}){
    var v = variant??this.variant;
    Set<YahtzeeFigure> figures = _figuresForVariant[v] ?? {};
    return figures;
  }

}

/// The different variant of Yahtzee implemented
enum Variant{
  classic,
  pauline
}

/// Return an icon for the DiceValue [value]
IconData getDiceIcon(DiceValue value){
  switch(value){
    case DiceValue.dice1:
    return DiceIcons.dice1;
    case DiceValue.dice2:
    return DiceIcons.dice2;
    case DiceValue.dice3:
    return DiceIcons.dice3;
    case DiceValue.dice4:
    return DiceIcons.dice4;
    case DiceValue.dice5:
    return DiceIcons.dice5;
    case DiceValue.dice6:
    return DiceIcons.dice6;
    default:
    return DiceIcons.dice0;
  }
}