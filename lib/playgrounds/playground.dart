// import 'dart:convert';

// class TimelineModel {
//   final String id;
//   final List<TaskModel> timelines;

//   TimelineModel({
//     required this.id,
//     required this.timelines,
//   });

//   factory TimelineModel.fromJson(Map json) {
//     return TimelineModel(
//       id: json["id"],
//       timelines: json["timelines"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "timelines": timelines,
//       };
// }

// class TaskModel {
//   final String id;
//   final String title;
//   final String description;
//   final String startTime;
//   final String endTime;
//   bool isComplete = false;

//   TaskModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.startTime,
//     required this.endTime,
//     required this.isComplete,
//   });

//   factory TaskModel.fromJson(Map json) {
//     return TaskModel(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//       startTime: json["startTime"],
//       endTime: json["endTime"],
//       isComplete: json["isComplete"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "startTime": startTime,
//         "endTime": endTime,
//         "isComplete": isComplete,
//       };
// }

// void main() {
//   List<TimelineModel> timelines = [
//     TimelineModel(id: "2022-08-20", timelines: [
//       TaskModel(
//         id: "id-1",
//         title: "Task 1",
//         description: "Task 1",
//         startTime: DateTime.now().toString(),
//         endTime: DateTime.now().toString(),
//         isComplete: false,
//       ),
//       TaskModel(
//         id: "id-2",
//         title: "Task 2",
//         description: "Task 2",
//         startTime: DateTime.now().toString(),
//         endTime: DateTime.now().toString(),
//         isComplete: false,
//       ),
//     ]),
//     TimelineModel(id: "2022-08-21", timelines: [
//       TaskModel(
//         id: "id-3",
//         title: "Task 3",
//         description: "Task 3",
//         startTime: DateTime.now().toString(),
//         endTime: DateTime.now().toString(),
//         isComplete: false,
//       ),
//       TaskModel(
//         id: "id-4",
//         title: "Task 4",
//         description: "Task 4",
//         startTime: DateTime.now().toString(),
//         endTime: DateTime.now().toString(),
//         isComplete: false,
//       ),
//       TaskModel(
//         id: "id-5",
//         title: "Task 5",
//         description: "Task 5",
//         startTime: DateTime.now().toString(),
//         endTime: DateTime.now().toString(),
//         isComplete: false,
//       ),
//     ]),
//   ];

//   // Cara mengubah list of map menjadi string

//   // List<Map<String, dynamic>> currentTimeline = [];

//   // timelines.forEach((item) {
//   //   String currentTimelineId = item.id;

//   //   List<String> tasks = [];

//   //   item.timelines.forEach((task) {
//   //     tasks.add(json.encode(task.toJson()));

//   //     print(task.toJson());
//   //   });

//   //   Map<String, dynamic> currentTasks = {
//   //     "id": item.id,
//   //     "timelines": tasks,
//   //   };

//   //   currentTimeline.add(currentTasks);
//   // });

//   // print(json.encode(currentTimeline).toString());

//   // final selectedTimeline =
//   //     timelines.firstWhere((timeline) => timeline.id == "2022-08-21");

//   // final taskIndex =
//   //     selectedTimeline.timelines.indexWhere((task) => task.id == "id-5");

//   // TaskModel currentTask = selectedTimeline.timelines[taskIndex];

//   // selectedTimeline.timelines[taskIndex] = TaskModel(
//   //   id: currentTask.id,
//   //   title: currentTask.title,
//   //   description: currentTask.description,
//   //   startTime: currentTask.startTime,
//   //   endTime: currentTask.endTime,
//   //   isComplete: !currentTask.isComplete,
//   // );

//   // print(selectedTimeline.timelines[taskIndex].toJson());
// }
