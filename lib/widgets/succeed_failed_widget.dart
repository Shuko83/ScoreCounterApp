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
  bool editMode = false;


  void onEditClicked(){
    setState(() {
      editMode = true;
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
      editMode = false;
    });
  }
  
  final ButtonStyle selectedStyle = ElevatedButton.styleFrom(
    backgroundColor:const Color.fromARGB(255, 77, 122, 219),
    );
  final ButtonStyle unselectedStyle = ElevatedButton.styleFrom(
    backgroundColor:const Color.fromARGB(255, 236, 236, 236),

    );
  @override
  Widget build(BuildContext context) {
    
    if(state == null || editMode){
      return Row(
      children: [
        ElevatedButton(
          onPressed: () => {changeState(YamState.succeed)},
          style: (state != null && state == YamState.succeed)? selectedStyle:unselectedStyle,
          child: Text(YamState.succeed.name,
          style: TextStyle(color: (state != null && state == YamState.succeed)?Colors.white:Colors.black),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => {changeState(YamState.failed)},
          style: (state != null && state == YamState.failed)? selectedStyle:unselectedStyle,
          child: Text(YamState.failed.name,
          style: TextStyle(color: (state != null && state == YamState.failed)?Colors.white:Colors.black),
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