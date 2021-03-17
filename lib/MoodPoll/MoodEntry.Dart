
class MoodEntry {

  // Primary Key
  //final DateTime dateTime;
  final int id;

  //Mood auf 1-10 o.A. Definition
  //final int mood;
  final String name;

  //MoodEntry ({this.dateTime, this.mood});
  MoodEntry ({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
    };
  }
}