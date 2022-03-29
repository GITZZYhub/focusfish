import 'package:drift/drift.dart';

@DataClassName('LoginUserInfo')
class LoginUserInfos extends Table {

  TextColumn get avatarPath => text().nullable()();

  TextColumn get birthday => text().nullable()();

  IntColumn get gender => integer().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get name => text().nullable()();

  TextColumn get userId => text().nullable()();

  @override
  Set<Column<dynamic>> get primaryKey => {userId};
}
