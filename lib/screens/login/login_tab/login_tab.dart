import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/base.dart';
import 'package:todo/screens/login/login_tab/connector.dart';

import '../../../layout/home_layout.dart';
import '../../../provider/my_provider.dart';
import 'login_view_model.dart';

class LoginTab extends StatefulWidget {
  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends BaseView<LoginViewModel, LoginTab>
    implements LoginConnector {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "e-mail",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your e-mail";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[com]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "please enter valid e-mail";
                      }
                      return null;
                    }),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      }
                      final bool passwordValid = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(value);
                      if (!passwordValid) {
                        return "please enter valid password";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        viewModel.login(
                          emailController.text, passwordController.text,
                          //     () {
                          //       pro.initUser();
                          //   Navigator.pushNamedAndRemoveUntil(
                          //       context, HomeLayout.routeName, (route) => false,);
                          // }, (errorMessage) {
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) => AlertDialog(
                          //       title: Text("Error"),
                          //       content: Text(errorMessage),
                          //       actions: [
                          //         ElevatedButton(
                          //             onPressed: () {}, child: Text("Okay"))
                          //       ],
                          //     ),
                          //   );
                          // }
                        );
                        // .
                        // then((value) {
                        //   Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routeName, (route) => false);
                        //     });
                      }
                    },
                    child: const Text("Login")),
                // const SizedBox(height: 20,),
                // TextButton(onPressed: (){},
                //     child: const Text("Don\'t have an account? SignUp"))
              ],
            )),
      ),
    );
  }

  @override
  goToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeLayout.routeName, (route) => false);
  }

  @override
  LoginViewModel initMyViewModel() {
    return LoginViewModel();
  }
}
