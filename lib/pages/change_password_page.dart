import 'package:flutter/material.dart';
import '../components/app_elevated_button.dart';
import '../components/app_text_field.dart';
import 'login_page.dart';
import '../services/local/shared_prefs.dart';
import '../models/user_model.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, this.username});

  final String? username;

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  SharedPrefs prefs = SharedPrefs();
  late UserModel user;

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      usernameController.text = widget.username!;
    }
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
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/quiz_bg_1.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
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
                      children: [
                        const Text(
                          'Change Password',
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
                          isReadOnly: true,
                          hintText: 'Enter username',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Current password',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        AppTextField(
                          controller: currentPasswordController,
                          hintText: 'Enter current password',
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
                            text: 'Next',
                            onPressed: () {
                              String result = 'Enter your password';
                              if (currentPasswordController.text
                                  .trim()
                                  .isEmpty) {
                                showNotification(context, result);
                              } else if (newPasswordController.text.isEmpty) {
                                result = 'Enter your new password';
                                showNotification(context, result);
                              } else if (newPasswordController.text.isEmpty) {
                                result = 'Confirm your new password';
                                showNotification(context, result);
                              }
                              if (currentPasswordController.text ==
                                  user.password) {
                                if (currentPasswordController.text ==
                                    newPasswordController.text) {
                                  result =
                                      'New Password must different from current password';
                                  showNotification(context, result);
                                } else if (newPasswordController.text ==
                                    confirmPasswordController.text) {
                                  user = UserModel()
                                    ..username = user.username
                                    ..password = newPasswordController.text;
                                  result = 'Confirmed!';
                                  prefs.saveUser(user);

                                  Route route = MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                            username: widget.username,
                                          ));
                                  Navigator.push(context, route);
                                  showNotification(context, result);
                                }
                              } else {
                                result = 'Wrong password';
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
            Positioned(
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      prefs.removeAll();
                      Route route = MaterialPageRoute(
                          builder: (context) => const LoginPage());
                      Navigator.pushAndRemoveUntil(
                          context, route, (route) => false);
                    },
                    child: const Text(
                      'Remove All',
                      style: TextStyle(color: Colors.brown, fontSize: 16.8),
                    ),
                  ),
                ],
              ),
            )
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
