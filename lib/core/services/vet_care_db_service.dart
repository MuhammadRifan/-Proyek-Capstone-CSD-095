import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'storage_service.dart';

class VetCareDatabaseService {
  VetCareDatabaseService({
    required this.vetCareCollection,
  });

  final CollectionReference vetCareCollection;
  final StorageService storageService = StorageService(
    firebaseStorage: FirebaseStorage.instance,
  );

  Future addVetCare({
    required String uidDoctor,
    required String name,
    required String desc,
    required String address,
    required String city,
    required String phone,
    required String openHour,
    required String closeHour,
    required List<String> workDay,
    required File picture,
  }) async {
    String url = await storageService.uploadImageVetCare(picture);

    return await vetCareCollection.add({
      'uidDoctor': uidDoctor,
      'name': name,
      'description': desc,
      'address': address,
      'city': city,
      'phone': phone,
      'openHour': openHour,
      'closeHour': closeHour,
      'workDay': workDay,
      'picture': url,
    });
  }

  Future updateVetCare({
    required String uid,
    required String name,
    required String desc,
    required String address,
    required String city,
    required String phone,
    required String openHour,
    required String closeHour,
    required List<String> workDay,
    required String oldPicture,
    File? picture,
  }) async {
    if (picture != null) {
      String url = await storageService.uploadImageVetCare(picture);

      await storageService.deleteImage(oldPicture);

      return await vetCareCollection.doc(uid).update({
        'name': name,
        'description': desc,
        'address': address,
        'city': city,
        'phone': phone,
        'openHour': openHour,
        'closeHour': closeHour,
        'workDay': workDay,
        'picture': url,
      });
    } else {
      return await vetCareCollection.doc(uid).update({
        'name': name,
        'description': desc,
        'address': address,
        'city': city,
        'phone': phone,
        'openHour': openHour,
        'closeHour': closeHour,
        'workDay': workDay,
      });
    }
  }

  Future<QuerySnapshot> dataMyVetCare(String uid) async {
    return await vetCareCollection.where('uidDoctor', isEqualTo: uid).get();
  }

  Future<QuerySnapshot> dataVetCare() async {
    return await vetCareCollection.get();
  }

  Future<DocumentSnapshot> dataVetCareDetail(String uId) async {
    return await vetCareCollection.doc(uId).get();
  }
}
