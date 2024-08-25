import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';
import 'package:score_counter_app/widgets/yathzee/dice_value_widget.dart';
import 'package:score_counter_app/widgets/yathzee/yahtzee_slider.dart';

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
          DiceValueWidget(
            diceValue: diceValue,
            controller: controller,
          ),
          //widget for bonus,
          YahtzeeSliderWidget(controller: controller,type: SliderType.maximum,),
          YahtzeeSliderWidget(controller: controller,type: SliderType.minimum,),
          //YahtzeeSlider(controller: controller, forMaximum: false),
      ],
    );
  }

}