import 'package:flutter/material.dart';

class OptionCard extends StatefulWidget {
  final String option;
  const OptionCard({
    required this.option,
    Key? key,
  }) : super(key: key);

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 190,
      
      child: Card(
        elevation: 20,
        
        color: Colors.amber,
        child: Text(widget.option), 
      ),
    );
  }
}
