import 'package:flutter/material.dart';
import 'package:shared_prefs_test1/pages/forgot_password_page.dart';
import '../components/app_elevated_button.dart';
import '../components/app_text_field.dart';
import '../models/user_model.dart';
import 'home_page.dart';
import '../services/local/shared_prefs.dart';
import 'register_page.dart';

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
    prefs.saveKeyCheck(false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: 300.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/quiz_bg_1.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 90.0, left: 20.0),
                    color: const Color(0xFF3b5999).withOpacity(0.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ta có thể sử dụng RichText để tạo text với nhiều format khác nhau
                        RichText(
                          text: TextSpan(
                            text: "Welcome to ",
                            style: TextStyle(
                                color: Colors.yellow[700], fontSize: 25.0),
                            children: [
                              TextSpan(
                                  text: "QQ Quiz",
                                  style: TextStyle(
                                      color: Colors.amber[900], fontSize: 25.0))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Let's Play Together",
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: 200,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 500,
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
                      // const Text(
                      //   'Login',
                      //   style: TextStyle(color: Colors.blue, fontSize: 33.6),
                      //   textAlign: TextAlign.center,
                      // ),
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
                              prefs.saveKeyCheck(true);
                              Route route = MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        // title: 'HomePage',
                                        username:
                                            usernameController.text.trim(),
                                      ));
                              Navigator.pushAndRemoveUntil(
                                context,
                                route,
                                (route) => false,
                              );
                              showNotification(context, result);
                            } else {
                              result = "Wrong username or wrong password";
                              showNotification(context, result);
                            }
                          },
                        ),
                      ),
                      const Spacer(),
                      !isValid
                          ? GestureDetector(
                              onTap: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) => const RegisterPage());
                                Navigator.push(context, route);
                              },
                              child: const Text(
                                'Create an Account',
                                style: TextStyle(
                                    color: Colors.brown, fontSize: 16.8),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage(
                                          username: widget.username,
                                        ));
                                Navigator.push(context, route);
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.brown, fontSize: 16.8),
                                textAlign: TextAlign.center,
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
        duration: const Duration(milliseconds: 750),
      ));
  }
}
