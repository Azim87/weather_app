import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:weather_app/model/forecast_weather.dart';

class WeatherConverter extends TypeConverter<Weather, String> {
  @override
  Weather decode(String databaseValue) {
    return Weather.fromJson(jsonDecode(databaseValue));
  }

  @override
  String encode(Weather value) {
    return jsonEncode(value.toJson());
  }
}
