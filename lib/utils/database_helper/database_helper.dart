import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConfig {
  // 数据库相关命名
  static const String DBName = "netease.db";
  static const String recommendSongListTableName = "RecommendSongList";
  static const String bannerTableName = "Banner";
  static const String newAlbumTableName = "NewAlbum";
  static const String newSongTableName = "NewSong";
}

class DBHelper {
  /// create a private constructor that can be used only inside the class
  DBHelper._();
  static final DBHelper db = DBHelper._();

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      await initDB(false);
    }
    return _database;
  }

  initDB(bool init) async {
    String path = await initDeleteDB(init);
    _database = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DBConfig.newAlbumTableName}(
        id INTEGER PRIMARY KEY,
        picUrl TEXT,
        name TEXT,
        publishTime INTEGER,
        artistsName TEXT
      );
      ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DBConfig.newSongTableName}(
        id INTEGER PRIMARY KEY,
        picUrl TEXT,
        name TEXT,
        artistsName TEXT
      );
      ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DBConfig.recommendSongListTableName}(
        id INTEGER PRIMARY KEY,
        picUrl TEXT,
        pageUrl TEXT,
        name TEXT,
        playCount REAL,
        canDislike INTEGER,
        copywriter TEXT,
        highQuality INTEGER,
        trackCount INTEGER,
        type INTEGER
      );
      ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DBConfig.bannerTableName}(
        id INTEGER PRIMARY KEY,
        picUrl TEXT,
        pageUrl TEXT,
        subtitle TEXT,
        titleColor TEXT,
        showAdTag INTEGER,
        targetType INTEGER,
        targetId INTEGER
      );
      ''');
    });
  }

  initDeleteDB(init) async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, DBConfig.DBName);
    if (init) {
      if (await Directory(dirname(path)).exists()) {
        await deleteDatabase(path);
      } else {
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (e) {
          print(e);
        }
      }
    }

    return path;
  }

  close() async {
    var db = await database;
    return db.close();
  }
}
