import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Datenbank {
  Future<Database> database;

  //Initialisieren der Datenbank
  Future<void> databaseInit() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'appoints.db'),
      // When the database is first created, create a table to store appoints.
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE appoints(id INTEGER PRIMARY KEY, description TEXT, start TEXT, end TEXT)",
        );
        db.insert(
            'appoints',
            //Einsetzen Mocktermins, damit der FutureBuilder des Kalenders laden kann.
            Appoint(
                    id: 0,
                    description: 'null',
                    start: '2019-09-07T15:50+01:00',
                    end: '2019-09-07T16:50+01:00')
                .toMap());
      },

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  //ausgeben aller Eintraege der Datenbank
  Future<List<Appoint>> appoint() async {
    // Get a reference to the database.
    await databaseInit();
    final Database db = await database;

    // Query the table for all The appoints.
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM appoints');

    // Convert the List<Map<String, dynamic> into a List<Appoint>.
    return List.generate(maps.length, (i) {
      return Appoint(
        id: maps[i]['id'],
        description: maps[i]['description'],
        start: maps[i]['start'],
        end: maps[i]['end'],
      );
    });
  }

  //aendern eines Datenbankeintrages
  Future<void> updateAppoint(
      String notes, String _description, String _start, String _end) async {
    // Get a reference to the database.
    await databaseInit();
    final db = await database;

    int id = int.parse(notes);
    Appoint app =
        Appoint(id: id, description: _description, start: _start, end: _end);

    // Update the given Appoint.
    await db.update(
      'Appoints',
      app.toMap(),
      // Ensure that the Appoint has a matching id.
      where: "id = ?",
      // Pass the Appoint's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  //Einfuegen eines neuen Kalendereintrages
  Future<void> insertAppoint(
      String description, String start, String end) async {
    // Get a reference to the database.
    await databaseInit();
    final Database db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT id, MAX([id]) FROM appoints');
    int idalt;
    if (maps[0]['id'] == null) {
      idalt = 0;
    } else {
      idalt = maps[0]['id'];
    }
    int id = ++idalt;
    Appoint app =
        Appoint(id: id, description: description, start: start, end: end);

    // Insert the Appoint into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    debugPrint(app.toString());
    await db.insert(
      'appoints',
      app.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Loeschen eines Kalendereintrags
  Future<void> deleteAppoint(String notes) async {
    // Get a reference to the database.
    await databaseInit();
    final db = await database;
    int id = int.parse(notes);
    // Remove the Appoint from the database.
    await db.delete('appoints',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Appoint's id as a whereArg to prevent SQL injection.
        whereArgs: [
          id,
        ]);
  }

  //Loeschen aller Kalendereintraege, nur für development-Zwecke
  Future<void> deleteAllAppoints() async {
    // Get a reference to the database.
    await databaseInit();
    final db = await database;

    // Remove the Appoint from the database.
    await db.rawQuery('Delete FROM appoints');
  }
}

//Appoint-Objekt für die Datenbank
class Appoint {
  final int id;
  final String description;
  final String start;
  final String end;

  Appoint({this.id, this.description, this.start, this.end});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'start': start,
      'end': end,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Appoint{id: $id, description: $description, start: $start,end: $end}';
  }
}
