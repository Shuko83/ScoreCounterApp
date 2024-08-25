import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';

class YahtzeeView extends StatelessWidget{
  const YahtzeeView({
    super.key,
    required this.controller,
    });

  final YahtzeeController controller;
  
  @override
  Widget build(BuildContext context) {
    return Text("");
   /* return SizedBox(
      height: 350,
      width: 350,
      child: controller.getWidgetForDiceValue(DiceValue.dice1));*/
  }

}