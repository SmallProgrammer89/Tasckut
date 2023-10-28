import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_note_application/constanse/Constanse.dart';
import 'package:flutter_note_application/data/Task.dart';
import 'package:flutter_note_application/utility/valNotifier.dart';
import 'package:flutter_note_application/widget/dismisible_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../data/not_done_task.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  var taskbox = Hive.box<Task>('Taskbox');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 24),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        height: 56,
                        width: 56,
                        decoration: ShapeDecoration(
                          color: green,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Image.asset('images/icon_calendar.png'),
                      ),
                      SizedBox(width: 10),
                      ValueListenableBuilder(
                        valueListenable: CustomValNotifier.updateValNotifier,
                        builder: (context, value, child) {
                          return CircularPercentIndicator(
                            radius: 27.0,
                            lineWidth: 6,
                            percent: taskbox.values.length == 0
                                ? 0
                                : _getDoneTaskLength(),
                            center: new Text(
                              taskbox.values.length == 0
                                  ? 0.toString()
                                  : (_getDoneTaskLength() * 100)
                                          .toInt()
                                          .toString() +
                                      '%',
                            ),
                            backgroundColor: Color(0xffE2F6F1),
                            progressColor: green,
                          );
                        },
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'دو شهریور',
                            style: TextStyle(fontSize: 24),
                          ),
                          Row(
                            children: [
                              Text(
                                'تسک در امروز مانده است ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable:
                                    CustomValNotifier.updateValNotifier,
                                builder: (context, value, child) {
                                  return Text(
                                    '${getNotDoneTask()}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 24),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FlutterDatePickerTimeline(
                startDate: DateTime(2022, 8, 24),
                endDate: DateTime(2022, 9, 23),
                initialSelectedDate: DateTime(2022, 8, 24),
                onSelectedDateChange: (date) {
                  //right filter task here
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            ValueListenableBuilder(
              valueListenable: CustomValNotifier.updateValNotifier,
              builder: (context, value, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var task = taskbox.values.toList()[index];

                      return task.isDone == false
                          ? DismisibleWidget(
                              task: task,
                              context: context,
                            )
                          : Container();
                    },
                    childCount: taskbox.values.length,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 32,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: -12,
                          blurRadius: 10,
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Image.asset('images/icon_downward.png'),
                      Expanded(
                          child: Text(
                        'تسک های انجام شده',
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: CustomValNotifier.updateValNotifier,
              builder: (context, value, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var task = taskbox.values.toList()[index];

                      return task.isDone == true
                          ? AnimatedContainer(
                              duration: Duration(seconds: 1),
                              child: DismisibleWidget(
                                task: task,
                                context: context,
                              ),
                            )
                          : Container();
                    },
                    childCount: taskbox.values.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  double _getDoneTaskLength() {
    List<Task> DoneTasks = [];
    DoneTasks = taskbox.values.where((element) {
      return element.isDone == true;
    }).toList();
    return DoneTasks.length.toDouble() / taskbox.values.length.toDouble();
  }
}
