import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/tasks/task_item.dart';

import '../../firebase/firebase_functions.dart';
import '../../models/task_model.dart';
import '../../provider/my_provider.dart';
import '../../shared/styles/colors.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            setState(() {
              selectedDate = date;
            });
          },
          leftMargin: 20,
          monthColor:
              pro.modeApp == ThemeMode.light ? primaryColor : Colors.white,
          dayColor: pro.modeApp == ThemeMode.light
              ? primaryColor.withOpacity(.70)
              : Colors.white,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Color(0xFF5D9CEC),
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
            if (tasks.isEmpty) {
              return Center(
                child: Text("No Tasks"),
              );
            }
            return Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(task: tasks[index]);
                  },
                  itemCount: tasks.length),
            );
          },
        )
      ],
    );
  }
}
