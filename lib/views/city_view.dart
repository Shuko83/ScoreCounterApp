import 'package:flutter/material.dart';
import 'package:score_counter_app/models/architect.dart';
import 'package:score_counter_app/models/city.dart';
import 'package:score_counter_app/widgets/akropolis_widgets.dart';

/// Represents the view of the [city] for an [architect]
class CityView extends StatefulWidget {
  const CityView({
    super.key,
    required this.city,
    required this.architect,
  });

  final CityModel city;
  final Architect architect;

  @override
  State<CityView> createState() => _CityViewState();
}

class _CityViewState extends State<CityView> {
  var _score = 0;

  /// Update the vieww when it's necessary
  void _onCityChanged(){
    setState(() {
      var city = widget.city;
      _score = city.score;
    });
  }

  @override
  Widget build(BuildContext context) {
    var city = widget.city;
    city.addListener(_onCityChanged);
    return Expanded(
      child: Card(
        child: Column(
          children: [
            ArchitectWidget(architect: widget.architect),
            for(var category in DistrictCategory.values)
              StarAndDistrictValuesWidget(city: city, category: category),
            AkropolisStonesValuesIconInputWidget(city: city,),
            Text(
              _score.toString(),
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
