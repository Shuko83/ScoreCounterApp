import 'package:flutter/material.dart';
import 'package:score_counter_app/models/architect.dart';
import 'package:score_counter_app/models/city.dart';
import 'package:flutter/services.dart';
import 'package:score_counter_app/widgets/akropolis_icon.dart';

/// This widget is used to interact with the user.
/// 
/// It allows user to set an integer in a field.
/// The regexp for input is set.
/// For smartphone, it provide a keybord sspecific for integer.
/// [height] allow the view to set the height of textfield.
/// [func] is called when the user enter an integer uin the field.
class AkropolisIntegerInputWidget extends StatelessWidget {
  const AkropolisIntegerInputWidget({
    super.key,
    required this.func,
    required this.height,
  });

  final void Function(int) func;
  final double height;

  /// Return an integer if the [str] can be convert in integer.
  /// Return 0 otherwise.
  int _tryConvertInput(String str){
    return int.tryParse(str)?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: 135,
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
        keyboardType: TextInputType.number,
        decoration:  const InputDecoration(
          border : OutlineInputBorder(),
          contentPadding: EdgeInsets.all(0)
        ),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
        onChanged: (str) => func(_tryConvertInput(str)),
      ),
    );
  }
}

/// This widget is used to represent an icon and an Textfield specific for Akropolis.
/// 
/// The [color] is used for the [icon].
/// The [func] is called when the text into Textfield changed.
/// [size] is used to set the size of [icon] and the height of the textField.
class AkropolisIconIntegerInputWidget extends StatelessWidget {
  const AkropolisIconIntegerInputWidget({
    super.key,
    required this.color,
    required this.icon,
    required this.func,
    this.size = 35,
  });


  final IconData icon;
  final Color color;
  final Function(int) func;
  final double size;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AkropolisIcon(icon: icon, color: color, size:size),
        AkropolisIntegerInputWidget(func: func, height: size)
        ],
    );
  }
}

/// This widget is used to control the star of [city] in the specified [category].
/// If [setByPlaza] is true, the user has to fill the controller with the number of plaza in the [city].
/// Otherwise, the user must fill whith the real number of star.
class AkropolisStarIconInputWidget extends StatelessWidget {
  const AkropolisStarIconInputWidget({
    super.key,
    required this.category,
    required this.city,
    this.setByPlaza = true,
  });

  final CityModel city;
  final DistrictCategory category;
  final bool setByPlaza;

  /// This method set the star in the  [city] correctly.
  void _setStar(int value){
    if(setByPlaza){
      return city.setNumberOfPlaza(value,category);
    }
    else{
      return city.setNumberOfStars(value,category);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: AkropolisIconIntegerInputWidget(
            color: getColor(category),
            func: _setStar,
            icon: Icons.star_border,   
      ),
    );
  }
}

/// This widget is used to control the district values of [city] in the specified [category].
class AkropolisDistrictValuesIconInputWidget extends StatelessWidget {
  const AkropolisDistrictValuesIconInputWidget({
    super.key,
    required this.category,
    required this.city,
  });

  final CityModel city;
  final DistrictCategory category;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: AkropolisIconIntegerInputWidget(
            color: getColor(category),
            func: (districtValues) => city.setNumberDistrictValues(districtValues,category),
            icon: Icons.hexagon, 
      ),
    );
  }
}

/// This widget is used to control the number of stones of [city].
class AkropolisStonesValuesIconInputWidget extends StatelessWidget {
  const AkropolisStonesValuesIconInputWidget({
    super.key,
    required this.city,
  });

  final CityModel city;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: AkropolisIconIntegerInputWidget(
            color: Colors.grey,
            func: (numberOfStones) => city.setNumberOfStones(numberOfStones),
            icon: Icons.square, 
      ),
    );
  }
}


/// Widget which represent an input for stars and districtsValues
/// Allow to change data to [city] for [category]
/// [setByPlaza] set the star by plaza
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
        children: [
          AkropolisStarIconInputWidget(category: category, city: city,setByPlaza: setByPlaza),
          AkropolisDistrictValuesIconInputWidget(category: category, city: city)
        ],
    );
  }
}

/// Widget which represent an [architect]
class ArchitectWidget extends StatelessWidget {
  const ArchitectWidget({
    super.key,
    required this.architect,
  });

  final Architect architect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(architect.icon,
        color: architect.color,
        ),
        Text(
          architect.name,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
