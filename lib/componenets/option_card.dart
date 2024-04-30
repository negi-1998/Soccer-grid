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
  final Size size;
  @override
  final Key? key;
  const OptionCard({
    required this.option,
    required this.correctOption,
    required this.size,
    this.key
  }) : super(key: key);

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  Color cardColor = Colors.amber; // Default color is yellow
  // ignore: unused_field
  late String _option;
  // ignore: unused_field
  late String _correctOption;
  @override
  void initState() {
    super.initState();              
    _option = widget.option;
    _correctOption = widget.correctOption;
  }

  @override
  void didUpdateWidget(covariant OptionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.option != widget.option || oldWidget.correctOption != widget.correctOption) {
      setState(() {
        _option = widget.option;
        _correctOption = widget.correctOption;
        setState(() {
          cardColor = Colors.amber;
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {

          // Shows a dialog box if the player tries to answer same question twice.
          if(playerturn%2==1 && playerAnswered==true) {
            showDialog(
                  context: context, 
                  builder: (context)=>const AlreadyAnswered()
                 );
          }
          else if(playerturn%2==0 && playerAnswered==true) {
            showDialog(
                  context: context, 
                  builder: (context)=>const AlreadyAnswered()
                 );
          }
          // Update the card color based on whether the selected option is correct or not
          else{
            
            cardColor = widget.option == widget.correctOption ? Colors.green : Colors.red;  // pass this playerAnswer to the player_score using a callback function

            setState(() {
              if(playerturn%2==0 && widget.option == widget.correctOption) {
              player1correct = true;
              context.read<PointsProvider>().incrementPlayer1();
            }
            else if(playerturn%2==0 && (widget.option  != widget.correctOption)) {
              player1correct=false;
              context.read<PointsProvider>().decrementPlayer1();
            }
            if(playerturn%2==1 && widget.option == widget.correctOption) {
              player2correct = true;
              context.read<PointsProvider>().incrementPlayer2();
            }
            else if(playerturn%2==1 && (widget.option  != widget.correctOption)) {
              player2correct = false;
              context.read<PointsProvider>().decrementPlayer2();
            }
            // rebuild the build function of PlayerScore.
            if(playerturn%2==0) {
              playerAnswered=true;
            }
            else{
              playerAnswered=true;
            }
            });
            playerturn++;
            print("currently $playerturn");
            if (playerturn >= 16) {
              print('I am inside the >16 condition');
              playerturn = 0;
              
              var pointsProvider = Provider.of<PointsProvider>(context, listen: false);
              if (pointsProvider.player1Score != pointsProvider.player2Score) {
                showDialog(
                  context: context,
                  builder: (context) => WinnerDialog(
                    winnerName: pointsProvider.player1Score > pointsProvider.player2Score
                        ? Provider.of<NameProvider>(context, listen: false).player1Name
                        : Provider.of<NameProvider>(context, listen: false).player2Name,
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const DrawDialog(),
                );
              }
            }

            
          }
          

      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Animation duration
        height: widget.size.height,
        width: widget.size.width,
        decoration: BoxDecoration(
          color: cardColor, // Use the updated card color
          borderRadius: BorderRadius.circular(10), // Rounded corners for the card
          border: Border.all(color: Colors.black), // Black border around the card
        ),
        child: Center(
          child: Text(
            widget.option,
            style: const TextStyle(
              color: Colors.black, // Text color is white for better visibility
              fontWeight: FontWeight.bold, // Text is bold
            ),
          ),
        ),
      ),
    );
  }
}

