class UnplanedTaskModel {
  final String id;
  final String title;
  final String description;
  bool isComplete;

  UnplanedTaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isComplete = false,
  });

  factory UnplanedTaskModel.fromJson(Map json) {
    return UnplanedTaskModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      isComplete: json["isComplete"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isComplete": isComplete,
      };
}
