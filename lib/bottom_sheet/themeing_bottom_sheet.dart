import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../provider/my_provider.dart';

class ThemeingBottomSheet extends StatelessWidget {
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
                provider.changeTheme(ThemeMode.dark);
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        color: provider.modeApp == ThemeMode.dark
                            ? Colors.blue
                            : Colors.grey[700]),
                  ),
                  Spacer(),
                  provider.modeApp == ThemeMode.dark
                      ? Icon(
                          Icons.done,
                          color: Colors.blue,
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
                provider.changeTheme(ThemeMode.light);
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 20,
                        color: provider.modeApp == ThemeMode.light
                            ? Colors.blue
                            : Colors.grey[700]),
                  ),
                  Spacer(),
                  provider.modeApp == ThemeMode.dark
                      ? SizedBox.shrink()
                      : Icon(
                          Icons.done,
                          size: 30,
                          color: provider.modeApp == ThemeMode.light
                              ? Colors.blue
                              : Colors.black,
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
