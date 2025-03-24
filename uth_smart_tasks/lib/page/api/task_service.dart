import 'dart:convert';
import 'package:dio/dio.dart';
import '../Models/task_model.dart';

class TaskService {
  final Dio _dio = Dio();
  final String baseUrl = "https://amock.io/api/researchUTH";

  // Lấy danh sách tất cả các task
  Future<List<Task>> fetchTasks() async {
    try {
      final response = await _dio.get("$baseUrl/tasks");

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData['isSuccess'] == true && jsonData['data'] is List) {
          return (jsonData['data'] as List)
              .map((task) => Task.fromJson(task))
              .toList();
        } else {
          throw Exception("No task data available");
        }
      } else {
        throw Exception("Failed to load tasks: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching tasks: $e");
    }
  }

  // Lấy chi tiết một task theo ID
  Future<Task> fetchTaskDetail(int taskId) async {
    try {
      final response = await _dio.get("$baseUrl/task/$taskId");

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData['isSuccess'] == true && jsonData['data'] != null) {
          return Task.fromJson(jsonData['data']);
        } else {
          throw Exception("No task detail available");
        }
      } else {
        throw Exception("Failed to load task detail: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching task detail: $e");
    }
  }

  // Xóa một task
  Future<void> deleteTask(int taskId) async {
    try {
      final response = await _dio.delete("$baseUrl/task/$taskId");

      if (response.statusCode == 200) {
        print("Task deleted successfully");
      } else {
        throw Exception("Failed to delete task: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error deleting task: $e");
    }
  }
}
