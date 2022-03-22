import 'package:domain/model/location.dart';
import 'package:flutter/material.dart';

class SearchBodySuccess extends StatelessWidget {
  const SearchBodySuccess({Key? key, required this.locations})
      : super(key: key);

  final List<Location> locations;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: locations
          .map(
            (location) => ListTile(
              title: Text(location.title),
              onTap: () {
                Navigator.of(context).pop(location.woeid);
              },
            ),
          )
          .toList(),
    );
  }
}
