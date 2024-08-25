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


  ///get
  int getvalueForDiceValue(DiceValue value){
      return model.numberOfDiceValue[value]?? 0;
  }

  /// Clean the model for the specific [value]
  void resetValue(DiceValue value){
    model.numberOfDiceValue.remove(value);
  }

  void setMaximum(int value){
    switch(variant){
      case Variant.pauline:
        model.maximum??=value;
        break;
      default:
        throw "not yet defined";
    }
  }

  int getMaximum(){
    return model.maximum??0;
  }

  int getMinimum(){
    return model.minimum??0;
  }

  void setMinimum(int value){
    switch(variant){
      case Variant.pauline:
        model.minimum??=value;
        break;
      default:
        throw "not yet defined";
    }
  }

  void resetMaximum(){
    model.maximum=null;
  }

  void resetMinimum(){
    model.minimum=null;
  }


  bool canSetMinimum(){
    switch(variant){
      case Variant.pauline:
        return model.minimum == null;
      default:
        throw "not yet defined";
    }
  }

  bool canSetMaximum(){
        switch(variant){
      case Variant.pauline:
        return model.maximum == null;
      default:
        throw "not yet defined";
    }
  }
  /// Return true if the goal for bonus is reach.
  bool bonusSuccess(){
    return distanceToBonus() <= 0;
  }

  /// Return le score qu'il manque pour réussir le bonus.
  /// TODO traduction
  int distanceToBonus(){
    return 60 - _score;
  }

  /// Return true if the controller can set a [value].
  bool canSetDiceValue(DiceValue value){
    return !model.numberOfDiceValue.containsKey(value);
  }

  /// editMode allow controller to change all the data of the model.
  /// Should be use only to edit an error. For exemple miss clicked and set a figure to failed instead of succeed.
  bool editMode = false;

  void setDiceNumber({required int number, required DiceValue value}){
    if(editMode || !model.numberOfDiceValue.containsKey(value)){
      model.numberOfDiceValue[value] = number;
      editMode = false;
      //notify
    }
  }
  
  void setFigureState(YahtzeeFigure figure, YahtzeeState state){
    /// on ne peut ajout une figure dans le model que si elle existe dans la version du jeu
    var availableFigures = _figuresForVariant[variant] ?? {};
    if(availableFigures.contains(figure)){
      /// On peut modifier une valeur si on est en editMode
      if(editMode || !model.figuresState.containsKey(figure)){
        model.figuresState[figure] = state;
        editMode = false;
        //notify();
      }        
    }
  }
  
  void resetFigure(YahtzeeFigure figure){
    model.figuresState.remove(figure);
  }

  bool figureCanBeSet(YahtzeeFigure figure){
    return !model.figuresState.containsKey(figure);
  }

  Set<YahtzeeFigure> availableFigures({Variant? variant}){
    var v = variant??this.variant;
    Set<YahtzeeFigure> figures = _figuresForVariant[v] ?? {};
    return figures;
  }

  YahtzeeState? getState(YahtzeeFigure figure){
    return model.figuresState[figure];
  }
    
  bool state = true;

  Widget getWidgetForDiceValue(DiceValue value){
    //_wigetState state = canSetDiceValue(value)? _wigetState.edit:_wigetState.show;
    if(state){// == _wigetState.edit){
      return Row(
        children: [
          Text("Edit"),
          ElevatedButton(onPressed: () => {state = !state}, child: Icon(Icons.edit))
        ],
      );
    } else {
      return Row(
        children: [
          Text("Edit"),
          ElevatedButton(onPressed: () => {state = !state}, child: Icon(Icons.edit))
        ],
      );
    }
  }
}

enum _wigetState{
  edit,
  show,
}
enum Variant{
  classic,
  pauline
}

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