import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/unplaned_task_model.dart';

class UnplanedTaskProvider extends ChangeNotifier {
  List<UnplanedTaskModel> _unplanedTasks = [];

  List<UnplanedTaskModel> get unplanedTasks => _unplanedTasks;

  UnplanedTaskProvider() {
    initialState();
  }

  void initialState() async {
    await syncDataWithProvider();
  }

  Future<void> addUnplanedTask(UnplanedTaskModel unplanedTask) async {
    _unplanedTasks.add(unplanedTask);

    await updateSharedPrefrences();

    notifyListeners();
  }

  Future<void> removeUnplanedTask(UnplanedTaskModel unplanedTask) async {
    _unplanedTasks.removeWhere((task) => task.id == unplanedTask.id);

    await updateSharedPrefrences();

    notifyListeners();
  }

  // Update Shared Preferences

  Future<void> updateSharedPrefrences() async {
    List<String> encodedUnplanedTasks = _unplanedTasks.map((task) {
      return json.encode(task.toJson());
    }).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("unplaned_tasks", encodedUnplanedTasks);
  }

  // Sync

  Future<void> syncDataWithProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final decodedUnplanedTasks =
        json.decode(prefs.getStringList("unplaned_tasks").toString());

    List<UnplanedTaskModel> currentUnplanedTasks = [];

    decodedUnplanedTasks.forEach((task) {
      currentUnplanedTasks.add(UnplanedTaskModel.fromJson(task));
    });

    _unplanedTasks = currentUnplanedTasks;

    notifyListeners();
  }
}
