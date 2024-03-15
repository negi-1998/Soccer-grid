import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:soccer_grid/componenets/cell_dialog.dart';
import 'package:soccer_grid/vars/globals.dart';
import 'package:soccer_grid/vars/team_index.dart'; 
import 'package:soccer_grid/vars/players.dart'; 

class GameGrid extends StatefulWidget {
  final Function(List<String>) onOptionsChanged;
  const GameGrid({Key? key, required this.onOptionsChanged}) : super(key: key);

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  final _random = Random();
  final _selectedLogos = List.generate(25, (_) => ''); 
  int currentPlayer = 1; // Variable to track the current player
  List<String> rowVals=[];
  List<String> colVals=[];
  List<String> options=[];
  List<int> visitedCells = [0,1,2,3,4,5,10,15,20];
  @override
  void initState() {
    super.initState();
    _fillGridWithLogos();
  }

  void _fillGridWithLogos() {
    rowVals = rowHints.keys.toList();
    colVals = columnHints.keys.toList();
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

  void _fillOptionsList(int index) {
    options=[];
    int row = index ~/ 5;
    int col = index % 5;
    String rowTeampath = _selectedLogos[row * 5];
    String colTeampath = _selectedLogos[col];
    String rowTeam = (rowTeampath.split('/').last).split('.').first;
    String colTeam = (colTeampath.split('/').last).split('.').first;
    Map<String, Map<String, List>> mapMappings ={
      'barcelona' : barcelona,
      'dortmund' : dortmund,
      'pep' : pep,
      'porto' : porto,
      'liverpool' : liverpool,
      'rNazario' : rNazario,
      'psg' : psg,
      'acMilan' : acMilan,
      'newcastle' : newcastle,
      'mls' : mls,
      'napoli' : napoli,
      'worldCup' : worldCup,
    };
    Map<String, List>? selectedMap = mapMappings[colTeam]; 
    List<String> keys = selectedMap?.keys.toList() ?? [];
    Random random = Random();
    int randomIndex = random.nextInt(selectedMap![rowTeam]!.length);
    options.insert(0, selectedMap[rowTeam]?[randomIndex]);
    while(options.length < 4 ){
      String selectedKey = keys[random.nextInt(keys.length)];
      if(selectedKey != rowTeam){
        List<String>? values = selectedMap[selectedKey]?.cast<String>();
        if(values != null && values.isNotEmpty){
          randomIndex = random.nextInt(values.length);
          String selectedValue = values[randomIndex];
          if (!options.contains(selectedValue)) {
            options.add(selectedValue);
          }
        }
      }
      if (options.length >= 4) {
        break;
      }
    }
    widget.onOptionsChanged(options);
  }


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(5.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.0,
      ),
      itemCount: 25,
      itemBuilder: (context, index) {
        final logoImage = _selectedLogos[index];

        return GestureDetector(
          onTap: () {
          },
          child: Stack(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: currentPlayer == 1 ? Colors.orange.withOpacity(0.5) : Colors.blue.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                  image: logoImage.isNotEmpty
                      ? DecorationImage(
                          image: AssetImage(logoImage),
                          fit: BoxFit.contain,
                        )
                      : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if(playerturn==0) {
                    clicked = true;
                  }
                  if(visitedCells.contains(index)) {
                    showDialog(
                      context: context, 
                      builder: (context) => const CellDialog()
                    );
                  }
                  
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          playerturn%2==0? 'Player 1 turn' : 'Player 2 turn',
                          style: const TextStyle(color: Colors.white),
                        ), 
                        duration: const Duration(seconds: 2), 
                        backgroundColor: Colors.green,
                      )
                    );
                    playerturn++;
                    setState(() {
                      currentPlayer = currentPlayer == 1 ? 2 : 1;

                    });
                    visitedCells.insert(visitedCells.length, index);
                    _fillOptionsList(index);
                  }
                  
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
