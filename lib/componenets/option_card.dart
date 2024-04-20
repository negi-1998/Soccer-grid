// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:soccer_grid/componenets/already_answered.dart';
// import 'package:soccer_grid/componenets/draw_dialog.dart';
// import 'package:soccer_grid/componenets/winner_dialog.dart';
// import 'package:soccer_grid/providers/player_name_provider.dart';
// import 'package:soccer_grid/vars/globals.dart';
// import 'package:soccer_grid/providers/points_provider.dart';

// // import 'package:soccer_grid/componenets/game_grid.dart';

// class OptionCard extends StatefulWidget {
//   final String option;
//   final String correctOption;
//   @override
//   final Key? key;
//   const OptionCard({
//     required this.option,
//     required this.correctOption,
//     this.key
//   }) : super(key: key);

//   @override
//   State<OptionCard> createState() => _OptionCardState();
// }
                                                                           
// class _OptionCardState extends State<OptionCard> {
//   Color cardColor = Colors.amber; // Default color is yellow
//   // ignore: unused_field
//   late String _option;
//   // ignore: unused_field
//   late String _correctOption;
//   @override
//   void initState() {
//     super.initState();              
//     _option = widget.option;
//     _correctOption = widget.correctOption;
//   }

//   @override
//   void didUpdateWidget(covariant OptionCard oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.option != widget.option || oldWidget.correctOption != widget.correctOption) {
//       setState(() {
//         _option = widget.option;
//         _correctOption = widget.correctOption;
//         setState(() {
//           cardColor = Colors.amber;
//         });
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//           print('$playerturn is current playerturn');
//           // Shows a dialog box if the player tries to answer same question twice.
//           if(playerturn%2==1 && player1Answered==true) {
//             const AlreadyAnswered();
//           }
//           else if(playerturn%2==0 && player2Answered==true) {
//             const AlreadyAnswered();
//           }
//           // Update the card color based on whether the selected option is correct or not
//           else{
            
//             cardColor = widget.option == widget.correctOption ? Colors.green : Colors.red;  // pass this playerAnswer to the player_score using a callback function

//             setState(() {
//               if(playerturn%2==0 && widget.option == widget.correctOption) {
//               player1correct = true;
//               context.read<PointsProvider>().incrementPlayer1();
//               }
//               else if(playerturn%2==0 && (widget.option  != widget.correctOption)) {
//                 player1correct=false;
//                 context.read<PointsProvider>().decrementPlayer1();
//               }
//               if(playerturn%2==1 && widget.option == widget.correctOption) {
//                 player2correct = true;
//                 context.read<PointsProvider>().incrementPlayer2();
//               }
//               else if(playerturn%2==1 && (widget.option  != widget.correctOption)) {
//                 player2correct = false;
//                 context.read<PointsProvider>().decrementPlayer2();
//               }
//               // rebuild the build function of PlayerScore.
//               if(playerturn%2==0) {
//                 player1Answered=true;
//               }
//               else{
//                 player2Answered=true;
//               }
//             });
//             playerturn++;
//             if(playerturn>=15) {
//                 playerturn=0;
//               if(context.watch<PointsProvider>().player1Score != context.watch<PointsProvider>().player2Score) {
//                 print("I should have showed a dialog box of winnner");
//                 showDialog(
//                 context: context, 
//                 builder: (context)=>WinnerDialog(
//                   winnerName: context.watch<PointsProvider>().player1Score > context.watch<PointsProvider>().player2Score ? context.watch<NameProvider>().player1Name : context.watch<NameProvider>().player2Name));
//               }
            
//               else{
//                 playerturn=0;
//                 print("I should have showed a dialog box of draw");
//                 showDialog(
//                   context: context, 
//                   builder: (context)=>const DrawDialog()
//                  );
//               }
//             }
            
//           }
          

//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200), // Animation duration
//         height: 70,
//         width: 190,
//         decoration: BoxDecoration(
//           color: cardColor, // Use the updated card color
//           borderRadius: BorderRadius.circular(10), // Rounded corners for the card
//           border: Border.all(color: Colors.black), // Black border around the card
//         ),
//         child: Center(
//           child: Text(
//             widget.option,
//             style: const TextStyle(
//               color: Colors.black, // Text color is white for better visibility
//               fontWeight: FontWeight.bold, // Text is bold
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/componenets/already_answered.dart';
import 'package:soccer_grid/componenets/draw_dialog.dart';
import 'package:soccer_grid/componenets/winner_dialog.dart';
import 'package:soccer_grid/providers/player_name_provider.dart';
import 'package:soccer_grid/vars/globals.dart';
import 'package:soccer_grid/providers/points_provider.dart';

class OptionCard extends StatefulWidget {
  final String option;
  final String correctOption;
  
  const OptionCard({
    required this.option,
    required this.correctOption,
    Key? key,
  }) : super(key: key);

  @override
  State<OptionCard> createState() => _OptionCardState();
}
                                                                           
class _OptionCardState extends State<OptionCard> {
  Color cardColor = Colors.amber; // Default color is yellow
  late String option;
  late String correctOption;

  @override
  void initState() {
    super.initState();              
    option = widget.option;
    correctOption = widget.correctOption;
  }

  @override
  void didUpdateWidget(OptionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.option != widget.option || oldWidget.correctOption != widget.correctOption) {
      setState(() {
        option = widget.option;
        correctOption = widget.correctOption;
        cardColor = Colors.amber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$playerturn is current playerturn');
        
        if ((playerturn % 2 == 1 && player1Answered) || (playerturn % 2 == 0 && player2Answered)) {
          showDialog(
            context: context,
            builder: (context) => const AlreadyAnswered(),
          );
        } else {
          playerturn++;
          setState(() {
            cardColor = widget.option == widget.correctOption ? Colors.green : Colors.red;

            if (playerturn % 2 == 0) {
              if (widget.option == widget.correctOption) {
                player1correct = true;
                context.read<PointsProvider>().incrementPlayer1();
              } else {
                player1correct = false;
                context.read<PointsProvider>().decrementPlayer1();
              }
              player1Answered = true;
            } else {
              if (widget.option == widget.correctOption) {
                player2correct = true;
                context.read<PointsProvider>().incrementPlayer2();
              } else {
                player2correct = false;
                context.read<PointsProvider>().decrementPlayer2();
              }
              player2Answered = true;
            }

            
          });
        }
        
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 70,
        width: 190,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            widget.option,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

