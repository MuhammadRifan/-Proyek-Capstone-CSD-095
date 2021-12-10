import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageService {
  StorageService({
    required this.firebaseStorage,
  });

  final FirebaseStorage firebaseStorage;

  Future uploadImage(File image) async {
    String filename = basename(image.path);

    Reference ref = firebaseStorage.ref('image_user/$filename');

    try {
      await ref.putFile(image);
      
      return ref.getDownloadURL();
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
