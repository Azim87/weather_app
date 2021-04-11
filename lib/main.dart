import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ui/screens/weather_search_screen.dart';
import './cubit/weather_cubit.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        WeatherSearchScreen.routeName: (ctx) => BlocProvider(
              create: (ctx) => WeatherCubit(),
              child: WeatherSearchScreen(),
            ),
      },
    );
  }
}
