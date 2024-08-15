import 'package:flutter/material.dart';

/// Represent a city in Akropolis.
class CityModel with ChangeNotifier{
  Map<DistrictCategory,int> _numberOfStars = Map();
  Map<DistrictCategory,int> _districtValues = Map();

  var _numberOfStones = 0;

  /// Return the [score] of a city.
  /// 
  /// The [score] depends of the number of stone and the victorious points for districts.
  int get score => _numberOfStones + _getDistrictsScore();  

  /// Return the score of all district
  int _getDistrictsScore(){
    var victoryPoints = 0;
    for(var category in DistrictCategory.values){
    victoryPoints += getVictoryPoint(category);
    }
    return victoryPoints;
  }

  /// Return the score for the specific district of [category].
  int getVictoryPoint(DistrictCategory category){
    var star =_numberOfStars[category]?? 0;
    var districtValues = _districtValues[category]?? 0;
    return star * districtValues;
  }

  ///This method set the number of star with the [value]
  void setNumberOfStars(int value, DistrictCategory category){
    _numberOfStars[category] = value;
    notifyListeners();
  }

  /// Use the [numberOfPlaza] to set internal number of star
  void setNumberOfPlaza(int numberOfPlaza, DistrictCategory category){
    setNumberOfStars(numberOfPlaza * getStarByPlaza(category), category);
  }

  ///This method set the district values with the [value]
  void setNumberDistrictValues(int value, DistrictCategory category){
    _districtValues[category] = value;
    notifyListeners();
  }

  ///This method set the number of stones with the [value]
  void setNumberOfStones(int value){
    _numberOfStones = value;
    notifyListeners();
  }
}

///Return the number of star for one plaza for the [category]
int getStarByPlaza(category){
  switch(category)
  {
    case DistrictCategory.houses:
      return 1;
    case DistrictCategory.temples:
    case DistrictCategory.markets:
    case DistrictCategory.barracks:
      return 2;
    case DistrictCategory.gardens:
      return 3;
    default:
    throw ('This category is not yet implemented');
  }
}
  
/// Return the associated color for a district [category]
Color getColor(category){
  switch(category)
  {
    case DistrictCategory.houses:
      return const Color.fromARGB(255, 95, 167, 226);
    case DistrictCategory.temples:
      return const Color.fromARGB(255, 226, 128, 243);
    case DistrictCategory.markets:
      return const Color.fromARGB(255, 241, 230, 125);
    case DistrictCategory.barracks:
      return const Color.fromARGB(255, 240, 97, 87);
    case DistrictCategory.gardens:
      return const Color.fromARGB(255, 126, 235, 129);
    default:
    throw ('This category is not yet implemented');
  }
}

/// Represent the type of disstrict in Akropolis
enum DistrictCategory {
  houses,
  markets,
  barracks,
  temples,
  gardens,
}