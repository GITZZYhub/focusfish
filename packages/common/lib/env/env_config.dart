import 'package:json_annotation/json_annotation.dart';

part 'env_config.g.dart';

///环境配置 flutter pub run build_runner build
@JsonSerializable(createToJson: false)
class EnvConfig {
  final String? env;
  final bool? debug;

  EnvConfig({
    this.env,
    this.debug,
  });

  factory EnvConfig.fromJson(Map<String, dynamic> json) =>
      _$EnvConfigFromJson(json);
}
