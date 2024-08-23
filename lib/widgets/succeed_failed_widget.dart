import 'package:flutter/material.dart';

class FigureWidget extends StatelessWidget{
  FigureWidget({
    required this.figure,
  });

  final YamFigures figure;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(figure.name),
        SucceedFailedWidget(),
      ],
    );
  }

}

class SucceedFailedWidget extends StatefulWidget{ 
  @override
  State<SucceedFailedWidget> createState() => _SucceedFailedWidgetState();
}

class _SucceedFailedWidgetState extends State<SucceedFailedWidget> {
  
  YamState? state;


  void onEditClicked(){
    setState(() {
      state = null;
    });
  }

  void changeState(YamState state)
  {
    setState(() {
      if(this.state != null && this.state == state){
        this.state = null;
      } else {
        this.state = state;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    if(state == null){
      return Row(
      children: [
        ElevatedButton(
          onPressed: () => {changeState(YamState.succeed)},
          child: Text(YamState.succeed.name,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => {changeState(YamState.failed)},
          child: Text(YamState.failed.name,
          ),
        ),
      ],
      );
    } else if(state == YamState.succeed){
      return Row(
        children: [
          Icon(Icons.check_circle_outline,
          color: Colors.green,),
          Spacer(),
          ElevatedButton(
            onPressed: onEditClicked,
            child: const Icon(Icons.edit),
            ),
        ],
        );
    } else if(state == YamState.failed){
      return Row(
                children: [
          Icon(Icons.cancel_outlined,
          color: Colors.red,),
          Spacer(),
          ElevatedButton(
            onPressed: onEditClicked,
            child: const Icon(Icons.edit),
            ),
        ],
      );
    }
    throw "oups";
  }
}

enum YamState{
  succeed,
  failed,
}
enum YamFigures{
  square,
  full,

}