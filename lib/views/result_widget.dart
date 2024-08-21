import 'package:flutter/material.dart';
import 'package:score_counter_app/models/architect.dart';
import 'package:score_counter_app/models/city.dart';
import 'package:score_counter_app/widgets/akropolis_icon.dart';


/// Present the view of the [city]
class ResultWidget extends StatelessWidget {
  const ResultWidget({
    super.key,
    required this.city,
    required this.architect,
  });

  final CityModel city;
  final Architect architect;

@override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Column(
          children: [
            for(var category in DistrictCategory.values)
              Row(
                children: [
                  AkropolisIcon(icon:Icons.circle,
                  color: getColor(category),
                  size: 24,
                  ),
                  Text(city.getVictoryPoint(category).toString()),
                ],
              ),
            Text('Score total : ${city.score.toString()}',
              style: const TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}