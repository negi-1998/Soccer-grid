import 'package:flutter/material.dart';

class CellDialog extends StatelessWidget {
  const CellDialog({super.key});

  @override
  Widget build(BuildContext context) {
  return AlertDialog(
        title: const Text('Choose other cell'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This cell has been chosen before '),
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
  
