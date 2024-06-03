import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/app_elevated_button.dart';
import '../components/app_text_field.dart';
import '../models/user_model.dart';
import '../services/local/shared_prefs.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  SharedPrefs prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: Container(
              color: const Color(0xFF3b5999).withOpacity(0.6),
            )),
            Positioned(
              top: 50.0,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 650,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15.0,
                        spreadRadius: 6.0,
                      ),
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)
                        .copyWith(top: 40.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(color: Colors.blue, fontSize: 33.6),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40.0),
                        const Text(
                          'Username',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        const SizedBox(height: 5.0),
                        AppTextField(
                          controller: usernameController,
                          hintText: 'Enter Username',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        const SizedBox(height: 5.0),
                        AppTextField(
                          controller: passwordController,
                          hintText: 'Enter Password',
                          prefixIcon:
                              const Icon(Icons.password, color: Colors.grey),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        const SizedBox(height: 5.0),
                        AppTextField(
                          controller: passwordConfirmController,
                          hintText: 'Enter Confirm Password',
                          prefixIcon:
                              const Icon(Icons.password, color: Colors.grey),
                          action: TextInputAction.done,
                        ),
                        const SizedBox(height: 40.0),
                        FractionallySizedBox(
                          widthFactor: 0.4,
                          child: AppElevatedButton(
                            text: 'Confirm',
                            onPressed: () async {
                              String result = 'Invalid username';
                              if (usernameController.text.trim().isEmpty) {
                                showNotification(context, result);
                              } else if (passwordController.text.isEmpty) {
                                result = 'Invalid password';
                                showNotification(context, result);
                              } else if (passwordController.text !=
                                  passwordConfirmController.text) {
                                result = 'No match password';
                                showNotification(context, result);
                              } else {
                                final user = UserModel()
                                  ..username = usernameController.text.trim()
                                  ..password = passwordConfirmController.text;
                                prefs.saveUser(user);
                                result = 'Success!';
                                Route route = MaterialPageRoute(
                                    builder: (context) => LoginPage(
                                          username:
                                              usernameController.text.trim(),
                                        ));
                                Navigator.push(context, route);
                                showNotification(context, result);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNotification(BuildContext context, String result) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(result),
      ));
  }
}
