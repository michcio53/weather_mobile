// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      title: json['title'] as String,
      locationType: json['location_type'] as String,
      lattLong: json['latt_long'] as String,
      woeid: json['woeid'] as int,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'location_type': instance.locationType,
      'latt_long': instance.lattLong,
      'woeid': instance.woeid,
    };
