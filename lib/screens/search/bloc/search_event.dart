part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchTyped extends SearchEvent {
  SearchTyped({
    required this.query,
  });

  final String query;
}
