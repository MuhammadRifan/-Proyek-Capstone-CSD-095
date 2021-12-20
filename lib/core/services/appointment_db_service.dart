import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'storage_service.dart';

class AppointmentDatabaseService {
  AppointmentDatabaseService({
    required this.userCollection,
  });

  final CollectionReference userCollection;

  // UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserModel(
  //     uid: snapshot.id,
  //     name: snapshot.data()!['nama'],
  //     phone: snapshot.data()['phone'],
  //     picture: snapshot.data()['picture'],
  //     address: snapshot.data()['address'],
  //     strv: snapshot.data()['strv'],
  //     level: snapshot.data()['level'],
  //   );
  // }

  Future updateUserData({
    required String uid,
    required String id_klinik,
    required String tanggal,
    required String jam ,
    required String note,
    required String status,
    required double rating,
  }) async {


    return await userCollection.doc(uid).set({
      'uid': uid,
      'id_klinik' : id_klinik,
      'date': tanggal,
      'jam' : jam,
      'note' : note,
      'status' : status,
      'rating': rating,

    });
  }

  Future<DocumentSnapshot> checkUserData(String uId) async {
    return await userCollection.doc(uId).get();
    // try {
    // } on FirebaseException catch (e) {
    //   return e.message;
    // }
  }

  Future<DocumentSnapshot> cekUserData(String uid) {
    return userCollection.doc(uid).get();
  }
}
