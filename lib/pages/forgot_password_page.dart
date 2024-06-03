import 'package:flutter/material.dart';
import '../components/app_elevated_button.dart';
import '../components/app_text_field.dart';
import 'login_page.dart';
import '../services/local/shared_prefs.dart';
import '../models/user_model.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, this.username});

  final String? username;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  SharedPrefs prefs = SharedPrefs();
  late UserModel user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() {
    prefs.getUser().then((value) {
      user = value ?? UserModel();
      setState(() {});
    });
  }

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
              top: 100.0,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 600,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(top: 40.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.blue, fontSize: 33.6),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        'Username',
                        style: TextStyle(color: Colors.blue, fontSize: 16.8),
                      ),
                      AppTextField(
                        controller: usernameController,
                        hintText: 'Enter username',
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'New password',
                        style: TextStyle(color: Colors.blue, fontSize: 16.8),
                      ),
                      AppTextField(
                        controller: newPasswordController,
                        hintText: 'Enter password',
                        isPassword: true,
                        prefixIcon:
                            const Icon(Icons.password, color: Colors.grey),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Confirm password',
                        style: TextStyle(color: Colors.blue, fontSize: 16.8),
                      ),
                      AppTextField(
                        controller: confirmPasswordController,
                        hintText: 'Enter confirm password',
                        action: TextInputAction.done,
                        isPassword: true,
                        prefixIcon:
                            const Icon(Icons.password, color: Colors.grey),
                      ),
                      const SizedBox(height: 40.0),
                      FractionallySizedBox(
                        widthFactor: 0.4,
                        child: AppElevatedButton(
                          text: 'Confirm',
                          onPressed: () async {
                            String result = 'Enter your password';
                            if (newPasswordController.text.isEmpty) {
                              result = 'Enter your new password';
                              showNotification(context, result);
                            } else if (confirmPasswordController.text.isEmpty) {
                              result = 'Confirm your new password';
                              showNotification(context, result);
                            } else if (newPasswordController.text ==
                                confirmPasswordController.text) {
                              if (usernameController.text == user.username) {
                                user.password = newPasswordController.text;
                                prefs.saveUser(user);
                                result = 'Password changed successfully!';
                                Route route = MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                    username: usernameController.text,
                                  ),
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  route,
                                  (route) => false,
                                );
                              } else {
                                result = 'Username not found';
                              }
                              showNotification(context, result);
                            } else {
                              result = 'Passwords do not match';
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
