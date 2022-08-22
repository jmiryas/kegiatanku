class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  bool isComplete;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.isComplete = false,
  });

  factory TaskModel.fromJson(Map json) {
    return TaskModel(
      id: json["id"] as String,
      title: json["title"] as String,
      description: json["description"] as String,
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
      isComplete: json["isComplete"] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "startTime": startTime.toString(),
        "endTime": endTime.toString(),
        "isComplete": isComplete,
      };
}
