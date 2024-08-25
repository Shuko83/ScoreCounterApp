
import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';

class FigureWidget extends StatefulWidget{
  const FigureWidget({
    super.key,
    required this.controller,
    required this.figure,
  });
  
  final YahtzeeController controller;
  final YahtzeeFigure figure;

  @override
  State<FigureWidget> createState() => _FigureWidgetState();
}

class _FigureWidgetState extends State<FigureWidget> {
  void onEditClicked(){
    setState(() {
      widget.controller.resetFigure(widget.figure);
    });
  }

  void changeState(YahtzeeState state){
    setState(() {
      widget.controller.setFigureState(widget.figure,state);
    });
  }

  @override
  Widget build(BuildContext context) {
    var edit = widget.controller.figureCanBeSet(widget.figure);
    var figureState = widget.controller.getState(widget.figure);

    var icon = (figureState!=null && figureState == YahtzeeState.succeed)?Icons.check_circle_outline:Icons.cancel_outlined;
    var iconColor = (figureState!=null && figureState == YahtzeeState.succeed)? Colors.green:Colors.red;

    if(edit){
      return Row(
        children: [
          Text(widget.figure.name),
          ElevatedButton(
            onPressed: () => {changeState(YahtzeeState.succeed)},
            child: Text(YahtzeeState.succeed.name,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => {changeState(YahtzeeState.failed)},
            child: Text(YahtzeeState.failed.name,
            ),
          ),
        ]
      );
    } else{
      return Row(
          children: [
          Text(widget.figure.name),
            Icon(icon,
            color: iconColor,),
            const Spacer(),
            ElevatedButton(
              onPressed: onEditClicked,
              child: const Icon(Icons.edit),
              ),
          ]
      );
    }
  }
}
