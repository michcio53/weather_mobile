class Location {
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
        other.title == title &&
        other.locationType == locationType &&
        other.lattLong == lattLong &&
        other.woeid == woeid;
  }

  @override
  int get hashCode {
    return title.hashCode ^ locationType.hashCode ^ lattLong.hashCode ^ woeid.hashCode;
  }
}
