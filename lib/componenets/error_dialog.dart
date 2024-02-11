import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
  return AlertDialog(
        title: const Text('I saw you champ'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Choose your team and enter your name before proceeding '),
              // Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
  }
}
  
