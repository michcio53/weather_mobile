import 'package:flutter/widgets.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/l10n/l10n.dart';

class SearchBodyFailure extends StatelessWidget {
  const SearchBodyFailure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.searchFailureTitle,
            style: const TextStyle(fontSize: FontSizes.xLarge),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
