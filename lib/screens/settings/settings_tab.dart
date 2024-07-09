import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../bottom_sheet/language_bottom_sheet.dart';
import '../../bottom_sheet/themeing_bottom_sheet.dart';
import '../../provider/my_provider.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,
              style: TextStyle(
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 18),
              padding: EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.white
                      : Color(0xFF141922),
                  border: Border.all(color: Colors.blue)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      pro.languageCode == "en"
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: TextStyle(color: Colors.blue)),
                  IconButton(
                      onPressed: () {
                        showLanguageBottomSheet();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(AppLocalizations.of(context)!.mode,
              style: TextStyle(
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showThemeingBottomSheet();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 18),
              padding: EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                  color: pro.modeApp == ThemeMode.light
                      ? Colors.white
                      : Color(0xFF141922),
                  border: Border.all(color: Colors.blue)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      pro.modeApp == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: TextStyle(color: Colors.blue)),
                  IconButton(
                      onPressed: () {
                        showThemeingBottomSheet();
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showThemeingBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        builder: (context) => ThemeingBottomSheet());
  }

  showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        builder: (context) => LanguageBottomSheet());
  }
}
