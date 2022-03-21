import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.title,
    required this.locationType,
    required this.lattLong,
    required this.woeid,
  });

  final String title;
  final String locationType;
  final String lattLong;
  final int woeid;

  Location copyWith({
    String? title,
    String? locationType,
    String? lattLong,
    int? woeid,
  }) {
    return Location(
      title: title ?? this.title,
      locationType: locationType ?? this.locationType,
      lattLong: lattLong ?? this.lattLong,
      woeid: woeid ?? this.woeid,
    );
  }

  @override
  List<Object?> get props => [
        title,
        locationType,
        lattLong,
        woeid,
      ];
}
