import 'package:flutter/material.dart';

/// This class is used to create a specific Icon for Akropolis.
/// It allow the application to have the icon similary.
/// This icon is defined by the [icon], the [color] and the [size].
class AkropolisIcon extends StatelessWidget {
  const AkropolisIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
  });

  final Color color;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(icon,
    color: color,
    shadows: const [Shadow(color:Colors.black,offset: Offset(2,2), blurRadius: 2)],
    size: size,
    );
  }
}
