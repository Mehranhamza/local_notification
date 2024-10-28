import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_local/screens/reminder_screen.dart';
import 'package:todo_local/services/notifcation_helper.dart';
import 'package:todo_local/services/permission_handler.dart';
import 'services/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await DbHelper.initDB();
  await NotificationHelper.initializeNotifications();
  await PermissionHelper.requestNotificationPermissions();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reminder App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: RemindersScreen(),
        );
      },
    );
  }
}
