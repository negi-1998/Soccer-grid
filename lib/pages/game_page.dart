// import 'package:flutter/material.dart';


// class GamePage extends StatefulWidget {
//   final String player1Name;
//   final String player2Name;
//   const GamePage({super.key, required this.player1Name, required this.player2Name});

//   @override
//   State<GamePage> createState() => _GamePageState();
// }

// class _GamePageState extends State<GamePage> {
  
//   int player1Score = 0;
//   int player2Score=0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("SOCCER GRID", ),
//         centerTitle: true,
//         backgroundColor: Colors.amber,
//       ),
//       body:Column(
//         children: [
//           SizedBox(
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Column(
//                     children:[
//                       Text(widget.player1Name),
//                       Text(player1Score.toString()),
//                     ] 
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children:[
//                       Text(widget.player2Name,),
//                       Text(player1Score.toString()),
//                     ] 
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Text('haha')
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  const GamePage({super.key, required this.player1Name, required this.player2Name});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int player1Score = 0;
  int player2Score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SOCCER GRID"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to edges
              children: [
                // Player 1 column
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(widget.player1Name),
                      Text(player1Score.toString()),
                    ],
                  ),
                ),
                // Player 2 column (now on the right side)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // Align to the right
                    children: [
                      Text(widget.player2Name),
                      Text(player2Score.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Text('haha'),
        ],
      ),
    );
  }
}
