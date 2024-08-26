import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';



/// Widget which allow player to set the number of dice for the [diceValue]
class DiceValueWidget extends StatefulWidget{
  const DiceValueWidget({
    super.key,
    required this.controller,
    required this.diceValue,
    });

    final YahtzeeController controller;
    final DiceValue diceValue;

  @override
  State<DiceValueWidget> createState() => _DiceValueWidgetState();
}

class _DiceValueWidgetState extends State<DiceValueWidget> {

  /// Ask the controller to remove the number of dice for diceValue
  void reset(){
    setState(() {
      widget.controller.resetValue(widget.diceValue);
    });
  }

  /// Ask the controller to set the [number] of dice for diceValue
  void onValueClicked(int number){
    setState(() {
      widget.controller.setDiceNumber(number: number, value: widget.diceValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;
    var diceValue = widget.diceValue;
    var editMode = controller.canSetDiceValue(diceValue);
    /// In [editMode] create button to select the number of dice to set
    if(editMode){
      return Row(
        children: [
          Icon(getDiceIcon(diceValue)),
          for(var i = 0 ; i <= 5 ; ++i )
            ElevatedButton(
              onPressed: () => onValueClicked(i),
              child: Text(i.toString()),
            ),
        ],
      );
    } else{ // Else show the number of dice set previously and a button to reset data
      return Row(
        children: [
          Icon(getDiceIcon(diceValue)),
          Spacer(),
          Text(controller.getvalueForDiceValue(diceValue).toString()),
          ElevatedButton(onPressed: ()=> reset(), child: const Icon(Icons.edit)),
        ],
      );
    }
  }
}
