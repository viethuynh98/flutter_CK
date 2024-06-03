import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_prefs_test1/components/app_text_field.dart';
import '../../components/app_elevated_button.dart';
import '../../controller/question_controller.dart';
import '../../models/questions.dart';
import '../../services/local/shared_prefs.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
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
    super.initState();
  }

  void _getQuestions() {
    prefs.getQuestions().then((value) {
      // print("ffffffffffffffffffffffffffffffffffffffffffffff");
      questions = value ?? [...sample_data];
      setState(() {});
    });
  }

  void _addQuestion() async {
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
      ..id = questions.length
      ..question = text
      ..options = [option1, option2, option3, option4]
      ..answer = answer;

    questions.add(question);
    controller.questions = questions;
    prefs.saveQuestions(questions);
    // Clear fields and show a confirmation
    _clearFields();

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text("Question added!"),
        duration: Duration(milliseconds: 750),
      ));

    setState(() {});
  }

  void _clearFields() {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
    answerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Option 1',
                style: TextStyle(color: Colors.blue, fontSize: 16.8),
              ),
              AppTextField(
                controller: option1Controller,
                hintText: 'Enter option 1',
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Option 2',
                style: TextStyle(color: Colors.blue, fontSize: 16.8),
              ),
              AppTextField(
                controller: option2Controller,
                hintText: 'Enter option 2',
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Option 3',
                style: TextStyle(color: Colors.blue, fontSize: 16.8),
              ),
              AppTextField(
                controller: option3Controller,
                hintText: 'Enter option 3',
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Option 4',
                style: TextStyle(color: Colors.blue, fontSize: 16.8),
              ),
              AppTextField(
                controller: option4Controller,
                hintText: 'Enter option 4',
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Answer',
                style: TextStyle(color: Colors.blue, fontSize: 16.8),
              ),
              AppTextField(
                controller: answerController,
                hintText: 'Enter answer index (1-4)',
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                action: TextInputAction.done,
                // inputType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              AppElevatedButton(
                onPressed: _addQuestion,
                text: "Add Question",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
