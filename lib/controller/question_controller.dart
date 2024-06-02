import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/questions.dart';
import '../pages/quiz/score_page.dart';

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // animated progress bar
  late AnimationController _animationController;
  late Animation _animation;

  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  // run when initialize instance widget
  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 60), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        update();
      });

    // start animation
    _animationController.forward().whenComplete(nextQuestion);

    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;

      // stop the counter when give the answer
      _animationController.stop();
      // rebuild GetBuilder => progressBar
      update();

      // auto go to next page after 3 sec
      Future.delayed(const Duration(seconds: nextPageDuration), () {
        nextQuestion();
      });
    }
  }

  void nextQuestion() {
    print(_questionNumber);
    if (_questionNumber != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(microseconds: 250), curve: Curves.ease);

      // reset the counter
      _animationController.reset();

      // start counter again
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(() => ScorePage());
    }
  }

  void updateTheQuestionNumber(int index) {
    _questionNumber.value = index + 1;
  }
}
