import 'package:floor/floor.dart';
import 'package:weather_app/data/local/converter/city.dart';
import 'package:weather_app/data/local/converter/converter.dart';
import 'package:weather_app/data/local/converter/date_time.dart';
import 'package:weather_app/data/local/converter/main_class.dart';
import 'package:weather_app/data/local/converter/wind.dart';

@entity
class WeatherForecastResponse {
  WeatherForecastResponse({
    required this.id,
    required this.cnt,
    required this.list,
    required this.city,
  });
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int cnt;

  @TypeConverters([WeatherConverter])
  final List<ListElement> list;


  @TypeConverters([CityConverter])
  final City city;

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) =>
      WeatherForecastResponse(
        id: 0,

        cnt: json["cnt"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json["city"]),
      );
}

class City {
  City({
    required this.id,
    required this.name,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  final int id;
  final String name;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class ListElement {
  ListElement({
    required this.main,
    required this.weather,
    required this.wind,
    required this.dtTxt,
  });
  @TypeConverters([MainClasses])
  final MainClass main;

  @TypeConverters([WeatherConverter])
  final List<Weather> weather;

  @TypeConverters([WindConverter])
  final Wind wind;

  @TypeConverters([DateTimeConverter])
  final DateTime dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        main: MainClass.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        wind: Wind.fromJson(json["wind"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "wind": wind.toJson(),
        "dt_txt": dtTxt.toIso8601String(),
      };
}

class MainClass {
  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class Weather {
  Weather({
    required this.id,
    required this.description,
    required this.icon,
  });

  final int id;
  final String description;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": mainEnumValues.reverse['main'],
    "description": descriptionValues.reverse[description],
    "icon": iconValues.reverse[icon],
  };
}

enum Description { CLEAR_SKY, SCATTERED_CLOUDS, OVERCAST_CLOUDS, BROKEN_CLOUDS }

final descriptionValues = EnumValues({
  "broken clouds": Description.BROKEN_CLOUDS,
  "clear sky": Description.CLEAR_SKY,
  "overcast clouds": Description.OVERCAST_CLOUDS,
  "scattered clouds": Description.SCATTERED_CLOUDS
});

enum Icon { THE_01_N, THE_01_D, THE_03_D, THE_04_N, THE_04_D, THE_03_N }

final iconValues = EnumValues({
  "01d": Icon.THE_01_D,
  "01n": Icon.THE_01_N,
  "03d": Icon.THE_03_D,
  "03n": Icon.THE_03_N,
  "04d": Icon.THE_04_D,
  "04n": Icon.THE_04_N
});

enum MainEnum { CLEAR, CLOUDS }

final mainEnumValues = EnumValues({
  "Clear": MainEnum.CLEAR,
  "Clouds": MainEnum.CLOUDS
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map!.map((k, v) => new MapEntry(v, k));
    return reverseMap!;
  }
}

enum Pod { N, D }

final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});


class  Wind {
  Wind({
    required this.speed,
    required this.deg,
  });

  final double speed;
  final int deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"].toDouble(),
    deg: json["deg"],
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
  };
}
