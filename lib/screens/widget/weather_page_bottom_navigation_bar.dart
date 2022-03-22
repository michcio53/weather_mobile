import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/utils/string_utils.dart';

class WeatherPageBottomNavigationBar extends StatelessWidget {
  const WeatherPageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConversionSwitch(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          )
        ],
      ),
    );
  }
}

class ConversionSwitch extends StatelessWidget {
  const ConversionSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: ((context, state) {
        print(state.unitsEnum);
        return TextButton(
          onPressed: () => context.read<WeatherBloc>().add(WeatherConversionChanged()),
          child: Text(state.unitsEnum.toStringValue(context.l10n)),
        );
      }),
    );
  }
}
