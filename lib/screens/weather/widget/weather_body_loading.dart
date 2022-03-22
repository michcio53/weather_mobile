import 'package:flutter/material.dart';

class WeatherBodyLoading extends StatelessWidget {
  const WeatherBodyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
