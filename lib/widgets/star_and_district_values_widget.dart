import 'package:flutter/material.dart';
import 'package:score_counter_app/controllers/akropolis_city_controllers.dart';
import 'package:score_counter_app/models/city.dart';

class StarAndDistrictValuesWidget extends StatelessWidget{

  const StarAndDistrictValuesWidget({
    super.key,
    required this.city,
    required this.category,
    this.setByPlaza = true,
  });

  final CityModel city;
  final DistrictCategory category;
  final bool setByPlaza;
  @override
  Widget build(BuildContext context) {
    return Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AkropolisStarIconInputWidget(category: category, city: city,setByPlaza: setByPlaza),
          AkropolisDistrictValuesIconInputWidget(category: category, city: city)
        ],
    );
  }
}