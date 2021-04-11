import 'package:floor/floor.dart';
import 'package:weather_app/model/forecast_weather.dart';

@dao
abstract class WeatherDao {
  @Insert(onConflict : OnConflictStrategy.replace)
  Future<void> insertAllWeather(WeatherForecastResponse weather);

  @Query('SELECT * FROM WeatherForecastResponse')
  Future<WeatherForecastResponse?> getAllWeather();
}
