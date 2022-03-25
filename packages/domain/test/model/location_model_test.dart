import 'package:domain/model/location.dart';
import 'package:test/test.dart';

void main() {
  test('check if copyWith works', () {
    const location = Location(
      title: 'title',
      locationType: 'locationType',
      lattLong: 'lattLong',
      woeid: 123,
    );
    final locationWithChangedTitle = location.copyWith(title: 'newTitle');
    final locationWithChangedLocationType =
        location.copyWith(locationType: 'newLocationType');
    final locationWithChangedLatLong =
        location.copyWith(lattLong: 'newLatLong');
    final locationWithChangedWoeid = location.copyWith(woeid: 321);

    expect(locationWithChangedTitle.title, 'newTitle');
    expect(locationWithChangedLocationType.locationType, 'newLocationType');
    expect(locationWithChangedLatLong.lattLong, 'newLatLong');
    expect(locationWithChangedWoeid.woeid, 321);
  });
}
