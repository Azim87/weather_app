import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/forecast_weather.dart';

class WeatherForecastItem extends StatelessWidget {
  final ListElement list;
  WeatherForecastItem({required this.list});

  @override
  Widget build(BuildContext context) {
    final icon = list.weather[0].icon;
    final imageUrl = "http://openweathermap.org/img/w/" + icon + ".png";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DateFormat('EEE HH:mm').format(list.dtTxt)),
          Image.network(imageUrl),
          Text('${list.main.tempMin.round()} / ${list.main.tempMax.round()}  \u2103'),
        ],
      ),
    );
  }
}
