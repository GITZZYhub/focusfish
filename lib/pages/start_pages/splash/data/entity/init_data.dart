import 'package:json_annotation/json_annotation.dart';

part 'init_data.g.dart';

@JsonSerializable()
class InitData {
  @JsonKey(name: 'data')
  String data;

  InitData(
    this.data,
  );

  factory InitData.fromJson(final Map<String, dynamic> srcJson) =>
      _$InitDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InitDataToJson(this);
}
