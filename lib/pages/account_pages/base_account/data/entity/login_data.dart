import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';

@JsonSerializable()
class LoginData extends Object {
  @JsonKey(name: 'birthday')
  String? birthday;

  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'gender')
  int? gender;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'lastname')
  String? lastname;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'idUser')
  String? idUser;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'email')
  String? email;

  LoginData(
    this.birthday,
    this.firstname,
    this.gender,
    this.avatar,
    this.lastname,
    this.token,
    this.idUser,
    this.nickname,
    this.email,
  );

  factory LoginData.fromJson(final Map<String, dynamic> srcJson) =>
      _$LoginDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class LoginAuths extends Object {
  @JsonKey(name: 'idUser')
  String? idUser;

  @JsonKey(name: 'identifier')
  String? identifier;

  @JsonKey(name: 'identityType')
  int? identityType;

  @JsonKey(name: 'verified')
  int? verified;

  @JsonKey(name: 'timeLast')
  int? timeLast;

  @JsonKey(name: 'timeAdd')
  int? timeAdd;

  @JsonKey(name: 'idAuth')
  String idAuth;

  LoginAuths(
    this.idUser,
    this.identifier,
    this.identityType,
    this.verified,
    this.timeLast,
    this.timeAdd,
    this.idAuth,
  );

  factory LoginAuths.fromJson(final Map<String, dynamic> srcJson) =>
      _$LoginAuthsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginAuthsToJson(this);
}
