import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {
  StorageService({
    required this.firebaseStorage,
  });

  final FirebaseStorage firebaseStorage;

  Future uploadImageUser(File image) async {
    String filename = basename(image.path);

    Reference ref = firebaseStorage.ref('image_user/$filename');

    try {
      await ref.putFile(image);

      return ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future uploadImageVetCare(File image) async {
    String filename = basename(image.path);

    Reference ref = firebaseStorage.ref('image_vet_care/$filename');

    try {
      await ref.putFile(image);

      return ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future deleteImage(String url) async {
    var ref = firebaseStorage.refFromURL(url);

    try {
      await ref.delete();
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
