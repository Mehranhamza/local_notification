import 'package:get/get.dart';
import 'package:todo_local/services/notifcation_helper.dart';
import '../services/db_helper.dart';

class ReminderController extends GetxController {
  Rx<DateTime>? reminderTime = DateTime.now().obs;
  var reminders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReminders();
  }

  Future<void> fetchReminders() async {
    reminders.value = await DbHelper.getReminder();
  }

  Future<void> addReminder(Map<String, dynamic> reminder) async {
    final reminderID = await DbHelper.insertReminder(reminder);
    await NotificationHelper.scheduledNotifications(
      reminderID,
      reminder['title'],
      reminder['category'],
      DateTime.parse(reminder['reminderTime']),
    );
    fetchReminders(); // Refresh reminders
  }

  Future<void> deleteReminder(int id) async {
    await DbHelper.deleteReminder(id);
    // await NotificationHelper.cancelNotification(id);
    fetchReminders();
  }
}
