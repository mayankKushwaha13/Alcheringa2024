import 'package:alcheringa/Model/eventdetail.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LikedEventsDatabase{
  static Database? _likedEventsDB;

  // Future<void> deletedatabase () async {
  //   String path = join(await getDatabasesPath(), 'likedEventsDatabase.db');
  //   await deleteDatabase(path);
  //   print("Database deleted successfully.");

  // }

  Future<Database?> get likedEventsDatabase async {
    if (_likedEventsDB != null){
      return _likedEventsDB;
    }

    String path = join(await getDatabasesPath(), 'likedEventsDatabase.db');
    _likedEventsDB = await openDatabase(
      path, version: 2,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE likedEvents(
          artist TEXT,
          category TEXT,
          mode TEXT,
          imgurl TEXT,
          description TEXT,
          venue TEXT,
          type TEXT,
          joinlink TEXT,
          reglink TEXT,
          duration INTEGER,
          genre TEXT,
          time TEXT,
          stream INTEGER,
          descriptionShort TEXT,
          iconurl TEXT
          )
          '''
        );
      }
    );
    return _likedEventsDB;
  }

  insertData(EventDetail event) async {
    Database? db = await likedEventsDatabase;
    db!.insert('likedEvents', event.toTable());
    print("added");
  }

  Future<List<EventDetail>> readData() async {
    Database? db = await likedEventsDatabase;
    final list = await db!.query('likedEvents');
    return list.map((map)=>EventDetail.fromTable(map)).toList();
  }

  deleteData(String artist) async {
    Database? db = await likedEventsDatabase;
    await db!.delete('likedEvents',where: "artist = ?", whereArgs: [artist]);
    print("Deleted");
  }
}