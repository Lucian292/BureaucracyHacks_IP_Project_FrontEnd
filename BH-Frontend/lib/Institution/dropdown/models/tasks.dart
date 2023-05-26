class Tasks {
  final int task_id;
  final String name;
  final String description;
  final String phoneNumber;
  final String estimated_time;

  Tasks({
    required this.task_id,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.estimated_time,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      task_id: json['task_id'] ?? 0,
      name: json['name'] ?? '0',
      description: json['description'] ?? '0',
      phoneNumber: json['phoneNumber'] ?? '0',
      estimated_time: json['estimated_time'] ?? '0',
    );
  }
}
