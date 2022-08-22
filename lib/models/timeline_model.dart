import '../models/task_model.dart';

class TimelineModel {
  final String id;
  final List<TaskModel> timelines;

  TimelineModel({
    required this.id,
    required this.timelines,
  });

  factory TimelineModel.fromJson(Map json) {
    return TimelineModel(
      id: json["id"],
      timelines: json["timelines"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "timelines": timelines.map((item) => item.toJson()),
      };
}
