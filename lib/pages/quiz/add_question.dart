// import 'package:flutter/material.dart';
// import '../../models/questions.dart';
// import '../../services/local/shared_prefs.dart';

// class AddQuestionPage extends StatefulWidget {
//   const AddQuestionPage({super.key});

//   @override
//   State<AddQuestionPage> createState() => _AddQuestionPageState();
// }

// class _AddQuestionPageState extends State<AddQuestionPage> {
//   TextEditingController questionController = TextEditingController();
//   TextEditingController option1Controller = TextEditingController();
//   TextEditingController option2Controller = TextEditingController();
//   TextEditingController option3Controller = TextEditingController();
//   TextEditingController option4Controller = TextEditingController();
//   TextEditingController answerController = TextEditingController();
//   SharedPrefs prefs = SharedPrefs();

//   void _addQuestion() async {
//     String text = questionController.text.trim();
//     String option1 = option1Controller.text.trim();
//     String option2 = option2Controller.text.trim();
//     String option3 = option3Controller.text.trim();
//     String option4 = option4Controller.text.trim();
//     int answer = int.parse(answerController.text.trim());

//     if (text.isEmpty ||
//         option1.isEmpty ||
//         option2.isEmpty ||
//         option3.isEmpty ||
//         option4.isEmpty ||
//         answer < 1 ||
//         answer > 4) {
//       return;
//     }

//     final question = Question(
//       id: DateTime.now().millisecondsSinceEpoch,
//       question: text,
//       options: [option1, option2, option3, option4],
//       answer: answer,
//     );

//     List<Question> currentQuestions = await prefs.getQuestions();
//     currentQuestions.add(question);
//     await prefs.saveQuestions(currentQuestions);

//     // Clear fields and show a confirmation
//     _clearFields();
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('Question added!')));
//   }

//   void _clearFields() {
//     questionController.clear();
//     option1Controller.clear();
//     option2Controller.clear();
//     option3Controller.clear();
//     option4Controller.clear();
//     answerController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Question')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: questionController,
//               decoration: InputDecoration(labelText: 'Question'),
//             ),
//             TextField(
//               controller: option1Controller,
//               decoration: InputDecoration(labelText: 'Option 1'),
//             ),
//             TextField(
//               controller: option2Controller,
//               decoration: InputDecoration(labelText: 'Option 2'),
//             ),
//             TextField(
//               controller: option3Controller,
//               decoration: InputDecoration(labelText: 'Option 3'),
//             ),
//             TextField(
//               controller: option4Controller,
//               decoration: InputDecoration(labelText: 'Option 4'),
//             ),
//             TextField(
//               controller: answerController,
//               decoration: InputDecoration(labelText: 'Answer (1-4)'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _addQuestion,
//               child: const Text('Add Question'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
