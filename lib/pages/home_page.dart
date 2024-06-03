import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/app_elevated_button.dart';
import '../constants.dart';
import '../controller/question_controller.dart';
import '../services/local/shared_prefs.dart';
import 'change_password_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'quiz/add_question.dart';
import 'quiz/manipulate_question.dart';
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
  QuestionController controller = Get.put(QuestionController());

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      nameController.text = widget.username!;
    }
    prefs.saveMaxScore(0);
  }

  @override
  Widget build(BuildContext context) {
    prefs.saveKeyCheck(true);
    return Scaffold(
      backgroundColor: const Color(0xFF3b5999).withOpacity(0.6),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 174, 204, 214)),
            child: GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(
                    builder: (context) => const ProFilePage());
                Navigator.push(context, route);
              },
              child: const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/image1.png'),
              ),
            ),
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
            title: const Text("Manipulate Question"),
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) => const ManipulateQuestionPage());
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
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      blurRadius: 15.0,
                      spreadRadius: 6.0,
                    ),
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0)
                        .copyWith(top: 10.0, bottom: 10.0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/icons/icon_quiz_fast.png'),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/icons/icon_quiz_math.png'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0)
                        .copyWith(top: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/icons/icon_quiz_logic.png'),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                              'assets/icons/icon_quiz_multiple_choice.png'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60.0),
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
