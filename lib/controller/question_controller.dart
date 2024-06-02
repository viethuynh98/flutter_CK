import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/questions.dart';
import '../pages/quiz/score_page.dart';
import '../services/local/shared_prefs.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // animated progress bar
  late AnimationController _animationController;
  late Animation _animation;

  SharedPrefs prefs = SharedPrefs();

  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  List<Question> questions = sample_data;

  bool isAnswered = false;

  late int correctAns;
  late int selectedAns;

  final RxInt questionNumber = 1.obs;

  int numOfCorrectAns = 0;

  void getQuestions() {
    prefs.getQuestions().then((value) {
      questions = value ?? [...sample_data];
    });
  }

  void reset() {
    // Reset animation controller
    _animationController.reset();

    // Reset animation
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _pageController.dispose();
    _pageController = PageController();

    isAnswered = false;
    correctAns = 0;
    selectedAns = 0;
    questionNumber.value = 1;
    numOfCorrectAns = 0;
  }

  void startAnimation() {
    _animationController.forward().whenComplete(nextQuestion);
  }

  // run when initialize instance widget
  @override
  void onInit() {
    super.onInit();
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        update();
      });

    _pageController = PageController();
    getQuestions();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    isAnswered = true;
    correctAns = question.answer!;
    selectedAns = selectedIndex;

    if (correctAns == selectedAns) {
      numOfCorrectAns++;
    }
    // stop the counter when give the answer
    _animationController.stop();
    // rebuild GetBuilder => progressBar
    update();

    // auto go to next page after 3 sec
    Future.delayed(const Duration(seconds: nextPageDuration), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (questionNumber.value != questions.length) {
      isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // reset the counter
      _animationController.reset();

      // start counter again
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(() => const ScorePage());
    }
  }

  void updateTheQuestionNumber(int index) {
    questionNumber.value = index + 1;
  }
}
