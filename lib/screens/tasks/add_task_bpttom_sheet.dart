import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../firebase/firebase_functions.dart';
import '../../models/task_model.dart';
import '../../provider/my_provider.dart';
import '../../shared/styles/colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var describtionController = TextEditingController();

  var selectedDate = DateTime.now();
  var formKy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      color: pro.modeApp == ThemeMode.light ? Colors.white : Color(0xFF141922),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKy,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.addNewTask,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterTaskTitle;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text(
                      AppLocalizations.of(context)!.taskTitle,
                      style: TextStyle(
                          color: Colors.grey[700], fontWeight: FontWeight.bold),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: describtionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!
                        .pleaseEnterTaskDescribtion;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.taskDescribtion,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor))),
              ),
              SizedBox(
                height: 10,
              ),
              Text(AppLocalizations.of(context)!.selectDate,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: pro.modeApp == ThemeMode.light
                          ? Colors.grey[700]
                          : Colors.white.withOpacity(0.7))),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  selectDate(context);
                },
                child: Text(selectedDate.toString().substring(0, 10),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: pro.modeApp == ThemeMode.light
                            ? primaryColor
                            : Colors.white)),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKy.currentState!.validate()) {
                      print(DateUtils.dateOnly(selectedDate).toString());
                      TaskModel taskModel = TaskModel(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          title: titleController.text,
                          Description: describtionController.text,
                          date: DateUtils.dateOnly(selectedDate)
                              .millisecondsSinceEpoch);
                      FirebaseFunctions.addTask(taskModel);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.addTask))
            ],
          ),
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    setState(() {});
  }
}
