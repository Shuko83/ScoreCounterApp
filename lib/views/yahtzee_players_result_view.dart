import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/yahtzee_controller.dart';
import 'package:score_counter_app/models/yahtzee_model.dart';
import 'package:score_counter_app/yahtzee_game.dart';

class YahtzeePlayersResultView extends StatelessWidget{
  const YahtzeePlayersResultView({
    super.key,
    required this.game,
    });

    final YahtzeeGame game;

  TableRow _buildTableRow({ required String title, required int Function(YahtzeeController) getValue, required BuildContext context, required int level}){
    var theme = Theme.of(context).colorScheme;
    Color textColor = Colors.black;
    Color rowColor = Colors.black;
    switch (level) {
      case 1:
        textColor = theme.onPrimary;
        rowColor = theme.primary ; 
        break;
      case 2:
        textColor = theme.onSecondary;
        rowColor = theme.secondary;
        break;
      case 3:
      default:
        textColor = theme.onTertiary;
        rowColor = theme.tertiary;
        break;
    }
    
    TextStyle style = TextStyle(fontWeight: FontWeight.bold, color: textColor);
    
    return TableRow(
      decoration: BoxDecoration(color: rowColor),
      children: [
        Text(title, style: style),
        for (var controller in game.controllers.values) 
          Center(
            child: Text(getValue(controller).toString(),
                style: style
                ),
          ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            const Text(""),
            for(var player in game.controllers.keys)
              Text(player.name),
          ],
        ),
        for(var diceValue in DiceValue.values)
          _buildTableRow(
            title: diceValue.name, 
            getValue: (controller) => controller.getValueScoreForDiceValue(diceValue),
            context: context,
            level: 3,),
          _buildTableRow(
            title: "Sous total dice value", 
            getValue: (controller) => controller.subTotalScoreForDiceValue,
            context: context,
            level: 3,),
          _buildTableRow(
            title: "Bonus", 
            getValue: (controller) => controller.scoreForBonus,
            context: context,
            level: 3,),
          _buildTableRow(
            title: "Total dice value", 
            getValue: (controller) => controller.totalScoreForDiceValue,
            context: context,
            level: 2,),
          _buildTableRow(
            title: "Maximum", 
            getValue: (controller) => controller.maximum,
            context: context,
            level: 3,),
          _buildTableRow(
            title: "Minimum", 
            getValue: (controller) => controller.minimum,
            context: context,
            level: 3,),
          _buildTableRow(
            title: "Difference", 
            getValue: (controller) => controller.difference??0,
            context: context,
            level: 2,),
          for(var figure in YahtzeeController.getAvailableFigures(game.variant))
          _buildTableRow(
            title: figure.name, 
            getValue: (controller) => controller.getFigureScore(figure: figure),
            context: context,
            level: 3,),
          _buildTableRow(
            title: "Total figures", 
            getValue: (controller) => controller.totalScoreForFigures,
            context: context,
            level: 2,),
          _buildTableRow(
            title: "Total", 
            getValue: (controller) => controller.totalScore,
            context: context,
            level: 1,),
      ],
    );
  }
}
