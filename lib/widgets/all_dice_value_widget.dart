import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';
import 'package:score_counter_app/widgets/dice_value_widget.dart';

class AllDiceValueWidget extends StatefulWidget{
  const AllDiceValueWidget({
    super.key,
    required this.controller,
    required this.diceValue,
    });

    final YahtzeeController controller;
    final DiceValue diceValue;

  @override
  State<AllDiceValueWidget> createState() => _AllDiceValueWidgetState();
}

class _AllDiceValueWidgetState extends State<AllDiceValueWidget> {

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
          for(var i = 1 ; i <= 5 ; )
            DiceValueButton(diceValue: diceValue, number: i, controller: controller, fun: onValueClicked)
        ],
          );
    }
    else{
      return Row(
        children: [
          Icon(getDiceIcon(diceValue)),
          for(var i = 1 ; i <= 5 ; )
            DiceValueButton(diceValue: diceValue, number: i, controller: controller, fun: onValueClicked),
          ElevatedButton(onPressed: ()=>{reset(controller: controller,value: diceValue)}, child: Icon(Icons.edit)),
        ],
          );
    }
    
  }
}