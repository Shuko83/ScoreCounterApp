import 'package:flutter/material.dart';
import 'package:score_counter_app/views/yahtzee_player_edit_view.dart';
import 'package:score_counter_app/views/yahtzee_players_result_view.dart';
import 'package:score_counter_app/yahtzee_game.dart';

class YahtzeeGameView extends StatelessWidget{
  const YahtzeeGameView({
    super.key,
    required this.game,
    });

  final YahtzeeGame game;
  
  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: 0);
    return PageView(
      controller: controller,
      children: [
        for (var entry in game.controllers.entries)
          YahtzeePlayerEditView(controller: entry.value,name: entry.key.name,),
        YahtzeePlayersResultView(game: game),
      ],
    );
  }

}