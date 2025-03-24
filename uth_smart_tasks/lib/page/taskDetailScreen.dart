import 'package:flutter/material.dart';
import 'Models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              task.description,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem(Icons.grid_view, "Category", "Work"),
                  _buildInfoItem(Icons.checklist_rtl, "Status", "In Progress"),
                  _buildInfoItem(Icons.verified, "Priority", "High"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Subtasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildSubtask(
              "This task is related to Fitness. It needs to be completed",
            ),
            _buildSubtask(
              "This task is related to Fitness. It needs to be completed",
            ),
            _buildSubtask(
              "This task is related to Fitness. It needs to be completed",
            ),
            SizedBox(height: 20),
            Text(
              "Attachments",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildAttachment("document_1_0.pdf"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.black, size: 20),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14)),
                Text(
                  value,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubtask(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (value) {}),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildAttachment(String filename) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.attachment, color: Colors.black54),
          SizedBox(width: 5),
          Text(filename, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
