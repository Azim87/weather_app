import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../api_key.dart';
import '../../model/forecast_weather.dart';

class WeatherClient {
  Future<WeatherForecastResponse> fetchWeatherForecast(
      String cityName, String metric) async {
    final String url =
        "$BASE_API/forecast?q=$cityName&appid=$API_KEY&units=$metric";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherForecastResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }
}
