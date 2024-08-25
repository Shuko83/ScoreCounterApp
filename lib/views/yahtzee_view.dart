import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';
import 'package:score_counter_app/widgets/yathzee/all_dice_value_widget.dart';

class YahtzeeView extends StatelessWidget{
  const YahtzeeView({
    super.key,
    required this.controller,
    });

  final YahtzeeController controller;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var diceValue in DiceValue.values)
          AllDiceValueWidget(
            diceValue: diceValue,
            controller: controller,
          ),
      ],
    );
  }

}