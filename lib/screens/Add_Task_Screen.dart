import 'package:flutter/material.dart';
import 'package:flutter_note_application/Constanse/Constanse.dart';
import 'package:flutter_note_application/data/Task.dart';
import 'package:flutter_note_application/widget/Task_type_item.dart';
import 'package:flutter_note_application/utility/utility.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  final TextEditingController ControllerTaskTitle = TextEditingController();
  final TextEditingController ControllerTaskSubTitle = TextEditingController();
  final box = Hive.box<Task>('Taskbox');
  DateTime? _time;
  final now = DateTime.now();

  int _SelectedTaskTypeItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });
    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 12.5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: ControllerTaskTitle,
                      focusNode: negahban1,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        labelText: 'عنوان تسک',
                        labelStyle: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 20,
                          color: negahban1.hasFocus ? green : melogrey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: melogrey, width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: ControllerTaskSubTitle,
                      maxLines: 2,
                      focusNode: negahban2,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        labelText: 'توضیحات تسک',
                        labelStyle: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 20,
                          color: negahban2.hasFocus ? green : melogrey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: melogrey, width: 3.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 3,
                            color: green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomHourPicker(
                    title: 'زمان تسک رو انتخاب کن',
                    negativeButtonText: 'حذف کن',
                    positiveButtonText: 'انتخاب زمان',
                    elevation: 2,
                    titleStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    negativeButtonStyle: TextStyle(
                        color: Color.fromARGB(255, 218, 66, 24),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    positiveButtonStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    onPositivePressed: (context, time) {
                      _time = time;
                    },
                    onNegativePressed: (context) {},
                  ),
                ),
                Container(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _SelectedTaskTypeItem = index;
                          });
                        },
                        child: TaskTypeItemList(
                          taskType: getTaskTypeList()[index],
                          index: index,
                          selectedItemList: _SelectedTaskTypeItem,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: ElevatedButton(
                    onPressed: () {
                      String Tasktitle = ControllerTaskTitle.text;
                      String Tasksubtitle = ControllerTaskSubTitle.text;
                      addTask(Tasktitle, Tasksubtitle);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'اضافه کردن تسک',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: green,
                      minimumSize: Size(250, 60),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTask(String Tasktitle, String Tasksubtitle) {
    var task = Task(
        Title: Tasktitle,
        SubTitle: Tasksubtitle,
        time: _time!,
        taskType: getTaskTypeList()[_SelectedTaskTypeItem]);

    box.add(task);
  }
}
