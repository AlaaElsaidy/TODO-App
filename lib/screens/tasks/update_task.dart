import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../firebase/firebase_functions.dart';
import '../../models/task_model.dart';
import '../../provider/my_provider.dart';
import '../../shared/styles/colors.dart';

class UpdateTask extends StatefulWidget {
  final TaskModel taskModel;

  const UpdateTask({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  var titleController = TextEditingController();
  var describtionController = TextEditingController();
  late DateTime selectedDate;
  var formKy = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskModel.title;
    describtionController.text = widget.taskModel.Description;
    selectedDate = DateTime.fromMillisecondsSinceEpoch(widget.taskModel.date);
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor:
          pro.modeApp == ThemeMode.light ? mint : const Color(0xFF060E1E),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.toDoList,
          style: TextStyle(
              color: pro.modeApp == ThemeMode.light
                  ? primaryColor
                  : const Color(0xFF060E1E),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: primaryColor,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 250,
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              decoration: BoxDecoration(
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.white
                      : const Color(0xFF060E1E),
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.editTask,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: pro.modeApp == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterTaskTitle;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text(
                            AppLocalizations.of(context)!.taskTitle,
                            style: TextStyle(
                                color: pro.modeApp == ThemeMode.light
                                    ? Colors.grey[700]
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primaryColor))),
                    ),
                    const SizedBox(
                      height: 30,
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
                          label: Text(
                              AppLocalizations.of(context)!.taskDescribtion,
                              style: TextStyle(
                                  color: pro.modeApp == ThemeMode.light
                                      ? Colors.grey[700]
                                      : Colors.white,
                                  fontWeight: FontWeight.bold)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primaryColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primaryColor))),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      AppLocalizations.of(context)!.selectDate,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: pro.modeApp == ThemeMode.light
                              ? Colors.black
                              : Colors.white.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        selectDate(context);
                      },
                      child: Text(selectedDate.toString().substring(0, 10),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: pro.modeApp == ThemeMode.light
                                  ? primaryColor
                                  : Colors.white)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          loading();
                          //  print(DateUtils.dateOnly(selectedDate).toString());
                          TaskModel taskModel = TaskModel(
                              userId: widget.taskModel.id,
                              title: titleController.text,
                              Description: describtionController.text,
                              isDone: widget.taskModel.isDone,
                              date: DateUtils.dateOnly(selectedDate)
                                  .millisecondsSinceEpoch);
                          FirebaseFunctions.updateTask(taskModel);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.saveChanges))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loading() {
    showDialog(
      context: context,
      builder: (context) {
        return CircularProgressIndicator();
      },
    );
  }

  selectDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    setState(() {});
  }
}
