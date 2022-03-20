import 'package:domain/model/location.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/weather/model/response/location_model.dart';

class LocationMapper implements Mapper<LocationModel, Location> {
  const LocationMapper();

  @override
  Location map(LocationModel element) {
    return Location(
      title: element.title,
      locationType: element.locationType,
      woeid: element.woeid,
      lattLong: element.lattLong,
    );
  }
}
