import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/pages/game_page.dart';
import 'package:soccer_grid/pages/home_page.dart';
import 'package:soccer_grid/providers/home_page_refresh.dart';
import 'package:soccer_grid/providers/points_provider.dart';

class DrawDialog extends StatelessWidget {
  const DrawDialog({super.key});



  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomePageModel>(context);
  return AlertDialog(
        title: const Text('A close fight!!'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('The match has ended in a draw. Do you wish to restart the game or go to Initial screen'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Restart'),
            onPressed: () {
              model.triggerRebuild();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              context.read<PointsProvider>().player1Score=0;
              context.read<PointsProvider>().player2Score=0;
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>const GamePage(),
                  )
                );
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
  
