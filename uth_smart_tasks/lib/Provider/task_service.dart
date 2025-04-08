import 'package:dio/dio.dart';
import '../Models/task_model.dart';

class TaskService {
  final Dio _dio = Dio();
  final String baseUrl = "https://amock.io/api/researchUTH";

  Future<List<Task>> fetchTasks() async {
    final response = await _dio.get("$baseUrl/tasks");
    final List data = response.data['data'];
    return data.map((e) => Task.fromJson(e)).take(3).toList(); // Chỉ lấy 3 task
  }

  Future<Task> fetchTaskById(int id) async {
    final response = await _dio.get("$baseUrl/task/$id");
    return Task.fromJson(response.data['data']);
  }

  Future<void> deleteTask(int id) async {
    await _dio.delete("$baseUrl/task/$id");
  }
}
