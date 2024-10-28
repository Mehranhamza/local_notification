import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/reminder_controller.dart';
import '../widgets/reminder_tile.dart';
import 'add_reminder_screen.dart';

class RemindersScreen extends StatelessWidget {
  final ReminderController reminderController = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => AddReminderScreen());
            },
          )
        ],
      ),
      body: Obx(() {
        if (reminderController.reminders.isEmpty) {
          return Center(child: Text('No Reminders'));
        }
        return ListView.builder(
          itemCount: reminderController.reminders.length,
          itemBuilder: (context, index) {
            return ReminderTile(
              reminder: reminderController.reminders[index],
              onDelete: () {
                reminderController
                    .deleteReminder(reminderController.reminders[index]['id']);
              },
            );
          },
        );
      }),
    );
  }
}
