import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/ui/widgets/weather_forecast_item.dart';

class WeatherSearchScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WeatherSearchScreenState createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  late TextEditingController _controller;
  final _formKey = new GlobalKey<FormState>();
  bool isMetric = false;

  @override
  void initState() {
    _getValueFromShared();
    _controller = TextEditingController();

    super.initState();
  }

  void _getValueFromShared() async {
    final _prefs = await SharedPreferences.getInstance();
    setState(() {
      isMetric = _prefs.getBool('metric')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    WeatherCubit cubit = BlocProvider.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('WeatherApp'),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  isMetric = !isMetric;
                });

                if (!_formKey.currentState!.validate()) return;
                cubit.changeCelToFahr(isMetric);
              },
              child: Text(
                !isMetric ? 'C' : 'F',
                style: TextStyle(color: Colors.white, fontSize: 25),
              )),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a city name';
                  }
                  return null;
                },
                controller: _controller,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      fetchWeatherForecast(context, true);
                    },
                  ),
                  labelText: 'Search city',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
            ),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  return CircularProgressIndicator();
                }
                if (state is ForecastWeatherState) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return WeatherForecastItem(
                          list: state.response.list[index],
                        );
                      },
                      itemCount: state.response.list.length,
                    ),
                  );
                }
                if (state is ForecastTypeWeatherState) {
                  if (state.isMetric) {
                    fetchWeatherForecast(context, false);
                  } else {
                    fetchWeatherForecast(context, true);
                  }
                }
                if(state is ForecastWeatherNoConnectionState) {
                  print(state.response);
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fetchWeatherForecast(BuildContext context, bool metic) {
    BlocProvider.of<WeatherCubit>(context)
        .fetchForecastWeather(cityName: _controller.text, isMetric: metic);
  }
}
