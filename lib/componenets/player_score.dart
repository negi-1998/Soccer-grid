import 'package:flutter/material.dart';

class PlayerScore extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  const PlayerScore({Key? key, required this.player1Name, required this.player2Name}) : super(key: key);

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  int player1Score = 0;
  int player2Score = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          );
  }
}