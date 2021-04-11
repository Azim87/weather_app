import '../api_client/weather_client.dart';
import '../../model/forecast_weather.dart';

class WeatherRepository {
  final _weatherClient = WeatherClient();

  Future<WeatherForecastResponse> fetchWeatherForecast(
      String cityName, String metric) async {
    return _weatherClient.fetchWeatherForecast(cityName, metric);
  }
}
