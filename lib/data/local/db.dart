import 'dart:async';


import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:weather_app/data/local/converter/city.dart';
import 'package:weather_app/data/local/converter/converter.dart';
import 'package:weather_app/data/local/dao.dart';
import 'package:weather_app/model/forecast_weather.dart';

part 'db.g.dart';



@Database(version: 3, entities: [WeatherForecastResponse])
abstract class WeatherDb extends FloorDatabase {
  WeatherDao get dao;
}
