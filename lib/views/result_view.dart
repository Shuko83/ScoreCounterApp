import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/akropolis_city_controllers.dart';
import 'package:score_counter_app/models/city.dart';
import 'package:score_counter_app/widgets/star_and_district_values_widget.dart';

/// Present the view of the [city]
class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
    required this.city,
  });

  final CityModel city;

@override
  Widget build(BuildContext context) {
    var city = widget.city;
    city.addListener(_onCityChanged);
    return SizedBox(
      height: 450,
      child: Card(
        child: Column(
          children: [
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