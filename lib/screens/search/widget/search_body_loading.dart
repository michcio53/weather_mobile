import 'package:flutter/material.dart';

class SearchBodyLoading extends StatelessWidget {
  const SearchBodyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
