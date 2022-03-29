import 'package:json_annotation/json_annotation.dart';

part 'result_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResultResponse<T> {
  dynamic code;

  String message;

  T? data;

  ResultResponse(
    this.code,
    this.message,
    this.data,
  );

  factory ResultResponse.fromJson(
    final Map<String, dynamic> json,
    final T Function(Object? json) fromJsonT,
  ) =>
      _$ResultResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(final Object? Function(T value) toJsonT) =>
      _$ResultResponseToJson(this, toJsonT);
}
