import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_prefs_test1/pages/quiz/add_question.dart';
import 'package:shared_prefs_test1/pages/quiz/delete_question.dart';
import '../components/app_elevated_button.dart';
import '../constants.dart';
import '../controller/question_controller.dart';
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
  QuestionController controller = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      nameController.text = widget.username!;
    }
  }

  @override
  Widget build(BuildContext context) {
    prefs.saveKeyCheck(true);
    return Scaffold(
      // backgroundColor: Colors.greenAccent,
      drawer: Drawer(
          child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            child: Text("Menu"),
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text("Add Question"),
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) => const AddQuestionPage());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Delete Question"),
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) => const DeleteQuestionPage());
              Navigator.push(context, route);
            },
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => const QuizPage());
                        Navigator.push(context, route);
                      },
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
