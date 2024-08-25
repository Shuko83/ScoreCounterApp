
import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';

class YahtzeeBonusWidget extends StatelessWidget{
  const YahtzeeBonusWidget({
    super.key,
    required this.controller,
  });

  final YahtzeeController controller;

  @override
  Widget build(BuildContext context) {
    if(controller.bonusSuccess()){
      return const Icon(Icons.check_circle,
      color: Colors.green, );
    }else {
    return Text(
      controller.distanceToBonus().toString(),
    );
    }
  }
}
