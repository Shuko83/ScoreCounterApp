
import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';

/// View for an input for Yahtzee
class YahtzeeWidgetInput extends StatelessWidget{
  const YahtzeeWidgetInput({
    super.key,
    required this.controller,
  });

  final YahtzeeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          
        ],
    );
  }
}

class AllInputDiceValuesWidget extends StatelessWidget{
  const AllInputDiceValuesWidget({
    super.key,
    required this.controller,
  });
  final YahtzeeController controller;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        for(var diceValue in DiceValue.values)
          InputDiceValueWidget(diceValue: diceValue, controller: controller)
      ],
    );
  }
}

class InputDiceValueWidget extends StatelessWidget{
  const InputDiceValueWidget({
    super.key,
    required this.diceValue,
    required this.controller,
  });

  final DiceValue diceValue;
  final YahtzeeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(diceValue.toString()),  
        for(var i = 0 ; i < 6 ; ++i)
          DiceValueWidget(diceValue: diceValue, number: i, controller: controller)
      ],
    );
  }
}


class DiceValueWidget extends StatelessWidget{
  const DiceValueWidget({
    super.key,
    required this.diceValue,
    required this.number,
    required this.controller,
  });

  final DiceValue diceValue;
  final int number;
  final YahtzeeController controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => controller.setDiceNumber(number: number,value: diceValue),
      child: Text(number.toString()),
    );
  }
}