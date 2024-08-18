
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

/// [Player] represent a generic player for a game.
/// 
/// Differents player can have the same [name] so you can add an [icon] and/or a [color] to differenciated it.
class Player {
  Player({
    required this.name,
    this.color,
    this.icon,
  });

  String name; 
  var uniqueId = const Uuid().v1();
  Color? color;
  IconData? icon;
}