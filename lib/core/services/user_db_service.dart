import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'storage_service.dart';

class UserDatabaseService {
  UserDatabaseService({
    required this.userCollection,
  });

  final CollectionReference userCollection;
  final StorageService storageService = StorageService(
    firebaseStorage: FirebaseStorage.instance,
  );

  Future setUserData({
    required String uid,
    required String name,
    required String phone,
    required File picture,
    required String address,
    required String? strv,
    required int jenis,
  }) async {
    String url = await storageService.uploadImageUser(picture);

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

  Future updateUserData({
    required String uid,
    required String name,
    required String phone,
    required String address,
    required String? strv,
    required String oldPicture,
    File? picture,
  }) async {
    if (picture != null) {
      String url = await storageService.uploadImageUser(picture);

      await storageService.deleteImage(oldPicture);

      return await userCollection.doc(uid).update({
        'uid': uid,
        'name': name,
        'phone': phone,
        'picture': url,
        'address': address,
        'strv': strv,
      });
    } else {
      return await userCollection.doc(uid).update({
        'uid': uid,
        'name': name,
        'phone': phone,
        'address': address,
        'strv': strv,
      });
    }
  }

  Future<DocumentSnapshot> checkUserData(String uId) async {
    return await userCollection.doc(uId).get();
  }

  Future<QuerySnapshot> dataDoctor() async {
    return await userCollection.where('jenis', isEqualTo: 1).get();
  }

  // Stream<UserModel?> streamUserData() {
  //   var user = AuthService(auth: FirebaseAuth.instance);
  //   var uid = user.userData!.uid;

  //   return userCollection.doc(uid).snapshots().map(
  //         (data) => UserModel(
  //           uid: uid,
  //           name: data['name'],
  //           phone: data['phone'],
  //           picture: data['picture'],
  //           address: data['address'],
  //           strv: data['strv'],
  //           jenis: data['jenis'],
  //         ),
  //       );
  // log(UserModel(data));

  // return userCollection.doc(uid).snapshots();
  // }
}
