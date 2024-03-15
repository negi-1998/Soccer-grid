import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:soccer_grid/componenets/cell_dialog.dart';
import 'package:soccer_grid/componenets/game_grid.dart';
// import 'package:soccer_grid/componenets/no_answer_dialog.dart';
import 'package:soccer_grid/componenets/option_card.dart';
import 'package:soccer_grid/componenets/player_score.dart';

class GamePage extends StatefulWidget {
  final String player1Name;
  final String player2Name;

  const GamePage({Key? key, required this.player1Name, required this.player2Name}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int player1Score = 0;
  int player2Score = 0;
  List<String> cardOptions = [];
  String correctOption = '';
   Key optionCardKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Hide the status bar when the game page is initialized
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // Hide all system overlays
  }

  @override
  void dispose() {
    super.dispose();
    // Ensure the status bar is shown when the game page is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Builder(
            builder: (context){
              return PlayerScore(player1Name: widget.player1Name, player2Name: widget.player2Name);
            }
          ),
          Expanded(
            child: GameGrid(
              onOptionsChanged: (List<String> options) {
                setState(() {
                  cardOptions = List.from(options);
                  correctOption = cardOptions[0];
                  cardOptions.shuffle();
                  optionCardKey = UniqueKey();
                });
              },
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: [
                if (cardOptions.isNotEmpty)
                  Builder(
                    builder: (context) {
                      return Row(
                        children: [
                          OptionCard(option: cardOptions.elementAt(0), correctOption: correctOption),
                          OptionCard(option: cardOptions.length > 1 ? cardOptions.elementAt(1) : '', correctOption: correctOption),
                        ],
                      );
                    }
    
                  ),
                if (cardOptions.length > 2)
                  Builder(
                    builder: (context) {
                      return Row(
                      children: [
                        OptionCard(option: cardOptions.elementAt(2), correctOption: correctOption),
                        OptionCard(option: cardOptions.length > 3 ? cardOptions.elementAt(3) : '', correctOption: correctOption),
                      ],
                    );
                    }
        
                  ),

                // const RuleDialog(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
