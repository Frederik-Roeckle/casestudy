import 'dart:async';


import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodEntry.Dart';

class MoodDatabase {

  Future<Database> database;

  Future<void> initaliseDatabase() async {
    String databasePath = await getDatabasesPath();
    database = openDatabase(
      join(databasePath, "Mood"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE Mood(DateTime TEXT PRIMARY KEY, MoodInPoints REAL, Schmerzen INTEGER, Schmerzbeschreibung TEXT, PsychologischeVerfassung TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertElement (MoodEntry moodEntry) async {
      final Database db = await database;
      await db.insert("Mood", moodEntry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MoodEntry>> retrieveElements() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Mood');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return MoodEntry(
        dateTime: maps[i]["DateTime"],
        moodInPoints: maps[i]["MoodInPoints"],
        schmerzen: maps[i]["Schmerzen"],
        schmerzBeschreibung: maps[i]["Schmerzbeschreibung"],
        psychologischeVerfassung: maps[i]["PsychologischeVerfassung"],
      );
    });
  }


}
