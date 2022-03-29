// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      json['birthday'] as String?,
      json['firstname'] as String?,
      json['gender'] as int?,
      json['avatar'] as String?,
      json['lastname'] as String?,
      json['token'] as String?,
      json['idUser'] as String?,
      json['nickname'] as String?,
      json['email'] as String?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'birthday': instance.birthday,
      'firstname': instance.firstname,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'lastname': instance.lastname,
      'token': instance.token,
      'idUser': instance.idUser,
      'nickname': instance.nickname,
      'email': instance.email,
    };

LoginAuths _$LoginAuthsFromJson(Map<String, dynamic> json) => LoginAuths(
      json['idUser'] as String?,
      json['identifier'] as String?,
      json['identityType'] as int?,
      json['verified'] as int?,
      json['timeLast'] as int?,
      json['timeAdd'] as int?,
      json['idAuth'] as String,
    );

Map<String, dynamic> _$LoginAuthsToJson(LoginAuths instance) =>
    <String, dynamic>{
      'idUser': instance.idUser,
      'identifier': instance.identifier,
      'identityType': instance.identityType,
      'verified': instance.verified,
      'timeLast': instance.timeLast,
      'timeAdd': instance.timeAdd,
      'idAuth': instance.idAuth,
    };
