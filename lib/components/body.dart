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
    QuestionController _questionController = Get.put(QuestionController());
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text.rich(TextSpan(
                text: "Question 1",
                style: TextStyle(
                    color: kSecondaryColor, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: "/10",
                    style: TextStyle(
                        color: kSecondaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              )),
            ),
            const Divider(thickness: 1.5),
            const SizedBox(height: kDefaultPadding),
            Expanded(
                child: PageView.builder(
                    itemCount: _questionController.questions.length,
                    itemBuilder: (context, index) => QuestionCard(
                          question: _questionController.questions[index],
                        ))),
            const SizedBox(height: 20.0),
          ],
        )
      ],
    );
  }
}
