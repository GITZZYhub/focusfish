import 'dart:io';

import 'package:my_logger/my_logger.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermission {
  static Future<bool> request() async {
    var isStorageGranted = true;
    var isCameraGranted = true;
    var isPhotosGranted = true;

    if (Platform.isAndroid) {
      final statuses = await [
        Permission.storage,
        Permission.camera,
      ].request();
      if (statuses[Permission.storage]!.isGranted) {
        logPermissionsInfo(info: '已获取存储权限', needStack: false);
        isStorageGranted = true;
      } else {
        logPermissionsInfo(info: '获取存储权限被拒绝', needStack: false);
        isStorageGranted = false;
      }
      if (statuses[Permission.camera]!.isGranted) {
        logPermissionsInfo(info: '已获取相机权限', needStack: false);
        isCameraGranted = true;
      } else {
        logPermissionsInfo(info: '获取相机权限被拒绝', needStack: false);
        isCameraGranted = false;
      }
    } else {
      final statuses = await [
        Permission.photos,
        Permission.camera,
      ].request();
      if (statuses[Permission.photos]!.isGranted) {
        logPermissionsInfo(info: '已获取相册权限', needStack: false);
        isPhotosGranted = true;
      } else {
        logPermissionsInfo(info: '获取相册权限被拒绝', needStack: false);
        isPhotosGranted = false;
      }
      if (statuses[Permission.camera]!.isGranted) {
        logPermissionsInfo(info: '已获取相机权限', needStack: false);
        isCameraGranted = true;
      } else {
        logPermissionsInfo(info: '获取相机权限被拒绝', needStack: false);
        isCameraGranted = false;
      }
    }
    return isStorageGranted && isPhotosGranted && isCameraGranted;
  }
}
