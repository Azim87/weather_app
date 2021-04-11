import 'package:flutter/material.dart';

class WeatherText extends StatelessWidget {
  final String? subtext;
  final String? text;

  const WeatherText({this.subtext, this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(subtext!),
        Text(text!, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      ],
    );
  }
}