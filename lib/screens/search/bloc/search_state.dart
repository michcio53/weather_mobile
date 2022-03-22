part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  const SearchSuccess({required this.locations});

  final List<Location> locations;

  @override
  List<Object> get props => [locations];
}

class SearchFailure extends SearchState {}
