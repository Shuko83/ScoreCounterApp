
import 'package:flutter/material.dart';

class YamSlider extends StatefulWidget {
  const YamSlider({super.key});

  @override
  State<YamSlider> createState() => _YamSliderState();
}

class _YamSliderState extends State<YamSlider> {
  double _currentSliderValue = 20;
  bool editMode = false;

  int? value;

  void onClicked(){
    setState(() {
      value = _currentSliderValue.toInt();
      editMode = false;
    });
  }
  void onEditClicked(){
    setState(() {
      value = null;
      editMode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(value != null){
      return Row(
        children: [
          Text(value.toString()),
          ElevatedButton(onPressed: onEditClicked, child: Icon(Icons.edit)),
        ],
      );
    }
    else{
      return Row(
        children: [
          Slider(
          value: _currentSliderValue,
          max: 30,
          divisions: 25,
          min: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              print("changed");
              _currentSliderValue = value;
            });
          },
        ),
        ElevatedButton(onPressed: onClicked, child: Icon(Icons.check_circle_outline))
        ],
      );
    }
  }
}