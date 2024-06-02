import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/body.dart';
import '../../controller/question_controller.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _controller.nextQuestion,
              icon: const Icon(Icons.arrow_circle_right_outlined,
                  color: Colors.grey))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Body(),
    );
  }
}
