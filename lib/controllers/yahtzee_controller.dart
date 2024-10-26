import 'package:dice_icons/dice_icons.dart';
import 'package:flutter/material.dart';
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

  int _scoreForDiceValues = 0;
  int? _difference;

  ///Sets of differents existing listeners
  Set<FiguresListener> _figuresListeners = {};
  Set<ValuesListener> _valuesListener = {};
  Set<DifferenceListener> _differencesListener = {};

  static final Map<Variant,Set<YahtzeeFigure>> _figuresForVariant = {
    Variant.pauline : {
      YahtzeeFigure.fourOfAKind,
      YahtzeeFigure.fullHouse,
      YahtzeeFigure.longStraight,
      YahtzeeFigure.yahtzee,},
  };

  /// ----------- Listeners
  
  /// Method that notify all figures listeners
  void _notifyFiguresListeners(){
    for (var listener in _figuresListeners){
      listener.onFigureChanged();
    }
  }

  /// Method that notify all values listeners
  void _notifyValuesListeners(){
    for (var listener in _valuesListener){
      listener.onValueChanged();
    }
  }
  
  /// Method that notify all difference listeners
  void _notifyDifferenceListeners(){
    for (var listener in _differencesListener){
      listener.onDifferenceChanged();
    }
  }

  /// Register [listener] if it not yet register.
  /// Return true if the listener is added, false otherwise.
  /// 
  /// If [notifyHistory], if [listener] is added, it's notify like a changed occured. 
  bool registerFiguresListeners(FiguresListener listener, {bool notifyHistory = false}){
    bool listenerAdded = _figuresListeners.add(listener);
    if(listenerAdded && notifyHistory){
      listener.onFigureChanged();
    }
    return listenerAdded;
  }

  /// Unregister [listener] if it's register.
  /// Return true if the listener is removed, false otherwise. 
  bool unregisterFiguresListeners(FiguresListener listener){
    return _figuresListeners.remove(listener);
  }

  /// Register [listener] if it not yet register.
  /// Return true if the listener is added, false otherwise.
  /// 
  /// If [notifyHistory], if [listener] is added, it's notify like a changed occured. 
  bool registerValuesListeners(ValuesListener listener, {bool notifyHistory = false}){
    bool listenerAdded = _valuesListener.add(listener);
    if(listenerAdded && notifyHistory){
      listener.onValueChanged();
    }
    return listenerAdded;
  }

  /// Unregister [listener] if it's register.
  /// Return true if the listener is removed, false otherwise. 
  bool unregisterValuesListeners(ValuesListener listener){
    return _valuesListener.remove(listener);
  }
  
  /// Register [listener] if it not yet register.
  /// Return true if the listener is added, false otherwise.
  /// 
  /// If [notifyHistory], if [listener] is added, it's notify like a changed occured. 
  bool registerDifferenceListeners(DifferenceListener listener, {bool notifyHistory = false}){
    bool listenerAdded = _differencesListener.add(listener);
    if(listenerAdded && notifyHistory){
      listener.onDifferenceChanged();
    }
    return listenerAdded;
  }

  /// Unregister [listener] if it's register.
  /// Return true if the listener is removed, false otherwise. 
  bool unregisterDifferenceListeners(DifferenceListener listener){
    return _differencesListener.remove(listener);
  }

  /// ----------- Interaction with the model

  /// Set [number] of dice for the [value] if it's possible
  void setDiceNumber({required int number, required DiceValue value}){
    if(!model.numberOfDiceValue.containsKey(value)){
      model.numberOfDiceValue[value] = number;
      _updateValueScore();
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
    _updateValueScore();
  }

  /// Set [value] on the maximum if it's possible
  set maximum(int value){
    switch(variant){
      case Variant.pauline:
        model.maximum??=value;
        _updateDifference();
        _notifyDifferenceListeners();
        break;
      default:
        throw "not yet defined";
    }
  }

  /// Return the maximum of the model
  /// Return 0 if the value is not yet set.
  /// 
  /// Show [canSetMaximum] to know if the value is already set.
  int get maximum{
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
    _updateDifference();
  }

  /// Set [value] on the minimum if it's possible
  set minimum(int value){
    switch(variant){
      case Variant.pauline:
        model.minimum??=value;
        _updateDifference();
        _notifyDifferenceListeners();
        break;
      default:
        throw "not yet defined";
    }
  }

  /// Return the minimum of the model
  /// Return 0 if the value is not yet set.
  /// 
  /// Show [canSetMinimum] to know if the value is already set.
  int get minimum{
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
    _updateDifference();
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
        _notifyFiguresListeners();
      }        
    }
  }
  
  /// Reset the stat of the [figure]
  void resetFigure(YahtzeeFigure figure){
    model.figuresState.remove(figure);
    _notifyFiguresListeners();
  }

  ///Return true if [figure] can be set
  bool figureCanBeSet(YahtzeeFigure figure){
    return !model.figuresState.containsKey(figure);
  }

  /// Return the state of the [figure] if it's possible
  YahtzeeState? getState(YahtzeeFigure figure){
    return model.figuresState[figure];
  }

  /// Return the score for bonus
  int get scoreForBonus{
    return bonusSuccess? _getScoreForSuccessBonus(variant) : 0;
  }

  /// ----------- Internal model

  /// Return the difference if it exist null.
  /// It's the difference between the maximum and the minimum.
  int? get difference{
    return _difference;
  }

  /// This method calculated the score for the different dice.
  /// 
  /// The result is save in a local variable and can be access with the method
  void _updateValueScore(){
    _scoreForDiceValues = 0;
    for(var it in model.numberOfDiceValue.entries){
      _scoreForDiceValues += getvalueForDiceValue(it.key);
    }
    _notifyValuesListeners();
  }
  
  /// Return true if the goal for bonus is reach.
  bool get bonusSuccess{
    return distanceToBonus() <= 0;
  }

  /// Return the score needed to validate the bonus.
  int distanceToBonus(){
    var scoreNeeded = 0;
    switch(variant){
      case Variant.pauline: 
        scoreNeeded = 60;
        break;
      default:

    }
    return scoreNeeded - _scoreForDiceValues;
  }

  // Update the difference in the internal model
  void _updateDifference() {
    var max = model.maximum;
    var min = model.minimum;
    if(max != null && min!= null){
      _difference = max-min;
    }
    else {
      _difference = null;
    }
  }

  /// -------------- Rules
   
  /// Return the score for one dice with [diceValue]
  int getValueScoreForDiceValue(DiceValue diceValue){
      var sccoreForDiceValue = 0;
      switch(diceValue){
        case DiceValue.dice1:
        sccoreForDiceValue = 1;
        break;
        case DiceValue.dice2:
        sccoreForDiceValue = 2;
        break;
        case DiceValue.dice3:
        sccoreForDiceValue = 3;
        break;
        case DiceValue.dice4:
        sccoreForDiceValue = 4;
        break;
        case DiceValue.dice5:
        sccoreForDiceValue = 5;
        break;
        case DiceValue.dice6:
        sccoreForDiceValue = 6;
        break;
        default:
        break;
      }
      var numberOfDice = model.numberOfDiceValue[diceValue] ?? 0;
    return sccoreForDiceValue * numberOfDice;
  }

  /// Return the score if the [figure] is succeed. 
  int getFigureScore({required YahtzeeFigure figure, Variant ? variant}){
    var success = model.figuresState[figure]==YahtzeeState.succeed;
    if(!success){
      return 0;
    }
    return _getPointForFigure(figure: figure, variant: variant);
  }

  /// Return a set of figure available for the controller.
  Set<YahtzeeFigure> get availableFigures => getAvailableFigures(variant);

  /// Return a set of figure available for [variant].
  static Set<YahtzeeFigure> getAvailableFigures(Variant variant){
    Set<YahtzeeFigure> figures = _figuresForVariant[variant] ?? {};
    return figures;
  }
  
  /// Return the point
  int _getPointForFigure({required YahtzeeFigure figure,Variant? variant}) {
    var point = 0;
    switch (variant) {
      case Variant.pauline:
        switch (figure) {
          case YahtzeeFigure.fourOfAKind:
            point = 40;
            break;
          case YahtzeeFigure.fullHouse:
            point = 30;
            break;
          case YahtzeeFigure.yahtzee:
            point = 50;
            break;
          case YahtzeeFigure.longStraight:
            point = 20;
            break;
          default:
        }
        break;
      default:
    }
  return point; 
  }

  /// Return the score for success bonus for [variant]
  int _getScoreForSuccessBonus(Variant variant){
    switch (variant) {
      case Variant.pauline:
          return 30;
      default:
      throw "Not yet implemented";
    }
  }
}

/// The different variant of Yahtzee implemented
enum Variant{
  pauline,
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

/// Interface for a listener which is notify when the difference changed.
abstract class DifferenceListener{
  void onDifferenceChanged();
}

/// Interface for a listener which is notify when a figure changed.
abstract class FiguresListener{
  void onFigureChanged();
}

/// Interface for a listener which is notify when a value changed.
abstract class ValuesListener{
  void onValueChanged();
}