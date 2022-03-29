import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' show getDatabasesPath;

import '../dao/dao.dart';
import '../tables/tables.dart';

part 'database.g.dart';

/// flutter packages pub run build_runner build --delete-conflicting-outputs
@DriftDatabase(
  tables: [LoginUserInfos],
  daos: [LoginUserInfoDao],
)
class Database extends _$Database {
  Database()
      : super(
          LazyDatabase(
            () async {
              final dbFolder = await getDatabasesPath();
              final file = File(p.join(dbFolder, 'db.sqlite'));
              return NativeDatabase(file, logStatements: kDebugMode);
            },
          ),
        );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (final m) => m.createAll(),
        onUpgrade: (final m, final from, final to) async {
          if (from == 1) {
            // we added the dueDate property in the change from version 1
            // await m.addColumn(todos, todos.dueDate);
          }
        },
      );
}
