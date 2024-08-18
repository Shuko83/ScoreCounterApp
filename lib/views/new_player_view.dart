import 'package:flutter/material.dart';
import 'package:score_counter_app/models/player.dart';

/// Represents the view for create a Player
class NewPlayerView extends StatelessWidget {
  NewPlayerView({
    super.key,
  });

  Player player = Player(name : "noNamed");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 135,
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
        keyboardType: TextInputType.text,
        decoration:  const InputDecoration(
          border : OutlineInputBorder(),
          contentPadding: EdgeInsets.all(0)
        ),
        onChanged: (str) => player.name = str
      ),

    );
  }
}
