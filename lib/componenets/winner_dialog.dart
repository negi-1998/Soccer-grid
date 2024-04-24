import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/pages/game_page.dart';
import 'package:soccer_grid/pages/home_page.dart';
import 'package:soccer_grid/providers/points_provider.dart';

class WinnerDialog extends StatelessWidget {
  final String winnerName;
  const WinnerDialog({super.key, required this.winnerName, });
  

  @override
  Widget build(BuildContext context) {
    void restartGame() {
      context.read<PointsProvider>().player1Score = 0;
      context.read<PointsProvider>().player2Score = 0;
      Navigator.of(context).popUntil((route) => route.isFirst); // Pop dialogs and GamePage
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GamePage()));
    }
  return AlertDialog(
        title: const Text('Congratulations'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('$winnerName has won this round. Do you wish to restart the game or go to Initial screen'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Restart'),
            onPressed: () {
              restartGame();
},

          ),
          TextButton(
            child: const Text('Main Menu'),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<PointsProvider>().player1Score=0;
              context.read<PointsProvider>().player2Score=0;
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>const HomePage(),
                  )
                );
            },
          ),
        ],
      );
  }
}
  
