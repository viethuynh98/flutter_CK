import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/body.dart';
import '../../controller/question_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    controller.startAnimation();
    controller.getQuestions();
    return PopScope(
      onPopInvoked: (bool _) {
        controller.reset();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: controller.nextQuestion,
                icon: const Icon(Icons.arrow_circle_right_outlined,
                    color: Colors.grey))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Body(),
      ),
    );
  }
}
