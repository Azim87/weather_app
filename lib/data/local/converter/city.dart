import 'dart:convert';

import 'package:floor/floor.dart';

import 'package:weather_app/model/forecast_weather.dart';

class CityConverter extends TypeConverter<City, String> {
  @override
  City decode(String databaseValue) {
    return City.fromJson(jsonDecode(databaseValue));
  }

  @override
  String encode(City value) {
    return jsonEncode(value.toJson());
  }
}
