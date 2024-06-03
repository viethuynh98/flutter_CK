import 'package:flutter/material.dart';

import 'questions.dart';

class DeleteQuestionCard extends StatelessWidget {
  const DeleteQuestionCard(
    this.question, {
    super.key,
    this.onDelete,
    this.onUpdate,
  });

  final Function()? onDelete;
  final Function()? onUpdate;
  final Question question;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 14.0)
            .copyWith(left: 16.0, right: 12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(question.question!,
                  style: const TextStyle(color: Colors.black)),
            ),
            GestureDetector(
              onTap: onUpdate,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0)
                    .copyWith(left: 20.0, right: 3.0),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 12.6,
                  child: Icon(Icons.edit_calendar_outlined,
                      size: 14.0, color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0)
                    .copyWith(left: 3.0, right: 4.0),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 12.6,
                  child: Icon(Icons.delete, size: 14.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
