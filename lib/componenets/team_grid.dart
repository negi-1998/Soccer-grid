import 'package:flutter/material.dart';
import 'package:soccer_grid/vars/team_index.dart';

class TeamGrid extends StatefulWidget {
  final Function(String) onTeamSelected;
  const TeamGrid({
    Key? key,
    required this.onTeamSelected,
  }) : super(key: key);

  @override
  State<TeamGrid> createState() => _TeamGridState();
}

class _TeamGridState extends State<TeamGrid> {
  int _selectedTeamIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemSize = (screenWidth - 24) / 8; 

    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(3),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1, 
      ),
      itemCount: teamList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTeamIndex = index;
              widget.onTeamSelected(teamList[index]);
            });
          },
          child: Card(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                border: _selectedTeamIndex == index
                    ? Border.all(color: Colors.black, width: 2.0)
                    : null,
              ),
              child: Image.asset(
                'assets/images/${teamList[index]}.png',
                fit: BoxFit.cover,
                width: itemSize,
                height: itemSize,
              ),
            ),
          ),
        );
      },
    );
  }
}

