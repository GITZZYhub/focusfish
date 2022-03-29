// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class LoginUserInfo extends DataClass implements Insertable<LoginUserInfo> {
  final String? avatarPath;
  final String? birthday;
  final int? gender;
  final String? email;
  final String? name;
  final String? userId;
  LoginUserInfo(
      {this.avatarPath,
      this.birthday,
      this.gender,
      this.email,
      this.name,
      this.userId});
  factory LoginUserInfo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LoginUserInfo(
      avatarPath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}avatar_path']),
      birthday: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}birthday']),
      gender: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gender']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      userId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String?>(avatarPath);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<String?>(birthday);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<int?>(gender);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String?>(userId);
    }
    return map;
  }

  LoginUserInfosCompanion toCompanion(bool nullToAbsent) {
    return LoginUserInfosCompanion(
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory LoginUserInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoginUserInfo(
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      birthday: serializer.fromJson<String?>(json['birthday']),
      gender: serializer.fromJson<int?>(json['gender']),
      email: serializer.fromJson<String?>(json['email']),
      name: serializer.fromJson<String?>(json['name']),
      userId: serializer.fromJson<String?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'birthday': serializer.toJson<String?>(birthday),
      'gender': serializer.toJson<int?>(gender),
      'email': serializer.toJson<String?>(email),
      'name': serializer.toJson<String?>(name),
      'userId': serializer.toJson<String?>(userId),
    };
  }

  LoginUserInfo copyWith(
          {String? avatarPath,
          String? birthday,
          int? gender,
          String? email,
          String? name,
          String? userId}) =>
      LoginUserInfo(
        avatarPath: avatarPath ?? this.avatarPath,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        name: name ?? this.name,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('LoginUserInfo(')
          ..write('avatarPath: $avatarPath, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(avatarPath, birthday, gender, email, name, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginUserInfo &&
          other.avatarPath == this.avatarPath &&
          other.birthday == this.birthday &&
          other.gender == this.gender &&
          other.email == this.email &&
          other.name == this.name &&
          other.userId == this.userId);
}

class LoginUserInfosCompanion extends UpdateCompanion<LoginUserInfo> {
  final Value<String?> avatarPath;
  final Value<String?> birthday;
  final Value<int?> gender;
  final Value<String?> email;
  final Value<String?> name;
  final Value<String?> userId;
  const LoginUserInfosCompanion({
    this.avatarPath = const Value.absent(),
    this.birthday = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.userId = const Value.absent(),
  });
  LoginUserInfosCompanion.insert({
    this.avatarPath = const Value.absent(),
    this.birthday = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.userId = const Value.absent(),
  });
  static Insertable<LoginUserInfo> custom({
    Expression<String?>? avatarPath,
    Expression<String?>? birthday,
    Expression<int?>? gender,
    Expression<String?>? email,
    Expression<String?>? name,
    Expression<String?>? userId,
  }) {
    return RawValuesInsertable({
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (birthday != null) 'birthday': birthday,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (userId != null) 'user_id': userId,
    });
  }

  LoginUserInfosCompanion copyWith(
      {Value<String?>? avatarPath,
      Value<String?>? birthday,
      Value<int?>? gender,
      Value<String?>? email,
      Value<String?>? name,
      Value<String?>? userId}) {
    return LoginUserInfosCompanion(
      avatarPath: avatarPath ?? this.avatarPath,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String?>(avatarPath.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String?>(birthday.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int?>(gender.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String?>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoginUserInfosCompanion(')
          ..write('avatarPath: $avatarPath, ')
          ..write('birthday: $birthday, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $LoginUserInfosTable extends LoginUserInfos
    with TableInfo<$LoginUserInfosTable, LoginUserInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoginUserInfosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _avatarPathMeta = const VerificationMeta('avatarPath');
  @override
  late final GeneratedColumn<String?> avatarPath = GeneratedColumn<String?>(
      'avatar_path', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _birthdayMeta = const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<String?> birthday = GeneratedColumn<String?>(
      'birthday', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<int?> gender = GeneratedColumn<int?>(
      'gender', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String?> userId = GeneratedColumn<String?>(
      'user_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [avatarPath, birthday, gender, email, name, userId];
  @override
  String get aliasedName => _alias ?? 'login_user_infos';
  @override
  String get actualTableName => 'login_user_infos';
  @override
  VerificationContext validateIntegrity(Insertable<LoginUserInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('avatar_path')) {
      context.handle(
          _avatarPathMeta,
          avatarPath.isAcceptableOrUnknown(
              data['avatar_path']!, _avatarPathMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  LoginUserInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LoginUserInfo.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LoginUserInfosTable createAlias(String alias) {
    return $LoginUserInfosTable(attachedDatabase, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $LoginUserInfosTable loginUserInfos = $LoginUserInfosTable(this);
  late final LoginUserInfoDao loginUserInfoDao =
      LoginUserInfoDao(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [loginUserInfos];
}
