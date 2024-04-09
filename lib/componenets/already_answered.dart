import 'package:flutter/material.dart';

class AlreadyAnswered extends StatelessWidget {
  const AlreadyAnswered({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('You have already answered'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('You can answer only once. Take a breath and prepare for the next question.'),
              // Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
  }
}