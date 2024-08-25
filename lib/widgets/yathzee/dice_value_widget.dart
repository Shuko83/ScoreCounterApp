import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';

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

  void reset({ required YahtzeeController controller, required DiceValue value}){
    setState(() {
      controller.resetValue(value);
    });
  }

  void onValueClicked({ required YahtzeeController controller, required DiceValue value, required int number}){
    setState(() {
      controller.setDiceNumber(number: number, value: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;
    var diceValue = widget.diceValue;
    var editMode = controller.canSetDiceValue(diceValue);
    if(editMode){
      return Row(
        children: [
          Icon(getDiceIcon(diceValue)),
          for(var i = 0 ; i <= 5 ; ++i )
            ElevatedButton(
              onPressed: () {onValueClicked(controller: controller, value: diceValue, number: i);},
              child: Text(i.toString()),
            ),
        ],
      );
    } else{
      return Row(
        children: [
          Icon(getDiceIcon(diceValue)),
          Text(controller.getvalueForDiceValue(diceValue).toString()),
          ElevatedButton(onPressed: ()=>{reset(controller: controller,value: diceValue)}, child: const Icon(Icons.edit)),
        ],
      );
    }
  }
}
