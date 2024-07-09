import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase/firebase_functions.dart';
import '../../layout/home_layout.dart';
import '../../provider/my_provider.dart';

class SignUpTab extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your name";
                    }
                    return null;
                  }),
              TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "age",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your age";
                    }
                    return null;
                  }),
              TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "e-mail",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your e-mail";
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
                    return null;
                  }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseFunctions.createUser(
                          nameController.text,
                          int.parse(ageController.text),
                          emailController.text,
                          passwordController.text, () {
                        pro.initUser();
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeLayout.routeName, (route) => false);
                      }, (message) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(message),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Okay"))
                            ],
                          ),
                        );
                      });
                    }
                  },
                  child: const Text("Sign Up")),
              // const SizedBox(height: 20,),
              // TextButton(onPressed: (){},
              //     child: const Text("Don\'t have an account? SignUp"))
            ],
          )),
    );
  }
}
