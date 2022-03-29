import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City extends Object {
  @JsonKey(name: 'tagIndex')
  String? tagIndex;

  @JsonKey(name: 'value')
  String? value;

  @JsonKey(name: 'zh')
  String zh;

  @JsonKey(name: 'tr')
  String tr;

  @JsonKey(name: 'en')
  String en;

  @JsonKey(name: 'locale')
  String locale;

  @JsonKey(name: 'code')
  int code;

  City(
    this.tagIndex,
    this.value,
    this.zh,
    this.tr,
    this.en,
    this.locale,
    this.code,
  );

  factory City.fromJson(final Map<String, dynamic> srcJson) =>
      _$CityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  String getSuspensionTag() => tagIndex ?? '';
}
