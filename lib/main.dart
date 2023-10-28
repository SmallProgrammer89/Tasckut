import 'package:flutter/material.dart';
import 'package:flutter_note_application/constanse/Constanse.dart';
import 'package:flutter_note_application/screens/Add_Task_Screen.dart';
import 'package:flutter_note_application/data/Task.dart';
import 'package:flutter_note_application/data/Task_type.dart';
import 'package:flutter_note_application/data/Type_enum.dart';
import 'package:flutter_note_application/screens/calender_screen.dart';
import 'package:flutter_note_application/screens/homescreen.dart';
import 'package:flutter_note_application/screens/time_screen.dart';
import 'package:flutter_note_application/utility/valNotifier.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('names');
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('TaskBox');
  runApp(NoteApp());
}

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  int _SelecetedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/addscreen': (BuildContext context) => AddTaskScreen(),
      },
      theme: ThemeData(fontFamily: 'SM'),
      home: Scaffold(
        backgroundColor: darkwhite,
        body: IndexedStack(
          children: getScreen,
          index: _SelecetedIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _SelecetedIndex,
          onTap: (Index) {
            setState(() {
              _SelecetedIndex = Index;
            });
          },
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                child: Image.asset('images/icon_setting.png'),
                height: 25,
                width: 25,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                child: Image.asset('images/icon_clock_not_selected.png'),
                height: 25,
                width: 25,
              ),
              activeIcon: SizedBox(
                child: Image.asset('images/icon_clock_selected.png'),
                height: 25,
                width: 25,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                child: Image.asset('images/icon_calendar_not_selected.png'),
                height: 25,
                width: 25,
              ),
              activeIcon: SizedBox(
                child: Image.asset('images/icon_calendar_selected.png'),
                height: 25,
                width: 25,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                child: Image.asset('images/icon_home_not_selected.png'),
                height: 25,
                width: 25,
              ),
              activeIcon: SizedBox(
                child: Image.asset('images/icon_home_selected.png'),
                height: 25,
                width: 25,
              ),
              label: '',
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getScreen = [
    HomeScreen(),
    TimeScreen(),
    ValueListenableBuilder(
      valueListenable: CustomValNotifier.updateValNotifier,
      builder: (context, value, child) {
        return CalenderScreen();
      },
    ),
    ValueListenableBuilder(
      valueListenable: CustomValNotifier.updateValNotifier,
      builder: (context, value, child) {
        return HomeScreen();
      },
    ),
  ];
}
