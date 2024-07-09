import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../provider/my_provider.dart';
import '../screens/login/login_screen.dart';
import '../screens/settings/settings_tab.dart';
import '../screens/tasks/add_task_bpttom_sheet.dart';
import '../screens/tasks/tasks_tab.dart';
import '../shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'layout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  List<Widget> tabs = [
    TasksTab(),
    SettingTab(),
  ];

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor:
          pro.modeApp == ThemeMode.light ? mint : Color(0xFF060E1E),
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance
                  .sendPasswordResetEmail(email: "haderkobak602@gmail.com");
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            },
            icon: Icon(Icons.send),
          )
        ],
        elevation: 0.0,
        title: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.todo,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.white
                      : Color(0xFF060E1E)),
            ),
            SizedBox(
              width: 3,
            ),
            Text("${pro.userModel?.name}"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSheet();
        },
        child: Icon(Icons.add),
        shape: CircleBorder(
            side: BorderSide(
                color: pro.modeApp == ThemeMode.light
                    ? Colors.white
                    : Color(0xFF141922),
                width: 3)),
      ),
      bottomNavigationBar: BottomAppBar(
        color:
            pro.modeApp == ThemeMode.light ? Colors.white : Color(0xFF141922),
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  label: ""),
            ]),
      ),
      body: tabs[index],
    );
  }

  void showSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
