import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/app_elevated_button.dart';
import '../constants.dart';
import '../services/local/shared_prefs.dart';
import 'change_password_page.dart';
import 'login_page.dart';
import 'quiz/quiz_page.dart';

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
  void initState() {
    super.initState();
    if (widget.username != null) {
      nameController.text = widget.username!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text(
          "Let's Play Quiz",
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(color: Colors.orange, fontSize: 25.0),
                  ),
                  const SizedBox(height: 40.0),
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: AppElevatedButton(
                      text: "Let's start a quiz",
                      onPressed: () => Get.to(() => const QuizPage()),
                    ),
                  )
                ],
              ),
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
