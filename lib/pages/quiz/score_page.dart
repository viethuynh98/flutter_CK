import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/question_controller.dart';
import '../../models/user_model.dart';
import '../../services/local/shared_prefs.dart';
import '../home_page.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  QuestionController controller = Get.put(QuestionController());
  SharedPrefs prefs = SharedPrefs();
  late UserModel user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    prefs.getUser().then((value) {
      user = value ?? UserModel();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              "${controller.numOfCorrectAns * 10}/ ${controller.questions.length * 10}",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                controller.reset();
                prefs.saveNumOfPlays();
                Route route = MaterialPageRoute(
                    builder: (context) => HomePage(
                          username: user.username,
                        ));
                Navigator.pushReplacement(context, route);
              },
              child: const Text('Back to Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
