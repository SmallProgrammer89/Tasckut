import 'package:flutter/material.dart';
import 'package:flutter_note_application/data/Task.dart';
import 'package:hive_flutter/hive_flutter.dart';

  var taskbox = Hive.box<Task>('Taskbox');
  int getNotDoneTask() {
    List<Task> DoneTasks = [];
    DoneTasks = taskbox.values.where((element) {
      return element.isDone == false;
    }).toList();
    return DoneTasks.length;
  }