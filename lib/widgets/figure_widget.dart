
import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';

class FigureWidget extends StatefulWidget{
  const FigureWidget({
    super.key,
    required this.figure,
    required this.controller,
  });

  final YahtzeeFigure figure;
  final YahtzeeController controller;

  @override
  State<FigureWidget> createState() => _FigureWidgetState();
}

class _FigureWidgetState extends State<FigureWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.figure.name),
        //SucceedFailedWidget(controller: widget.controller, figure: widget.figure,),
      ],
    );
  }
}

class SucceedFailedWidget extends StatelessWidget{
  const SucceedFailedWidget({
    super.key,
    required this.controller,
    required this.figure,
  });
  
  final YahtzeeController controller;
  final YahtzeeFigure figure;

  void onEditClicked(){
    controller.resetFigure(figure);
  }

 void changeState(YahtzeeState state)
  {
    controller.setFigureState(figure,state);
  }

  @override
  Widget build(BuildContext context) {
    var edit = controller.figureCanBeSet(figure);
    var figureState = controller.getState(figure);

    var icon = (figureState!=null && figureState == YahtzeeState.succeed)?Icons.check_circle_outline:Icons.cancel_outlined;
    var iconColor = (figureState!=null && figureState == YahtzeeState.succeed)? Colors.green:Colors.red;

    if(edit){
      return SizedBox(
        height: 350,
        width: 350,
        child: Row(
        children: [
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
        ],
        ),
      );
    } else{
      return SizedBox(
        height: 350,
        width: 350,
        child: Row(
          children: [
            Icon(icon,
            color: iconColor,),
            const Spacer(),
            ElevatedButton(
              onPressed: onEditClicked,
              child: const Icon(Icons.edit),
              ),
          ],
        ),
      );
    }
  }
}
