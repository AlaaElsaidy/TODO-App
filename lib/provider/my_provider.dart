import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_functions.dart';
import '../models/user_model.dart';

class MyProvider extends ChangeNotifier {
  String languageCode = 'en';
  bool isEnglish = true;
  ThemeMode modeApp = ThemeMode.light;
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseFunctions.readUserFirestore(firebaseUser!.uid);
    notifyListeners();
  }

  void changeLanguage(String langCode) {
    languageCode = langCode;
    notifyListeners();
  }

  changeTheme(ThemeMode mode) {
    modeApp = mode;
    notifyListeners();
  }

//  getBackground() {
//   if (modeApp == ThemeMode.light) {
//     return Scaffold(
//       backgroundColor: mint
//     );
//   } else {
//     return Scaffold(
//         backgroundColor: Color(0xFF141A2E)
//     );
//   }
// }
}
