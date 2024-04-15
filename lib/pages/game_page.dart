// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:soccer_grid/componenets/game_grid.dart';
// import 'package:soccer_grid/componenets/option_card.dart';
// import 'package:soccer_grid/componenets/player_score.dart';
// import 'package:soccer_grid/providers/home_page_refresh.dart';
// import 'package:soccer_grid/providers/points_provider.dart';

// class GamePage extends StatefulWidget {
//   const GamePage({super.key});

//   @override
//   State<GamePage> createState() => _GamePageState();
// }

// class _GamePageState extends State<GamePage> {
//   int player1Score = 0;
//   int player2Score = 0;
//   List<String> cardOptions = [];
//   String correctOption = '';
//    Key optionCardKey = UniqueKey();
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     // Hide the status bar when the game page is initialized
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // Hide all system overlays
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Ensure the status bar is shown when the game page is disposed
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final model = Provider.of<HomePageModel>(context);
//     if (model.rebuildHomepage) {
//       setState(() {
//       });
//       model.resetTrigger();
//       context.read<PointsProvider>().player1Score=0;
//       context.read<PointsProvider>().player2Score=0;
//     }
//     return Scaffold(
//       body: Column(
//         children: [
//           Builder(
//             builder: (context){
//               return const PlayerScore();
//             }
//           ),
//           Expanded(
//             child: GameGrid(
//               onOptionsChanged: (List<String> options) {
//                 setState(() {
//                   cardOptions = List.from(options);
//                   correctOption = cardOptions[0];
//                   cardOptions.shuffle();
//                   optionCardKey = UniqueKey();
//                 });
//               },
//             ),
//           ),
//           Container(
//             height: 300,
//             width: double.infinity,
//             // color: Colors.grey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 if (cardOptions.isNotEmpty)
//                   Builder(
//                     builder: (context) {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           AnimatedPositioned(
//                             duration: const Duration(seconds: 1),
//                             curve: Curves.easeInOut,
//                             left: 0.5 * MediaQuery.of(context).size.width, // Animation target
//                             top: 0,
//                             child: OptionCard(option: cardOptions.elementAt(0), correctOption: correctOption)),
                          
//                           AnimatedPositioned(
//                             duration: const Duration(seconds: 1),
//                             curve: Curves.easeInOut,
//                             left: 0.5 * MediaQuery.of(context).size.width, // Animation target
//                             top: 0,
//                             child: OptionCard(option: cardOptions.length > 1 ? cardOptions.elementAt(1) : '', correctOption: correctOption)),
//                         ],
                        
//                       );
//                     }
    
//                   ),
//                 if (cardOptions.length > 2)
//                   Builder(
//                     builder: (context) {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           OptionCard(option: cardOptions.elementAt(2), correctOption: correctOption),
                          
//                           OptionCard(option: cardOptions.length > 3 ? cardOptions.elementAt(3) : '', correctOption: correctOption),
//                         ],
//                     );
//                     }
        
//                   ),

//                 // const RuleDialog(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/componenets/game_grid.dart';
import 'package:soccer_grid/componenets/option_card.dart';
import 'package:soccer_grid/componenets/player_score.dart';
import 'package:soccer_grid/providers/home_page_refresh.dart';
import 'package:soccer_grid/providers/points_provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  int player1Score = 0;
  int player2Score = 0;
  List<String> cardOptions = [];
  String correctOption = '';
  Key optionCardKey = UniqueKey();
  late AnimationController _animationController;
   late Animation<double> _animationValue;
  @override
   void initState() {
    super.initState();
    // Hide the status bar when the game page is initialized
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1)); // Initialize animation controller
    _animationValue = Tween<double>(begin: 0.0, end: 0.5).animate(_animationController); // Initialize animation value
  }

  @override
  void dispose() {
    super.dispose();
    // Ensure the status bar is shown when the game page is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _animationController.dispose(); // Dispose animation controller
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomePageModel>(context);
    if (model.rebuildHomepage) {
      setState(() {});
      model.resetTrigger();
      context.read<PointsProvider>().player1Score = 0;
      context.read<PointsProvider>().player2Score = 0;
    }

    return Scaffold(
      body: Column(
        children: [
          Builder(
            builder: (context) {
              return const PlayerScore();
            },
          ),
          Expanded(
            child: GameGrid(
              onOptionsChanged: (List<String> options) {
                setState(() {
                  cardOptions = List.from(options);
                  correctOption = cardOptions[0];
                  cardOptions.shuffle();
                  optionCardKey = UniqueKey();
                  _animationController.forward(); // Start animation
                });
              },
            ),
          ),
          Container(
            height: 300,
            width: double.infinity,
            // color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (cardOptions.isNotEmpty)
                  Builder(
                    builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut,
                            left: _animationValue.value * MediaQuery.of(context).size.width,
                            top: 0,
                            child: OptionCard(option: cardOptions.elementAt(0), correctOption: correctOption)),
                          AnimatedPositioned(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut,
                            right: _animationValue.value * MediaQuery.of(context).size.width,
                            top: 0,
                            child: OptionCard(option: cardOptions.length > 1 ? cardOptions.elementAt(1) : '', correctOption: correctOption)),
                        ],
                      );
                    },
                  ),
                if (cardOptions.length > 2)
                  Builder(
                    builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OptionCard(option: cardOptions.elementAt(2), correctOption: correctOption),
                          OptionCard(option: cardOptions.length > 3 ? cardOptions.elementAt(3) : '', correctOption: correctOption),
                        ],
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Added getter for animation
}