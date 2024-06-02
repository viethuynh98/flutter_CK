import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_prefs_test1/constants.dart';

import '../../controller/question_controller.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // size non positioned children
        children: [
          Spacer(),
          const Text(
            "Score",
            style: TextStyle(color: kGrayColor, fontSize: 25.5),
          ),
          Spacer(),
          Text(
            "${_controller.correctAns * 10}/ ${_controller.questions.length * 10}",
            style: const TextStyle(color: kGrayColor, fontSize: 25.5),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
