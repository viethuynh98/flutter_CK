import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../controller/question_controller.dart';
import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // access controller
    QuestionController questionController = Get.put(QuestionController());
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ProgressBar(),
            ),
            const SizedBox(height: kDefaultPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(() => Text.rich(TextSpan(
                    text: "Question ${questionController.questionNumber}",
                    style: const TextStyle(
                        color: kSecondaryColor, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: " / ${questionController.questions.length}",
                        style: const TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))),
            ),
            const Divider(thickness: 1.5),
            const SizedBox(height: kDefaultPadding),
            Expanded(
                child: PageView.builder(
                    // block swipe to the next question
                    physics: const NeverScrollableScrollPhysics(),
                    controller: questionController.pageController,
                    onPageChanged: questionController.updateTheQuestionNumber,
                    itemCount: questionController.questions.length,
                    itemBuilder: (context, index) => QuestionCard(
                          question: questionController.questions[index],
                        ))),
            const SizedBox(height: 20.0),
          ],
        )
      ],
    );
  }
}
