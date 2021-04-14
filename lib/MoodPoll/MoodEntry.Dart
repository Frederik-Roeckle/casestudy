
class MoodEntry {

  // Primary Key in ISO 8601 Format
  final String dateTime;

  //Mood auf -50 - +50 in 20er Schritten
  final double moodInPoints;

  //Schmerzen vorhanden, eig bool aber not supported by sqlite instead 0 = false, 1 = true
  final int schmerzen;

  //Scherzbeschreibung
  final String schmerzBeschreibung;

  //Psychologische Verfassung
  final String psychologischeVerfassung;

  //MoodEntry ({this.dateTime, this.mood});
  MoodEntry ({this.dateTime, this.moodInPoints, this.schmerzen, this.schmerzBeschreibung, this.psychologischeVerfassung});

  Map<String, dynamic> toMap() {
    return {
      "DateTime": this.dateTime,
      "MoodInPoints": this.moodInPoints,
      "Schmerzen": this.schmerzen,
      "Schmerzbeschreibung": this.schmerzBeschreibung,
      "PsychologischeVerfassung": this.psychologischeVerfassung,
    };
  }
}