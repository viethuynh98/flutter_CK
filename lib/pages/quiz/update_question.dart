import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_prefs_test1/components/app_text_field.dart';
import '../../components/app_elevated_button.dart';
import '../../controller/question_controller.dart';
import '../../models/questions.dart';
import '../../services/local/shared_prefs.dart';

class UpdateQuestionPage extends StatefulWidget {
  const UpdateQuestionPage({
    super.key,
    required this.qs,
  });

  final Question qs;

  @override
  State<UpdateQuestionPage> createState() => _UpdateQuestionPageState();
}

class _UpdateQuestionPageState extends State<UpdateQuestionPage> {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController answerController = TextEditingController();
  SharedPrefs prefs = SharedPrefs();
  List<Question> questions = sample_data;
  QuestionController controller = Get.put(QuestionController());

  @override
  void initState() {
    _getQuestions();
    getQuestionInfo();
    super.initState();
  }

  void getQuestionInfo() {
    questionController.text = widget.qs.question!;
    option1Controller.text = widget.qs.options![0];
    option2Controller.text = widget.qs.options![1];
    option3Controller.text = widget.qs.options![2];
    option4Controller.text = widget.qs.options![3];
    answerController.text = (widget.qs.answer! + 1).toString();
  }

  void _getQuestions() {
    prefs.getQuestions().then((value) {
      questions = value ?? [...sample_data];
      setState(() {});
    });
  }

  void _updateQuestion() async {
    String text = questionController.text.trim();
    String option1 = option1Controller.text.trim();
    String option2 = option2Controller.text.trim();
    String option3 = option3Controller.text.trim();
    String option4 = option4Controller.text.trim();
    int answer = int.parse(answerController.text.trim()) - 1;

    if (text.isEmpty ||
        option1.isEmpty ||
        option2.isEmpty ||
        option3.isEmpty ||
        option4.isEmpty ||
        answer < 0 ||
        answer > 3) {
      return;
    }

    final question = Question()
      ..id = widget.qs.id
      ..question = text
      ..options = [option1, option2, option3, option4]
      ..answer = answer;

    questions[widget.qs.id! - 1] = question;
    controller.questions = questions;
    prefs.saveQuestions(questions);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text("Question updated!"),
        duration: Duration(milliseconds: 750),
      ));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Update Question')),
        body: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/quiz_bg_1.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              top: 25.0,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 650,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15.0,
                        spreadRadius: 6.0,
                      ),
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)
                        .copyWith(top: 40.0, bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Question',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        AppTextField(
                          controller: questionController,
                          hintText: 'Enter question',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Option 1',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        AppTextField(
                          controller: option1Controller,
                          hintText: 'Enter option 1',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Option 2',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        AppTextField(
                          controller: option2Controller,
                          hintText: 'Enter option 2',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Option 3',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        AppTextField(
                          controller: option3Controller,
                          hintText: 'Enter option 3',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Option 4',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        AppTextField(
                          controller: option4Controller,
                          hintText: 'Enter option 4',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Answer',
                          style: TextStyle(color: Colors.blue, fontSize: 16.8),
                        ),
                        AppTextField(
                          controller: answerController,
                          hintText: 'Enter answer index (1-4)',
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                          action: TextInputAction.done,
                          // inputType: TextInputType.number,
                        ),
                        const SizedBox(height: 20.0),
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: AppElevatedButton(
                            onPressed: () {
                              // _updateQuestion();
                            },
                            text: "Update Question",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
