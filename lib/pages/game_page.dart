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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:soccer_grid/componenets/game_grid.dart';
// import 'package:soccer_grid/componenets/option_card.dart';
// import 'package:soccer_grid/componenets/player_score.dart';
// import 'package:soccer_grid/componenets/rules_page.dart';
// import 'package:soccer_grid/providers/home_page_refresh.dart';
// import 'package:soccer_grid/providers/points_provider.dart';

// class GamePage extends StatefulWidget {
//   const GamePage({super.key});

//   @override
//   State<GamePage> createState() => _GamePageState();
// }

// class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
//   int player1Score = 0;
//   int player2Score = 0;
//   List<String> cardOptions = [];
//   String correctOption = '';
//   Key optionCardKey = UniqueKey();
//   late AnimationController _animationController;
  
//   @override
//    void initState() {
//     super.initState();
//     // Hide the status bar when the game page is initialized
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

//     _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1)); // Initialize animation controller
 
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Ensure the status bar is shown when the game page is disposed
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
//     _animationController.dispose(); // Dispose animation controller
//   }

//   @override
//   Widget build(BuildContext context) {
//     final model = Provider.of<HomePageModel>(context);
//     if (model.rebuildHomepage) {
//       setState(() {});
//       model.resetTrigger();
//       context.read<PointsProvider>().player1Score = 0;
//       context.read<PointsProvider>().player2Score = 0;
//     }

//     return Scaffold(
//       body: Column(
//         children: [
//           GestureDetector(
//             onTap: (){
//               showDialog(
//                 context: context, 
//                 builder: (BuildContext context){
//                   return const RulesPage();
//                 }
//               );
//             },
//             child: Container(
//               margin: const EdgeInsets.fromLTRB(0, 5, 5, 15),
//               alignment: Alignment.topRight,
//               child: const Icon(
//                 Icons.question_mark_sharp,
                  
//               ),
//             ),
//           ),
//           Builder(
//             builder: (context) {
//               return const PlayerScore();
//             },
//           ),
//           Expanded(
//             child: GameGrid(
//               onOptionsChanged: (List<String> options) {
//                 setState(() {
//                   cardOptions = List.from(options);
//                   correctOption = cardOptions[0];
//                   cardOptions.shuffle();
//                   optionCardKey = UniqueKey();
//                   _animationController.forward(); // Start animation
//                 });
//               },
//             ),
//           ),
//           SizedBox(
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
//                           OptionCard(option: cardOptions.elementAt(0), correctOption: correctOption),
//                           OptionCard(option: cardOptions.length > 1 ? cardOptions.elementAt(1) : '', correctOption: correctOption),
//                         ],
//                       );
//                     },
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
//                       );
//                     },
//                   ),
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
import 'package:soccer_grid/componenets/rules_page.dart';
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
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    // Hide the status bar when the game page is initialized
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    // Ensure the status bar is shown when the game page is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _animationController.dispose();
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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return const RulesPage();
                }
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 5, 15),
              alignment: Alignment.topRight,
              child: const Icon(
                Icons.question_mark_sharp,
              ),
            ),
          ),
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
                  _animationController.forward();
                });
              },
            ),
          ),
          SizedBox(
            height: screenHeight * 0.3, // Adjusted height based on screen size
            width: screenWidth, // Full width of the screen
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (cardOptions.isNotEmpty)
                  Builder(
                    builder: (context) {
                      return SlideTransition(
                        position: _animation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OptionCard(
                              option: cardOptions.elementAt(0),
                              correctOption: correctOption,
                              size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                            ),
                            OptionCard(
                              option: cardOptions.length > 1 ? cardOptions.elementAt(1) : '',
                              correctOption: correctOption,
                              size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                if (cardOptions.length > 2)
                  Builder(
                    builder: (context) {
                      return SlideTransition(
                        position: _animation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OptionCard(
                              option: cardOptions.elementAt(2),
                              correctOption: correctOption,
                              size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                            ),
                            OptionCard(
                              option: cardOptions.length > 3 ? cardOptions.elementAt(3) : '',
                              correctOption: correctOption,
                              size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                            ),
                          ],
                        ),
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
}