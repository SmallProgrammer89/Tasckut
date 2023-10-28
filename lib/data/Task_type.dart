import 'dart:async';

import 'package:hive/hive.dart';
part 'Task_type.g.dart';

@HiveType(typeId: 2)
class TaskType {
  TaskType({
    required this.TaskTypeEnum,
    required this.image,
    required this.title,
  });
  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  Enum TaskTypeEnum;
}
