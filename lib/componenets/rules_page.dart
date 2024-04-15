import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rules'),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rules of the Game',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. The match will start when player 2 chooses any of the 16 cells in the grid',
                style: TextStyle(fontSize: 16, ),
              ),
              SizedBox(height: 10,),
              Text(
                '2. The player 1 wil get 4 options out of which one option is correct. The correct option will be the player who will be associated with the corresponding club/country/manager of his parent cell and column. Eg. If cell chosen lines with FC real madrid and Pep Guardiola, then player 1 will have to choose a player who has played for real madrid and has played under pep guariola at any point of his career. Remember it may not be important for the player to play under both the conditions at same time of his career.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10,),
              Text(
                '3. Correct answer will fetch you +3 points and incorrect answer will result in -1 points.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10,),
              Text(
                '4. Same proceure will be followed for player2 turn. Player with most points at the end will be declared as winner',
                style: TextStyle(fontSize: 16),
              ),
              // Add more rules as needed
            ],
          ),
        ),
      ),
    );
  }
}
