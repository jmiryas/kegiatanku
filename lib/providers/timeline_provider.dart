import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';
import '../models/timeline_model.dart';

class TimelineProvider extends ChangeNotifier {
  List<TimelineModel> _timelines = [];

  List<TimelineModel> get timelines => _timelines;

  TimelineProvider() {
    initialState();
  }

  void initialState() async {
    await syncDataWithProvider();
  }

  // Mendapatkan index timeline untuk hari ini

  int getCurrentTimelineIndex() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String dateTimeNow = dateFormat.format(DateTime.now());

    int timelineIndex =
        _timelines.indexWhere((element) => element.id == dateTimeNow);

    return timelineIndex;
  }

  // Mengembalikan timeline hari ini

  TimelineModel getCurrentTimeline() {
    int timelineIndex = getCurrentTimelineIndex();

    return _timelines[timelineIndex];
  }

  // Return true jika timeline hari ini sudah ada
  // Return false jika timeline hari ini tidak ada

  bool isCurrentTimelineExist() {
    int timelineIndex = getCurrentTimelineIndex();

    return timelineIndex >= 0;
  }

  // Menambahkan sebuah timeline baru ke dalam _timelines

  Future<void> addTimeline(TaskModel task) async {
    // Tanggal hari ini

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String dateTimeNow = dateFormat.format(DateTime.now());

    // Apakah tanggal hari ini sudah ada di dalam _timelines atau tidak
    // -1 artinya tidak ada
    // 0 atau lebih artinya ada

    int timelineIndex = getCurrentTimelineIndex();

    // Jika lebih dari sama dengan 0,
    // tambahkan ke dalam timelines yang sudah ada
    // Selain itu, buat timeline baru

    if (timelineIndex >= 0) {
      _timelines[timelineIndex].timelines.add(task);
    } else {
      _timelines.add(
        TimelineModel(
          id: dateTimeNow,
          timelines: [
            task,
          ],
        ),
      );
    }

    await updateSharedPrefrences();

    notifyListeners();
  }

  // Menghapus sebuah timeline dari _timelines

  Future<void> removeTimelineById(String timelineId) async {
    _timelines.removeWhere((element) => element.id == timelineId);

    await updateSharedPrefrences();

    notifyListeners();
  }

  // Menghapus sebuah task dari timeline

  Future<void> removeTaskFromTimelineById(
      String timelineId, String taskId) async {
    final selectedTimeline =
        timelines.firstWhere((timeline) => timeline.id == timelineId);

    final taskIndex =
        selectedTimeline.timelines.indexWhere((task) => task.id == taskId);

    selectedTimeline.timelines.removeAt(taskIndex);

    await updateSharedPrefrences();

    notifyListeners();
  }

  // Toggle status complete pada task.

  Future<void> toggleCompleteStatus(String timelineId, String taskId) async {
    final selectedTimeline =
        timelines.firstWhere((timeline) => timeline.id == timelineId);

    final taskIndex =
        selectedTimeline.timelines.indexWhere((task) => task.id == taskId);

    TaskModel currentTask = selectedTimeline.timelines[taskIndex];

    selectedTimeline.timelines[taskIndex] = TaskModel(
      id: currentTask.id,
      title: currentTask.title,
      description: currentTask.description,
      startTime: currentTask.startTime,
      endTime: currentTask.endTime,
      isComplete: !currentTask.isComplete,
    );

    await updateSharedPrefrences();

    notifyListeners();
  }

  // Fungsi untuk mengubah _timelines menjadi string
  // agar bisa disimpan di dalam shared preferences

  Future<void> updateSharedPrefrences() async {
    List<Map<String, dynamic>> currentTimeline = [];

    for (var element in _timelines) {
      List<String> tasks = [];

      for (var task in element.timelines) {
        tasks.add(json.encode(task.toJson()));
      }

      Map<String, dynamic> currentTasks = {
        "id": element.id,
        "timelines": tasks,
      };

      currentTimeline.add(currentTasks);
    }

    String currentTimelineString = json.encode(currentTimeline).toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("timelines", [currentTimelineString]);
  }

  // Mengubah string di dalam shared preferences
  // menjadi List<TimelineModel>

  Future<void> syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var timelineStringResult =
        json.decode(prefs.getStringList("timelines").toString());

    List<TimelineModel> currentTimelines = [];

    timelineStringResult.forEach((item) {
      item.forEach((element) {
        List<TaskModel> currentTasks = [];

        element["timelines"].forEach((task) {
          final taskJson = json.decode(task);

          currentTasks.add(TaskModel.fromJson(taskJson));
        });

        currentTimelines.add(TimelineModel(
            id: element["id"] as String, timelines: currentTasks));
      });
    });

    _timelines = currentTimelines;

    notifyListeners();
  }
}
