
import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';

class DiceValueButton extends StatefulWidget{
  const DiceValueButton({
    super.key,
    required this.diceValue,
    required this.number,
    required this.controller,
    required this.fun,
  });

  final DiceValue diceValue;
  final int number;
  final YahtzeeController controller;
  final void Function({ required YahtzeeController controller, required DiceValue value, required int number}) fun;

  @override
  State<DiceValueButton> createState() => _DiceValueButtonState();
}

class _DiceValueButtonState extends State<DiceValueButton> {
 
  IconData getIcon(int value){
    switch(value){
      case 1:
      return Icons.one_k;
      case 2:
      return Icons.two_k;
      case 3:
      return Icons.three_k;
      case 4:
      return Icons.four_k;
      case 5:
      return Icons.five_k;
      case 6:
      return Icons.six_k;
      default:
        throw "Icon for this value is not yet implemented.";
    }
  }

  /*void onClicked({ required YahtzeeController controller, required DiceValue value, required int number}){
    setState(() {
      controller.setDiceNumber(number: number, value: value);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var controller = widget.controller;
    var value = widget.diceValue;
    var number = widget.number;
    bool editMode = controller.canSetDiceValue(value);

    if(editMode){
      return TextButton(
        onPressed: () => widget.fun,//(number: number,value: value,controller: controller),
        child: Icon(getIcon(widget.number)),
      );
    } else{
      return Text(
            number.toString(),
      );
    }
  }
}