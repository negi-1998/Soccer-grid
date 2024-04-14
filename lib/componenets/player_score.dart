import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/providers/player_name_provider.dart';
import 'package:soccer_grid/providers/points_provider.dart';

class PlayerScore extends StatefulWidget {
  const PlayerScore({super.key});

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}                                                         

class _PlayerScoreState extends State<PlayerScore> {
  late int player1NewScore=0;
  late int player2NewScore=0;
  late int player1prev=0;
  late int player2prev=0;

  // @override                                                            
  // void initState() {  // setting the initial scores of the players from the initialScore variable which has been set to 0
  //   super.initState();
  //   player1Score = widget.initialScore;    
  //   player2Score = widget.initialScore;
  // }

  

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
                Text(context.watch<NameProvider>().player1Name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(context.watch<PointsProvider>().player1Score.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
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
                Text(context.watch<NameProvider>().player2Name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(context.watch<PointsProvider>().player2Score.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
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
