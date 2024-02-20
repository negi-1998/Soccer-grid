import 'dart:math';
import 'package:flutter/material.dart';
import 'package:soccer_grid/vars/team_index.dart'; // Import team_index.dart file

class GameGrid extends StatefulWidget {
  const GameGrid({Key? key}) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  final _random = Random();
  final _selectedLogos = List.generate(25, (_) => '');

  @override
  void initState() {
    super.initState();
    _fillGridWithLogos();
  }

  void _fillGridWithLogos() {
    List<String> rowVals = rowHints.keys.toList();
    List<String> colVals = columnHints.keys.toList();
    for (int i = 1; i <= 4; i++) {
      int ind = _random.nextInt(rowVals.length);
      _selectedLogos[i] = rowHints[rowVals[ind]]!;
      rowVals.removeAt(ind);
    }

    for (int i = 5; i < 21; i += 5) {
      int ind = _random.nextInt(colVals.length);
      _selectedLogos[i] = columnHints[colVals[ind]]!;
      colVals.removeAt(ind);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
      ),
      itemCount: 25,
      itemBuilder: (context, index) {
        final logoImage = _selectedLogos[index];
        
        return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
            image: logoImage.isNotEmpty
                ? DecorationImage(
                    image: AssetImage(logoImage),
                    fit: BoxFit.contain,
                  )
                : null,
          ),
        );
      },
    );
  }
}
