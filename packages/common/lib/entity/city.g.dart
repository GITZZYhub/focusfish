// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      json['tagIndex'] as String?,
      json['value'] as String?,
      json['zh'] as String,
      json['tr'] as String,
      json['en'] as String,
      json['locale'] as String,
      json['code'] as int,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'tagIndex': instance.tagIndex,
      'value': instance.value,
      'zh': instance.zh,
      'tr': instance.tr,
      'en': instance.en,
      'locale': instance.locale,
      'code': instance.code,
    };
