import 'package:flutter/material.dart';

import '../../models/questions.dart';
import '../../services/local/shared_prefs.dart';
import '../home_page.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  late TextEditingController questionController;
  late TextEditingController option1Controller;
  late TextEditingController option2Controller;
  late TextEditingController option3Controller;
  late TextEditingController option4Controller;
  late TextEditingController answerController;

  SharedPrefs prefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController();
    option1Controller = TextEditingController();
    option2Controller = TextEditingController();
    option3Controller = TextEditingController();
    option4Controller = TextEditingController();
    answerController = TextEditingController();
  }

  @override
  void dispose() {
    questionController.dispose();
    option1Controller.dispose();
    option2Controller.dispose();
    option3Controller.dispose();
    option4Controller.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(labelText: 'Question'),
              ),
              TextField(
                controller: option1Controller,
                decoration: const InputDecoration(labelText: 'Option 1'),
              ),
              TextField(
                controller: option2Controller,
                decoration: const InputDecoration(labelText: 'Option 2'),
              ),
              TextField(
                controller: option3Controller,
                decoration: const InputDecoration(labelText: 'Option 3'),
              ),
              TextField(
                controller: option4Controller,
                decoration: const InputDecoration(labelText: 'Option 4'),
              ),
              TextField(
                controller: answerController,
                decoration: const InputDecoration(labelText: 'Answer Index'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () async {
                  Question newQuestion = Question(
                    id: sample_data.length + 1,
                    question: questionController.text,
                    options: [
                      option1Controller.text,
                      option2Controller.text,
                      option3Controller.text,
                      option4Controller.text,
                    ],
                    answer: int.parse(answerController.text),
                  );

                  List<Question> newQuestions = [newQuestion];

                  await prefs.saveNewQuestions(newQuestions);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Question added successfully!')),
                  );

                  questionController.clear();
                  option1Controller.clear();
                  option2Controller.clear();
                  option3Controller.clear();
                  option4Controller.clear();
                  answerController.clear();

                  Route route =
                      MaterialPageRoute(builder: (context) => const HomePage());
                  Navigator.pushReplacement(context, route);
                },
                child: const Text('Add Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
