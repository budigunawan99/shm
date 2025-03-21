import 'dart:async';

import 'package:shm/model/product.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'shm-app.db';
  static const String _tableName = 'product';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE $_tableName(
      code TEXT PRIMARY KEY,
      title TEXT,
      description TEXT,
      created INTEGER,
      updated INTEGER,
      imagePath TEXT
     )
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
      final results = await db.query(
        _tableName,
        where: "title LIKE ?",
        whereArgs: ["%$title%"],
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
}
