class Task {
  final int id;
  final String title;
  final String description;
  final String status;
  final String time;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description",
      status: json['status'] ?? "Unknown",
      time: json['dueDate'] ?? "No Time",
    );
  }
}
