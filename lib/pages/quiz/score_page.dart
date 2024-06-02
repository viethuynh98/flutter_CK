import 'package:flutter/material.dart';
import '../../controller/question_controller.dart';
import 'package:get/get.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
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
              "${_controller.correctAns * 10}/ ${_controller.questions.length * 10}",
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
