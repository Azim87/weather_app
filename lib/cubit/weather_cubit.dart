import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/local/dao.dart';
import 'package:weather_app/data/local/db.dart';
import '../data/repository/weather_repository.dart';
import '../model/forecast_weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState());

  final _repository = WeatherRepository();

  String name = '';
  bool metric = false;

  Future fetchForecastWeather({String? cityName, bool? isMetric}) async {
    final database =
        await $FloorWeatherDb.databaseBuilder("weather_db").build();
    final personDao = database.dao;
    emit(WeatherLoadingState());
    try {
      final forecastWeather = await _repository.fetchWeatherForecast(
          cityName!, isMetric! ? 'metric' : "");
      personDao.insertAllWeather(forecastWeather);
      emit(ForecastWeatherState(response: forecastWeather));
    } on SocketException catch (ex) {
      print(ex.toString());
      var response = await personDao.getAllWeather();
      emit(ForecastWeatherState(response: response!));
      print('response from dd: ${response.id}');
    }
  }

  Future changeCelToFahr(bool metric) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("metric", metric);
    emit(ForecastTypeWeatherState(isMetric: metric));
  }
}
