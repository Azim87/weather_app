part of 'weather_cubit.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}
class WeatherTypeState extends WeatherState {}

class ForecastWeatherState extends WeatherState {
  final WeatherForecastResponse response;
  ForecastWeatherState({required this.response});
}

class ForecastWeatherNoConnectionState extends WeatherState {
  final WeatherForecastResponse response;
  ForecastWeatherNoConnectionState({required this.response});
}

class ForecastTypeWeatherState extends WeatherState {
  bool isMetric;
  ForecastTypeWeatherState({required this.isMetric});
}

class WeatherErrorState extends WeatherState {
  final String errorMessage;
  WeatherErrorState({required this.errorMessage});
}
