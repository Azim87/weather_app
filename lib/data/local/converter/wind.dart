import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:weather_app/model/forecast_weather.dart';

class WindConverter extends TypeConverter<Wind, String> {
  @override
  Wind decode(String databaseValue) {
    return Wind.fromJson(jsonDecode(databaseValue.toString()));
  }

  @override
  String encode(Wind value) {
    return jsonEncode(value.toJson());
  }
}
