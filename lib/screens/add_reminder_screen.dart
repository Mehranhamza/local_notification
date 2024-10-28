import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/reminder_controller.dart';
import 'package:intl/intl.dart';

class AddReminderScreen extends StatelessWidget {
  final ReminderController reminderController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'General';

  final TextEditingController timeController = TextEditingController();
  DateTime? selectedDateTime;
  Future<void> selectTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Pick a time after selecting the date
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Combine the date and time into a single DateTime object
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        String iso8601String = selectedDateTime!.toIso8601String();
        timeController.text = iso8601String;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Responsive padding
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10.h), // Responsive height
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10.h), // Responsive height
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: 'Reminder Time (YYYY-MM-DDTHH:MM:SS)',
              ),
              readOnly: true,
              onTap: () => selectTime(context),
            ),
            SizedBox(height: 10.h), // Responsive height
            DropdownButton<String>(
              value: selectedCategory,
              items: <String>['General', 'Work', 'Personal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedCategory = newValue!;
              },
            ),
            SizedBox(height: 20.h), // Responsive height
            ElevatedButton(
              onPressed: () {
                final reminder = {
                  'title': titleController.text,
                  'description': descriptionController.text,
                  'reminderTime': timeController.text,
                  'category': selectedCategory,
                  'isActive': 1
                };
                reminderController.addReminder(reminder);
                Get.back();
              },
              child: Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
