import 'package:flutter/material.dart';
import 'package:soccer_grid/componenets/game_grid.dart';
import 'package:flutter/services.dart';
import 'package:soccer_grid/componenets/option_card.dart';

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
      // appBar: AppBar(
      //   title: const Text("SOCCER GRID"),
      //   centerTitle: true,
      //   backgroundColor: Colors.amber,
      // ),
      body: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(widget.player1Name),
                      Text(player1Score.toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.player2Name),
                      Text(player2Score.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: GameGrid(),
          ),

          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: const Row(
                    
                    children: [
                      OptionCard(option: 'lalala',),
                      OptionCard(option: 'lalafg',)
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: const Row(
                    children: [
                      OptionCard(option: 'lalala',),
                      OptionCard(option: 'lalafg',)
                    ],
                  ),
                )
              ],
            ),
          ),
          
          const SizedBox(
            height: 25,
            width: 25,
          )
        ],
      ),
    );
  }
}
