import 'package:flutter/material.dart';
import 'package:flutter_note_application/constanse/Constanse.dart';
import 'package:flutter_note_application/data/Task.dart';
import 'package:flutter_note_application/data/Task_type.dart';
import 'package:flutter_note_application/data/Type_enum.dart';
import 'package:flutter_note_application/data/not_done_task.dart';
import 'package:flutter_note_application/widget/dismisible_widget.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key, required this.tasktype});
  TaskType tasktype;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: widget.tasktype.TaskTypeEnum == TaskTypeEnum.Study
            ? green
            : Color.fromARGB(255, 245, 193, 6),
        title: Text(
          widget.tasktype.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: widget.tasktype.TaskTypeEnum == TaskTypeEnum.Study
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    var task = taskbox.values.toList()[index];
                    return task.taskType.TaskTypeEnum == TaskTypeEnum.Working
                        ? DismisibleWidget(task: task, context: context)
                        : Container();
                  },
                  itemCount: taskbox.values.length,
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    var task = taskbox.values.toList()[index];
                    return task.taskType.TaskTypeEnum == TaskTypeEnum.Workout ||
                            task.taskType.TaskTypeEnum == TaskTypeEnum.Foucs
                        ? DismisibleWidget(task: task, context: context)
                        : Container();
                  },
                  itemCount: taskbox.values.length,
                )),
    );
  }

  Widget _getTask(Task task) {
    if (widget.tasktype.TaskTypeEnum == TaskTypeEnum.Study) {
      if (task.taskType == TaskTypeEnum.Working) {
        return DismisibleWidget(task: task, context: context);
      } else {
        return Container();
      }
    } else {
      if (task.taskType == TaskTypeEnum.Foucs) {
        return DismisibleWidget(task: task, context: context);
      } else {
        return Container();
      }
    }
  }
}
