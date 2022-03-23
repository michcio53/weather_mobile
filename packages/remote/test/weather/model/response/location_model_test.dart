import 'package:remote/weather/model/response/location_model.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('check if model correctly maps the fields', () async {
    final locationModel = LocationModel.fromJson(location);
    expect(locationModel.title, 'New York');
    expect(locationModel.locationType, 'City');
    expect(locationModel.woeid, 2459115);
    expect(locationModel.lattLong, '40.71455,-74.007118');
  });

  test('check if model creates json', () {
    final locationModel = LocationModel.fromJson(location);
    final jsonModel = locationModel.toJson();
    expect(jsonModel, location);
  });
}

final location = <String, dynamic>{
  "title": "New York",
  "location_type": "City",
  "woeid": 2459115,
  "latt_long": "40.71455,-74.007118",
};
