import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../provider/my_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      color:
          provider.modeApp == ThemeMode.dark ? Color(0xFF060E1E) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                provider.changeLanguage("en");
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.english,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        color: provider.languageCode == "en"
                            ? Colors.blue
                            : Colors.grey[700]),
                  ),
                  Spacer(),
                  provider.languageCode == "en"
                      ? Icon(
                          Icons.done,
                          color: provider.languageCode == "en"
                              ? Colors.blue
                              : Colors.grey[700],
                          size: 30,
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            InkWell(
              onTap: () {
                provider.changeLanguage("ar");
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        color: provider.languageCode == "ar"
                            ? Colors.blue
                            : Colors.grey[700]),
                  ),
                  Spacer(),
                  provider.languageCode == "en"
                      ? SizedBox.shrink()
                      : Icon(
                          Icons.done,
                          size: 30,
                          color: provider.languageCode == "ar"
                              ? Colors.blue
                              : Colors.grey[700],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
