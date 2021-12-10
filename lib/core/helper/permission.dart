import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<PermissionStatus> getPhotosPermission() async {
    final permission = await Permission.photos.status;

    if (!permission.isGranted) {
      final permissionStatus = await [Permission.photos].request();
      return permissionStatus[Permission.photos] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }
}
