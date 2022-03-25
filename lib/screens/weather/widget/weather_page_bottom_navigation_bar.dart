import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/app/theme.dart';
import 'package:weather_mobile/l10n/l10n.dart';
import 'package:weather_mobile/screens/search/search_page.dart';
import 'package:weather_mobile/screens/weather/bloc/weather_bloc.dart';
import 'package:weather_mobile/utils/string_utils.dart';

class WeatherPageBottomNavigationBar extends StatelessWidget {
  const WeatherPageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        color: context.theme.backgroundColor,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ConversionSwitch(),
            SearchIconButton(),
          ],
        ),
      ),
    );
  }
}

class ConversionSwitch extends StatelessWidget {
  const ConversionSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return TextButton(
          onPressed: state.isLoading
              ? null
              : () =>
                  context.read<WeatherBloc>().add(WeatherConversionChanged()),
          child: Text(state.unitsEnum.toStringValue(context.l10n)),
        );
      },
    );
  }
}

class SearchIconButton extends StatelessWidget {
  const SearchIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final bloc = context.read<WeatherBloc>();

        return IconButton(
          onPressed: state.isLoading
              ? null
              : () async {
                  final result = await Navigator.of(context)
                      .pushNamed(SearchPage.routeName);
                  if (result is int) {
                    bloc.add(WeatherItemChoosed(woeid: result));
                  }
                },
          icon: const Icon(
            Icons.search,
          ),
        );
      },
    );
  }
}
