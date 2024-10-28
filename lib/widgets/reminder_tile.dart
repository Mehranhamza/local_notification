import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReminderTile extends StatelessWidget {
  final Map<String, dynamic> reminder;
  final VoidCallback onDelete;

  ReminderTile({required this.reminder, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Title:\t\t\t\t\t\t\t\t\t\t\t${reminder['title']}",
          style: TextStyle(fontSize: 16.sp)), // Responsive text size
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description: \t\t${reminder['description']}',
              style: TextStyle(fontSize: 14.sp)),
          Text('Due: \t\t${reminder['reminderTime']}',
              style: TextStyle(fontSize: 14.sp)),
        ],
      ), // Responsive text size
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
