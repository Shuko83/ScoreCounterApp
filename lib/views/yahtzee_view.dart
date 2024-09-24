import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';
import 'package:score_counter_app/widgets/yathzee/dice_value_widget.dart';
import 'package:score_counter_app/widgets/yathzee/figure_widget.dart';
import 'package:score_counter_app/widgets/yathzee/yahtzee_bonus_widget.dart';
import 'package:score_counter_app/widgets/yathzee/yahtzee_slider_widget.dart';

class YahtzeeView extends StatelessWidget{
  const YahtzeeView({
    super.key,
    required this.controller,
    required this.name,
    });

  final YahtzeeController controller;
  final String name;

  @override
  Widget build(BuildContext context) {
    var customDivider = const Divider(
            thickness: 2,        // Épaisseur de la ligne
            indent: 20,          // Marge à gauche
            endIndent: 20,       // Marge à droite
          );
    return Column(
      children: [
        Center(child: Text(name),),
        for(var diceValue in DiceValue.values)
          DiceValueWidget(
            diceValue: diceValue,
            controller: controller,
          ),
          YahtzeeBonusWidget(controller: controller),
          customDivider,
          YahtzeeSliderWidget(controller: controller,type: SliderType.maximum,),
          YahtzeeSliderWidget(controller: controller,type: SliderType.minimum,),
          customDivider,
          for(var figure in controller.availableFigures())
            FigureWidget(controller: controller, figure: figure),
      ],
    );
  }

}