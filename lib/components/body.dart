import 'package:flutter/material.dart';
import '../constants.dart';
import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressBar(),
              const SizedBox(height: kDefaultPadding),
              const Text.rich(TextSpan(
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
              const Divider(thickness: 1.5),
              const SizedBox(height: kDefaultPadding),
              Expanded(
                  child: PageView.builder(
                      itemBuilder: (context, index) => QuestionCard())),
            ],
          ),
        )
      ],
    );
  }
}
