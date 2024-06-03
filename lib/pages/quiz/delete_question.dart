import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/question_controller.dart';
import '../../models/question_card.dart';
import '../../models/questions.dart';
import '../../services/local/shared_prefs.dart';

class DeleteQuestionPage extends StatefulWidget {
  const DeleteQuestionPage({super.key});

  @override
  State<DeleteQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<DeleteQuestionPage> {
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

  void _deleteQuestion() async {
    // questions.removeRange(question);
    controller.questions = questions;
    prefs.saveQuestions(questions);
    // Clear fields and show a confirmation

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(
        content: Text("Question added!"),
        duration: Duration(milliseconds: 750),
      ));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(title: const Text('Add Question')),
          body: Stack(
            children: [
              Positioned.fill(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 20.0),
                child: Column(
                  children: [
                    const Text(
                      "List Questions",
                      style: TextStyle(color: Colors.green, fontSize: 25.5),
                    ),
                    const Divider(
                      height: 1.2,
                      thickness: 1.2,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                        child: ListView.separated(
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        return DeleteQuestionCard(
                          question,
                          onDelete: () => _delete(context, question),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 20.0),
                      itemCount: questions.length,
                    ))
                  ],
                ),
              ))
            ],
          )),
    );
  }

  void _delete(BuildContext context, Question question) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('😐'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Delete this task?',
                  style: TextStyle(color: Colors.brown, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.blue, fontSize: 16.8),
              ),
              onPressed: () {
                questions.removeWhere((e) => e.id == question.id);
                prefs.saveQuestions(questions);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red, fontSize: 16.8),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
