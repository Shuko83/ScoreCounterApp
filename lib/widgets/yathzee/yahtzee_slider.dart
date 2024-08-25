
import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';


class YahtzeeSliderWidget extends StatefulWidget{

  const YahtzeeSliderWidget({
    super.key,
    required this.controller,
    required this.type,
  });

  final YahtzeeController controller;
  final SliderType type;
  
  @override
  State<YahtzeeSliderWidget> createState() => _YahtzeeSliderWidgetState();
}

class _YahtzeeSliderWidgetState extends State<YahtzeeSliderWidget> {

  double _currentSliderValue = 5;

    void onValidClicked(SliderType type, YahtzeeController controller, double value){
    setState(() {
      switch(type){
        case SliderType.maximum:
          controller.setMaximum(value.toInt());
          break;
        case SliderType.minimum:
          controller.setMinimum(value.toInt());
          break;
        default:
          throw "Not yet implemented";
      }
    });
  }

  void onResetClicked(SliderType type, YahtzeeController controller){
    setState(() {
      switch(type){
        case SliderType.maximum:
          controller.resetMaximum();
          break;
        case SliderType.minimum:
          controller.resetMinimum();
          break;
        default:
          throw "Not yet implemented";
      }
    });
  }

  int valueToShow(YahtzeeController controller, SliderType type){
    switch(type){
        case SliderType.maximum:
          return controller.getMaximum();
        case SliderType.minimum:
          return controller.getMinimum();
        default:
          throw "Not yet implemented";
      }
  }

  bool getEditMode(YahtzeeController controller, SliderType type){
    switch(type){
      case SliderType.maximum:
        return controller.canSetMaximum();
      case SliderType.minimum:
        return controller.canSetMinimum();
      default:
        throw "Not yet implemented";
    }
  }

  @override
  Widget build(BuildContext context){
    var controller = widget.controller;
    var type = widget.type;
    var text = type.name;
    var editMode = getEditMode(controller,type);
     
    if(editMode){
      return Row(
        children: [
          Text(text),
          Slider(
          value: _currentSliderValue,
          max: 30,
          divisions: 25,
          min: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        ElevatedButton(onPressed: () => onValidClicked(type,controller,_currentSliderValue), child: const Icon(Icons.check_circle_outline))
        ],
      );
    } else{
      return Row(
        children: [  
          Text(text),
          Text(valueToShow(controller, type).toString()),
          const Spacer(),
          ElevatedButton(onPressed:() => onResetClicked(type,controller), child: const Icon(Icons.edit)),
        ],
      );
    }
  }
}

enum SliderType{
  maximum,
  minimum,
  chance,
}