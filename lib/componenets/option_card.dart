import 'package:flutter/material.dart';
import 'package:soccer_grid/componenets/game_grid.dart';

class OptionCard extends StatefulWidget {
  final String option;
  final String correctOption;
  @override
  final Key? key;
  const OptionCard({
    required this.option,
    required this.correctOption,
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
        setState(() {
          // Update the card color based on whether the selected option is correct or not
          cardColor = widget.option == widget.correctOption ? Colors.green : Colors.red;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Animation duration
        height: 70,
        width: 190,
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


