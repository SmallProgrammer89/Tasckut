import 'package:flutter/material.dart';
import 'package:flutter_note_application/data/Task_type.dart';
import 'package:hive/hive.dart';
import 'dart:typed_data';
part 'Task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task(
      {required this.Title,
      required this.SubTitle,
      this.isDone = false,
      required this.time,
      required this.taskType});

  @HiveField(0)
  String Title;

  @HiveField(1)
  String SubTitle;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  DateTime time;

  @HiveField(4)
  TaskType taskType;
}
