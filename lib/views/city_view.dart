import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/akropolis_city_controllers.dart';
import 'package:score_counter_app/models/city.dart';
import 'package:score_counter_app/widgets/star_and_district_values_widget.dart';

/// Represents the view of the [city]
class CityView extends StatefulWidget {
  const CityView({
    super.key,
    required this.city,
  });

  final CityModel city;

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
