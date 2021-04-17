import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Datenbank {
  Future<Database> database;

  Future<void> databaseInit() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'diaries.db'),
      // When the database is first created, create a table to store diaries.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE diaries(date TEXT PRIMARY KEY, entry TEXT)",
        );
      },

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<List<Diary>> diaries() async {
    // Get a reference to the database.
    await databaseInit();
    final Database db = await database;

    // Query the table for all The diaries.
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM diaries ORDER BY date(date) DESC');

    // Convert the List<Map<String, dynamic> into a List<Diary>.
    return List.generate(maps.length, (i) {
      return Diary(
        date: maps[i]['date'],
        entry: maps[i]['entry'],
      );
    });
  }

  Future<void> updateDiary(String date, String text) async {
    // Get a reference to the database.
    await databaseInit();
    final db = await database;
    Diary diary = Diary(date: date, entry: text);

    // Update the given Diary.
    await db.update(
      'diaries',
      diary.toMap(),
      // Ensure that the Diary has a matching id.
      where: "date = ?",
      // Pass the Diary's id as a whereArg to prevent SQL injection.
      whereArgs: [date],
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<void> insertDiary(String date, String text) async {
    // Get a reference to the database.
    await databaseInit();
    final Database db = await database;

    Diary diary = Diary(date: date, entry: text);
    String _diary = diary.toString();

    debugPrint('diary: $_diary');

    // Insert the Diary into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'diaries',
      diary.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteDiary(String date) async {
    // Get a reference to the database.
    await databaseInit();
    final db = await database;

    // Remove the Diary from the database.
    await db.delete('diaries',
        // Use a `where` clause to delete a specific dog.
        where: "date = ?",
        // Pass the Diary's id as a whereArg to prevent SQL injection.
        whereArgs: [
          date,
        ]);
  }

  Future<void> deleteAllDiaries() async {
    // Get a reference to the database.
    await databaseInit();
    final db = await database;

    // Remove the Diary from the database.
    await db.rawQuery('Delete FROM diaries');
  }
}

class Diary {
  final String date;
  final String entry;

  Diary({this.date, this.entry});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'entry': entry,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Diary{date: $date, entry: $entry}';
  }
}
