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
      drawer: Drawer(
          child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text("Menu"),
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text("Change Password"),
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) => ChangePasswordPage(
                        username: widget.username,
                      ));
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log out"),
            onTap: () {
              prefs.saveKeyCheck();
              Route route =
                  MaterialPageRoute(builder: (context) => const LoginPage());
              Navigator.of(context).pushAndRemoveUntil(
                route,
                (route) => false,
              );
            },
          ),
        ],
      )),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
        ],
      ),
    );
  }
}
