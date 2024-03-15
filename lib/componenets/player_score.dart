import 'package:flutter/material.dart';

// class PlayerScore extends StatefulWidget {
//   final String player1Name;
//   final String player2Name;
//   const PlayerScore({Key? key, required this.player1Name, required this.player2Name}) : super(key: key);

//   @override
//   State<PlayerScore> createState() => _PlayerScoreState();
// }

// class _PlayerScoreState extends State<PlayerScore> {
//   int player1Score = 0;
//   int player2Score = 0;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Column(
//                     children: [
//                       Text(widget.player1Name),
//                       Text(player1Score.toString()),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(widget.player2Name),
//                       Text(player2Score.toString()),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }
class PlayerScore extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final int initialScore;
  const PlayerScore({Key? key, required this.player1Name, required this.player2Name, this.initialScore = 0}) : super(key: key);

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  late int player1Score;
  late int player2Score;
  late int player1NewScore=0;
  late int player2NewScore=0;

  @override
  void initState() {  // setting the initial scores of the players from the initialScore variable which has been set to 0
    super.initState();
    player1Score = widget.initialScore;    
    player2Score = widget.initialScore;
  }

  void updateScores(int player1Delta, int player2Delta) {
    setState(() {
      player1NewScore = player1Score + player1Delta;
      player2NewScore = player2Score + player2Delta;
    });
  }

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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(player1Score.toString()),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: 0,
                        onEnd: () {
                          setState(() {
                            player1Score = player1NewScore;
                            player1NewScore = 0;
                          });
                        },
                        child: Text(
                          player1NewScore > player1Score ? '+3' : '-1',
                          style: TextStyle(
                            color: player1NewScore > player1Score ? Colors.green : Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.player2Name),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(player2Score.toString()),
                    if (player2NewScore != 0)
                      AnimatedOpacity(
                        duration:const Duration(milliseconds: 500),
                        opacity: 0,
                        onEnd: () {
                          setState(() {
                            player2Score = player2NewScore;
                            player2NewScore = 0;
                          });
                        },
                        child: Text(
                          player2NewScore > player2Score ? '+3' : '-1',
                          style: TextStyle(
                            color: player2NewScore > player2Score ? Colors.green : Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
