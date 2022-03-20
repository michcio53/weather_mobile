import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class LocationModel {
  const LocationModel({
    required this.title,
    required this.locationType,
    required this.lattLong,
    required this.woeid,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  final String title;
  final String locationType;
  final String lattLong;
  final int woeid;

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
