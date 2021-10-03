import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tobo/page/home/model/tobo.dart';

class DbManager {
  //数据库版本号
  static const _dbVersion = 1;

//数据库版本名称
  static const _dbName = 'todo.db';

  //tobo
  static const _dbTableAccount = 'tobo';

  static DbManager? _instance;
  late Database _database;

  DbManager._() {
    init();
  }

  static DbManager get instance => _instance ??= DbManager._();

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, _dbName);

    // Delete the database
    //await deleteDatabase(path);

    // open the database
    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        debugPrint('openDatabase version = ' + version.toString());

        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE IF NOT EXISTS $_dbTableAccount (objectId TEXT PRIMARY KEY UNIQUE,createdAt TEXT, updatedAt TEXT, content TEXT, done INT)');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        debugPrint('onUpgrade oldVersion = ' +
            oldVersion.toString() +
            ' newVersion = ' +
            newVersion.toString());

        _onUpgrade(db, oldVersion, newVersion);
      },
    );
  }

  Database getDB() => _database;

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    switch (oldVersion) {
      case 1:
        switch (newVersion) {
          // case 2:
          //   update1to2(db);
          //   break;
          // case 3:
          //   update1to2(db);
          //   update2to3(db);
          //   break;
        }
        break;
      case 2:
        // update2to3(db);
        break;
    }
  }

  Future<void> update1to2(Database db) async {
    debugPrint('openDatabase update 1to2 = ');
    // await db.execute(
    //     'CREATE TABLE IF NOT EXISTS $DB_REGISTRATION (registration_id TEXT PRIMARY KEY ,websocket_url TEXT)');
  }

  Future<List<Tobo>> getToboList() async {
    final list = await _database.rawQuery('SELECT * FROM $_dbTableAccount');
    final List<Tobo> toboList = [];
    if (list.isNotEmpty) {
      for (final element in list) {
        toboList.add(Tobo.fromJson(element));
      }
    }

    debugPrint('db toboList = ${toboList.length}');
    return toboList;
  }

  Future<void> deleteTobo(Tobo tobo) async {
    print('delete =');
    //要清除表数据，避免只删了栈顶的单条数据
    await _database.rawQuery(
        'DELETE FROM $_dbTableAccount WHERE objectId = ?', [tobo.objectId!]);
  }
  Future<void> deleteAllTobo() async {
    print('delete all=');
    //要清除表数据，避免只删了栈顶的单条数据
    await _database.rawQuery(
        'DELETE FROM $_dbTableAccount');
  }

  Future<int> saveOrUpdateTobo(Tobo info) async {
    print('openDatabase saveOrUpdateAccount = ' + info.toString());
    print('openDatabase info.objectId = ${info.objectId}');

    final rawQuery = await _database.rawQuery(
        'SELECT * FROM $_dbTableAccount WHERE objectId = ?', [info.objectId!]);

    int result = 0;

    if (rawQuery.isEmpty) {
      result = await _database.rawInsert(
          'INSERT INTO $_dbTableAccount(createdAt, updatedAt, content, done) VALUES(?, ?, ?, ?)',
          [info.createdAt, info.updatedAt, info.content, info.done]);
    } else {
      result = await _database.rawUpdate(
          'UPDATE $_dbTableAccount SET createdAt = ?,updatedAt = ?,content = ?,done = ?',
          [info.createdAt, info.updatedAt, info.content, info.done]);
    }

    return result;
  }
}
