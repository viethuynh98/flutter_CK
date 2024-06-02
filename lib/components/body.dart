import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';
import 'progress_bar.dart';

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
              Text.rich(TextSpan(
                text: "Question 1",
                style: const TextStyle(
                    color: kSecondaryColor, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: "/10",
                    style: const TextStyle(
                        color: kSecondaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              )),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
        )
      ],
    );
  }
}
