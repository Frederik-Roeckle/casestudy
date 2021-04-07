import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_casestudy/models/userr.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

// collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

// Wann ist <void> notwendig?
  Future updateUserData(
      String name, String email, String phone, String doctor) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'doctor': doctor,
    });
  }

// brew list from snapshot

  List<Userr> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Userr(
          //  name: doc.data()['name'] ?? '',
          //  email: doc.data()['strength'] ?? '',
          //  phone: doc.data()['sugars'] ?? 0,
          //  doctor: doc.data()['sugars'] ?? 0,
          );
    }).toList();
  }

// userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phone: snapshot.data()['phone'],
      doctor: snapshot.data()['doctor'],
    );
  }

// Get brews Stream
  Stream<List<Userr>> get brews {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

//  get user doc tream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
