import 'package:flutter/material.dart';
import 'package:shared_prefs_test1/pages/register_page.dart';
import '../components/app_elevated_button.dart';
import '../components/app_text_field.dart';
import '../models/user_model.dart';
import 'home_page.dart';
import '../services/local/shared_prefs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.username});

  final String? username;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SharedPrefs prefs = SharedPrefs();
  late UserModel user;
  late bool isValid = false;

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
      isValid = value != null;
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0)
                      .copyWith(top: 40.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Login',
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
                        'Password',
                        style: TextStyle(color: Colors.blue, fontSize: 16.8),
                      ),
                      AppTextField(
                        controller: passwordController,
                        hintText: 'Enter password',
                        action: TextInputAction.done,
                        isPassword: true,
                        prefixIcon:
                            const Icon(Icons.password, color: Colors.grey),
                      ),
                      const SizedBox(height: 40.0),
                      FractionallySizedBox(
                        widthFactor: 0.4,
                        child: AppElevatedButton(
                          text: 'Login',
                          onPressed: () async {
                            String result = 'Invalid username';
                            if (usernameController.text.trim().isEmpty) {
                              showNotification(context, result);
                            } else if (passwordController.text.isEmpty) {
                              result = 'Invalid password';
                              showNotification(context, result);
                            } else if (usernameController.text.trim() ==
                                    user.username &&
                                passwordController.text == user.password) {
                              result = 'Login success!';
                              Route route = MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        title: 'HomePage',
                                        username:
                                            usernameController.text.trim(),
                                      ));
                              Navigator.push(context, route);
                              showNotification(context, result);
                            } else {
                              result = "Wrong username or wrong password";
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
            if (!isValid)
              Positioned(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => const RegisterPage());
                        Navigator.push(context, route);
                      },
                      child: const Text(
                        'Create an Account',
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
        duration: const Duration(milliseconds: 750),
      ));
  }
}
