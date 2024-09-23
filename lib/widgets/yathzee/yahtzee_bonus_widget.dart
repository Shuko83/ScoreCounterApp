
import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';

class YahtzeeBonusWidget extends StatefulWidget{
  const YahtzeeBonusWidget({
    super.key,
    required this.controller,
  }
  );

  final YahtzeeController controller;

  @override
  State<YahtzeeBonusWidget> createState() => _YahtzeeBonusWidgetState();
  
}

class _YahtzeeBonusWidgetState extends State<YahtzeeBonusWidget> implements ValuesListener{
  var pointNeeded = "0";
  @override
  void onValueChanged(){
   setState(() {
    pointNeeded = widget.controller.distanceToBonus().toString();
   }); 
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.registerValuesListeners(this);
    if(widget.controller.bonusSuccess()){
      return const Row(
        children: [
          Text("Bonus achieve."),
          Spacer(),
          Icon(Icons.check_circle,
            color: Colors.green, 
          ),
        ],
      );
    }else {   
    return Text('You need $pointNeeded more points to have bonus.'
    );
    }
  }
}
