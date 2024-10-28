import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  // Function to request notification permission
  static Future<bool> requestNotificationPermissions() async {
    // Check the current status of the notification permission
    var status = await Permission.notification.status;

    // If the permission is already granted, return true
    if (status.isGranted) {
      return true;
    }

    // Request the permission
    if (await Permission.notification.request().isGranted) {
      return true; // Permission granted
    }

    // If the permission is denied or permanently denied, return false
    return false;
  }
}
