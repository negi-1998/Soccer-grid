import 'package:flutter/material.dart';

class RuleDialog extends StatelessWidget {
  const RuleDialog({super.key});

  @override
  Widget build(BuildContext context) {
  return AlertDialog(
        title: const Text('Rules'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('The opposing player will chose a cell for you and you will have to choose the player from the given options who has played for both the clubs or both both the maager and/or both. There is no negative marking so choose the most appropriate option in case you are not sure of the answer. And most important, HAVE FUN'),
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
  
