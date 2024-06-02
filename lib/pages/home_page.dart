import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_prefs_test1/pages/quiz/quiz_page.dart';
import 'package:shared_prefs_test1/services/local/shared_prefs.dart';
import '../components/app_elevated_button.dart';
import '../components/app_text_field.dart';
import '../constants.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'change_password_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.username});

  final String? username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  SharedPrefs prefs = SharedPrefs();
  final String title = 'Welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // WebsafeSvg.asset("assets/icons/bg.svg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                const Text(
                  "Let's Play Quiz",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  title,
                  style: const TextStyle(color: Colors.orange, fontSize: 25.0),
                ),
                AppTextField(
                  controller: nameController,
                  hintText: 'Enter Your Name',
                  action: TextInputAction.done,
                  prefixIcon: const Icon(Icons.home_max, color: Colors.grey),
                ),
                const SizedBox(height: 40.0),
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: AppElevatedButton(
                    text: "Let's start a quiz",
                    onPressed: () => Get.to(const QuizPage()),
                  ),
                )
              ],
            ),
          ),
           Positioned(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => ChangePasswordPage(
                                  username: widget.username,
                                ));
                        Navigator.push(context, route);
                      },
                      child: const Text(
                        'Change password',
                        style: TextStyle(color: Colors.brown, fontSize: 16.8),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        prefs.saveKeyCheck();
                        Route route = MaterialPageRoute(
                            builder: (context) => const LoginPage());
                        Navigator.of(context).pushAndRemoveUntil(
                          route,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.brown, fontSize: 16.8),
                      ),
                    ),
                  ],
                ))
        ],
      ),
    );
  }
}
