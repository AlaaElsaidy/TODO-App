import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/tasks/update_task.dart';

import '../../firebase/firebase_functions.dart';
import '../../models/task_model.dart';
import '../../provider/my_provider.dart';
import '../../shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Card(
        color:
            pro.modeApp == ThemeMode.light ? Colors.white : Color(0xFF141922),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Slidable(
          startActionPane: ActionPane(motion: DrawerMotion(), children: [
            SlidableAction(
                onPressed: (context) {
                  FirebaseFunctions.deleteTasks(task.id);
                },
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                label: "Delete",
                icon: Icons.delete,
                backgroundColor: Colors.red),
            SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateTask(taskModel: task),
                      ));
                },
                label: "Edit",
                icon: Icons.edit,
                backgroundColor: Colors.blue),
          ]),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 3,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(18)),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task.title}",
                      style: TextStyle(
                        color: pro.modeApp == ThemeMode.light
                            ? primaryColor
                            : Colors.white,
                      ),
                    ),
                    Text(
                      "${task.Description}",
                      style: TextStyle(
                        color: pro.modeApp == ThemeMode.light
                            ? primaryColor
                            : Colors.white,
                      ),
                    )
                  ],
                ),
                Spacer(),
                task.isDone
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Done!",
                          style: TextStyle(color: Colors.white),
                        ))
                    : InkWell(
                        onTap: () {
                          task.isDone = true;
                          FirebaseFunctions.updateTask(task);
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                color: pro.modeApp == ThemeMode.light
                                    ? primaryColor
                                    : Color(0xFF5D9CEC),
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
