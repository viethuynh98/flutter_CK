class Question {
  int? id, answer;
  String? question;
  List<String>? options;

  Question();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'answer': answer,
    };
  }

factory Question.fromJson(Map<String, dynamic> json) => Question()
    ..id = json['id']
    ..answer = json['answer']
    ..question = json['question']
    ..options = json['options'];
}

List<Question> sample_data = [
  Question()
    ..id = 1
    ..question =
        "Flutter is an open-source UI software development kit created by ______"
    ..options = ['Apple', 'Google', 'Facebook', 'Microsoft']
    ..answer = 1,
  Question()
    ..id = 2
    ..question = "When google release Flutter."
    ..options = ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018']
    ..answer = 2,
  Question()
    ..id = 3
    ..question = "A memory location that holds a single letter or number."
    ..options = ['Double', 'Int', 'Char', 'Word']
    ..answer = 2,
  Question()
    ..id = 4
    ..question = "What command do you use to output data to the screen?"
    ..options = ['Cin', 'Count>>', 'Cout', 'Output>>']
    ..answer = 2,
];
