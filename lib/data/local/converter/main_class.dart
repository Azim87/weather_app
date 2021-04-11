import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:weather_app/model/forecast_weather.dart';

class MainClasses extends TypeConverter<MainClass, String> {
  @override
  MainClass decode(String databaseValue) {
    return MainClass.fromJson(
        jsonDecode(databaseValue));
  }

  @override
  String encode(MainClass value) {
    return jsonEncode(value.toJson());
  }
}
