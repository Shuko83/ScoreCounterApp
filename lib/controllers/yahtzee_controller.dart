import '../models/yahtzee_model.dart';

///Controller for the model of Yahtzee.
class YahtzeeController {
  YahtzeeController({
    required this.model,
    this.variant = Variant.Pauline, 
  });

  final YahtzeeModel model;
  final Variant variant;

  Map<Variant,Set<Figures>> figuresForVariant = {
    Variant.Pauline : {
      Figures.Four_of_a_kind,
      Figures.Full_house,
      Figures.Long_straight,
      Figures.Yahtzee,},
      Variant.Classic:{},
  };

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
  
  void setMinimum(int value){
    switch(variant){
      case Variant.Pauline:
        if(editMode || model.minimum == null){
            model.minimum = value;
            editMode = false;
            //notify
        }
      break;
      default:
        throw ('Can\'t set a minimum value for variant ${variant.toString()}');
    }
  }

  void setMaximum(int value){
    switch(variant){
      case Variant.Pauline:
        if(editMode || model.maximum == null){
            model.maximum = value;
            editMode = false;
            //notify
        }
      break;
      default:
        throw ('Can\'t set a maximum value for variant ${variant.toString()}');
    }
  }

  void setFigureState(Figures figure, State state){
    /// on ne peut ajout une figure dans le model que si elle existe dans la version du jeu
    var availableFigures = figuresForVariant[variant] ?? {};
    if(availableFigures.contains(figure)){
      /// On peut modifier une valeur si on est en editMode
      if(editMode || !model.figuresState.containsKey(figure)){
        model.figuresState[figure] = state;
        editMode = false;
        //notify();
      }        
    }
  }
  
  Set<Figures> availableFigures(Variant variant){
    Set<Figures> figures = figuresForVariant[variant] ?? {};
    return figures;
  }
}

enum Variant{
  Classic,
  Pauline
}