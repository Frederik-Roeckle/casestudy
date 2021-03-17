import 'dart:async';


import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodEntry.Dart';

class MoodDatabase {

  Future<Database> database;

  Future<void> initaliseDatabase(String databaseName) async {
    String databasePath = await getDatabasesPath();
    database = openDatabase(
      join(databasePath, databaseName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE Test(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertElement (MoodEntry moodEntry) async {
      final Database db = await database;
      await db.insert("Test", moodEntry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MoodEntry>> retrieveElements() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Test');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return MoodEntry(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }


}
