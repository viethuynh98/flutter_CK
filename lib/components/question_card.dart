import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../controller/question_controller.dart';
import '../models/questions.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
            .copyWith(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(25.0)),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Text(question.question,
                style: const TextStyle(color: Colors.black)),
            const SizedBox(height: kDefaultFontSize),
            ...List.generate(
                question.options.length,
                (index) => Option(
                    text: question.options[index],
                    index: index,
                    onPress: () {
                      if (!controller.isAnswered) {
                        controller.checkAns(question, index);
                      }
                    }))
          ],
        ));
  }
}
