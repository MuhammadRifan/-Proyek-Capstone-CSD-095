import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'storage_service.dart';

class UserDatabaseService {
  UserDatabaseService({
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
    required String name,
    required String phone,
    required File picture,
    required String address,
    required String strv,
    required int jenis,
  }) async {
    String url = await StorageService(
      firebaseStorage: FirebaseStorage.instance,
    ).uploadImage(picture);

    return await userCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'phone': phone,
      'picture': url,
      'address': address,
      'strv': strv,
      'jenis': jenis,
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
