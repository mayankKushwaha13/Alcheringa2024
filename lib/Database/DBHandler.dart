import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/cart_model.dart';

class DBHandler{
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
    if (_database != null){
      return _database;
    }

    String path = join(await getDatabasesPath(), 'alcherDatabase.db');
    await openDatabase(path, version : 1, 
    onCreate: (db, version) async {
      await db.execute(
        '''
        CREATE TABLE $tableName (
          $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
          $nameCol TEXT,
          $countCol TEXT,
          $priceCol TEXT,
          $sizeCol TEXT,
          $imageCol TEXT,
          $typeCol TEXT
        )
        '''
      );
      log("Logging SQL Table");
      log("on create finally ran");
    },
    onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS $tableName");
        String path = join(await getDatabasesPath(), 'alcherDatabase.db');
        await openDatabase(path, version: newVersion,
          onCreate: (db, version) async {
            await db.execute(
              '''
              CREATE TABLE $tableName (
                $idCol INTEGER PRIMARY KEY AUTOINCREMENT,
                $nameCol TEXT,
                $countCol TEXT,
                $priceCol TEXT,
                $sizeCol TEXT,
                $imageCol TEXT,
                $typeCol TEXT
              )
              '''
            );
            log("Logging SQL Table");
            log("on upgrade and on create finally ran");
          },
        );
      },

    );
    
    return _database;
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

  void addNewItemToCart(String name,String price,String size,String count,String imageURL,String type,Context context) async {
    Database? db = await database;
    Map<String, Object?> map = {
      nameCol : name, 
      countCol : count,
      priceCol : price,
      sizeCol : size,
      imageCol : imageURL,
      typeCol : type,
    };
    final List<Map<String, dynamic>> existingItems = await db!.query(
      tableName,
      where: '$nameCol = ? AND $size = ?',
      whereArgs: [name, size],
    );
    if (existingItems.isNotEmpty) {
      int updatedCount = int.parse(existingItems.first[countCol]) + 1;

      map[countCol] = updatedCount.toString();
      await db.update(
        tableName,
        map,
        where: 'name = ? AND size = ?',
        whereArgs: [name, size],
      );
    } else {
      await db.insert(tableName, map);
    }
  }

  Future<void> removeFromCart(String name, String price, String size, String count) async {
    Database? db = await database;
    final map = {
      nameCol : name,
      priceCol : price,
      sizeCol : size,
      countCol : count,
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
      }else {
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

}