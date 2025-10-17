import 'dart:async';

import 'package:shm/model/product.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'shm-app.db';
  static const String _tableName = 'product';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    // Drop old versions if they exist
    await database.execute('DROP TABLE IF EXISTS $_tableName;');
    await database.execute('DROP TABLE IF EXISTS ${_tableName}_fts;');
    await database.execute('DROP TRIGGER IF EXISTS ${_tableName}_insert;');
    await database.execute('DROP TRIGGER IF EXISTS ${_tableName}_update;');
    await database.execute('DROP TRIGGER IF EXISTS ${_tableName}_delete;');

    // Create main table
    await database.execute("""
      CREATE TABLE $_tableName(
        code TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        created INTEGER,
        updated INTEGER,
        imagePath TEXT
      );
    """);

    // Create FTS4 table
    await database.execute("""
      CREATE VIRTUAL TABLE ${_tableName}_fts USING fts4(
        code,
        title,
        description
      );
    """);

    // Trigger on insert
    await database.execute("""
      CREATE TRIGGER ${_tableName}_insert AFTER INSERT ON $_tableName
        BEGIN
        INSERT INTO ${_tableName}_fts (code, title, description)
        VALUES (new.code, new.title, new.description);
        END;
    """);

    // Trigger on update
    await database.execute("""
      CREATE TRIGGER ${_tableName}_update AFTER UPDATE ON $_tableName
        BEGIN
        DELETE FROM ${_tableName}_fts WHERE code = old.code;
        INSERT INTO ${_tableName}_fts (code, title, description)
        VALUES (new.code, new.title, new.description);
      END;
    """);

    // Trigger on delete
    await database.execute("""
      CREATE TRIGGER ${_tableName}_delete AFTER DELETE ON $_tableName
      BEGIN
        DELETE FROM ${_tableName}_fts WHERE code = old.code;
      END;
    """);
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(Product product) async {
    try {
      final db = await _initializeDb();

      final data = product.toJson();
      final id = await db.insert(
        _tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<List<Product>> getAllItems() async {
    try {
      final db = await _initializeDb();
      final results = await db.query(
        _tableName,
        orderBy: "updated DESC",
      );

      if (results.isNotEmpty) {
        return results.map((result) => Product.fromJson(result)).toList();
      } else {
        return <Product>[];
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<int> removeItem(String code) async {
    try {
      final db = await _initializeDb();

      final result = await db.delete(
        _tableName,
        where: "code = ?",
        whereArgs: [code],
      );
      return result;
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<int> updateItem(String code, Product product) async {
    try {
      final db = await _initializeDb();

      final data = product.toJson();

      final result = await db.update(
        _tableName,
        data,
        where: "code = ?",
        whereArgs: [code],
      );
      return result;
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }

  Future<List<Product>> searchItemsByTitle(String title) async {
    try {
      final db = await _initializeDb();
      final tokens = title.trim().split(RegExp(r'\s+'));
      final wildCardTokens = tokens.map((token) => '$token*');
      final query = wildCardTokens.join(' ');

      var sql = """
        SELECT d.code, d.title, d.description, d.created, d.updated, d.imagePath
        FROM $_tableName d
        JOIN ${_tableName}_fts f ON d.code = f.code
        WHERE ${_tableName}_fts MATCH ?
      """;

      final results = await db.rawQuery(sql, [query]);

      if (results.isNotEmpty) {
        return results.map((result) => Product.fromJson(result)).toList();
      } else {
        return <Product>[];
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Waktu habis. Coba lagi nanti.');
      } else if (e is FormatException) {
        throw Exception('Gagal loading data. Coba lagi nanti.');
      } else {
        throw Exception("Terjadi kesalahan. Mohon coba lagi nanti.");
      }
    }
  }
}
