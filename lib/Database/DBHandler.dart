import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/cart_model.dart';

class DBHandler {
  Database? _database;
  static const String tableName = "CART";
  static const String idCol = "id";
  static const String nameCol = "name";
  static const String countCol = "count";
  static const String priceCol = "price";
  static const String sizeCol = "size";
  static const String imageCol = "image";
  static const String typeCol = "type";

  Future<Database?> get database async {
    if (_database != null) {
      return _database; // Return if already initialized
    }

    String path = join(await getDatabasesPath(), 'alcherDatabase.db');
    _database = await openDatabase(
      // Assign the database instance
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableName (
          $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
          $nameCol TEXT,
          $countCol TEXT,
          $priceCol TEXT,
          $sizeCol TEXT,
          $imageCol TEXT,
          $typeCol TEXT
        )
      ''');
        log("Database created and table initialized");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS $tableName");
        await db.execute('''
        CREATE TABLE $tableName (
          $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
          $nameCol TEXT,
          $countCol TEXT,
          $priceCol TEXT,
          $sizeCol TEXT,
          $imageCol TEXT,
          $typeCol TEXT
        )
      ''');
        log("Database upgraded and table re-initialized");
      },
    );

    return _database; // Ensure the instance is returned
  }

  Future<List<CartModel>> readCourses() async {
    final db = await database;
    List<CartModel> cartArray = [];

    final List<Map<String, dynamic>> cursorcart = await db!.query(tableName);

    for (var item in cursorcart) {
      cartArray.add(CartModel.fromMap(item));
    }

    return cartArray;
  }

  Future<void> addNewItemToCart(String name, String price, String size,
      String count, String imageURL, String type, BuildContext context) async {
    try {
      Database? db = await database;

      Map<String, Object?> map = {
        nameCol: name,
        countCol: count,
        priceCol: price,
        sizeCol: size,
        imageCol: imageURL,
        typeCol: type,
      };

      final List<Map<String, dynamic>> existingItems = await db!.query(
        tableName,
        where: '$nameCol = ? AND $sizeCol = ?',
        whereArgs: [name, size],
      );

      if (existingItems.isNotEmpty) {
        int updatedCount = int.parse(existingItems.first[countCol]) + 1;
        map[countCol] = updatedCount.toString();
        await db.update(
          tableName,
          map,
          where: '$nameCol = ? AND $sizeCol = ?',
          whereArgs: [name, size],
        );
      } else {
        await db.insert(tableName, map);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error adding item to cart: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> removeFromCart(
      String name, String price, String size, String count) async {
    Database? db = await database;
    final map = {
      nameCol: name,
      priceCol: price,
      sizeCol: size,
      countCol: count,
    };
    final List<Map<String, dynamic>> existingItems = await db!.query(
      tableName,
      where: '$nameCol = ? AND $sizeCol = ?',
      whereArgs: [name, size],
    );
    if (existingItems.isNotEmpty) {
      final existingItem = existingItems.first;
      int currentCount = int.parse(existingItem[countCol]);

      if (currentCount > 0) {
        int updatedCount = currentCount - 1;
        map[countCol] = updatedCount.toString();

        await db.update(
          tableName,
          map,
          where: '$nameCol = ? AND $sizeCol = ?',
          whereArgs: [name, size],
        );
      } else {
        map[countCol] = count;
        await db.insert(tableName, map);
      }
    }
  }

  Future<void> deleteItem(String name, String size) async {
    Database? db = await database;
    await db!.delete(
      tableName,
      where: '$nameCol = ? AND $sizeCol = ?',
      whereArgs: [name, size],
    );
  }

  Future<List<Map<String, dynamic>>> getData(String sql) async {
    Database? db = await database;
    return await db!.rawQuery(sql);
  }

  Future<void> deleteAll() async {
    Database? db = await database;
    await db!.execute("DELETE FROM $tableName");
  }

  Future<void> updateItemCount(String name, String size, String count) async {
    final db = await database;
    await db!.update(
      tableName,
      {countCol: count}, // Update count
      where: '$nameCol = ? AND $sizeCol = ?',
      whereArgs: [name, size],
    );
  }
}
