import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

class CropImage {
  static Future<File> crop({required File image}) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressFormat: ImageCompressFormat.png,
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Image',
      ),
    );
    return Future.value(croppedFile);
  }
}
