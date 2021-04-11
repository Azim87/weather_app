import 'dart:convert';

import 'package:floor/floor.dart';

import 'package:weather_app/model/forecast_weather.dart';

class WeatherConverter extends TypeConverter<List<ListElement>, String> {
  @override
  List<ListElement> decode(String databaseValue) {
    return jsonDecode(databaseValue)
        .map<WeatherForecastResponse>(
            (item) => WeatherForecastResponse.fromJson(item))
        .toList();
  }

  @override
  String encode(List<ListElement> value) {
    return jsonEncode(value.toList());
  }
}
