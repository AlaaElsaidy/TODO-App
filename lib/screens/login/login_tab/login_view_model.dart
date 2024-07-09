import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/screens/login/login_tab/connector.dart';

import '../../../base.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {
  Future<void> login(String email, String password) async {
    try {
      connector?.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.uid != null) {
        // var user=await readUserFirestore(credential.user!.uid);
        if (credential.user!.emailVerified) {
          connector?.hideLoading();
          connector?.goToHome();
          // showDialog(context: context, builder: (context) => AlertDialog(),)
        } else {
          connector?.hideLoading();
          connector?.showMessage('please verify your email');
        }
      }
    } on FirebaseAuthException catch (e) {
      connector?.hideLoading();
      connector?.showMessage('${e.message}');

      // if(e.code=="user-not-found"){
      //   onEror(e.message);
      //   print("No user found that email.");
      // }else if(e.code=="wrong-password") {
      //   onEror(e.message);
      //   print("Wrong password provided for that user.");
      // }
    }
  }
}
