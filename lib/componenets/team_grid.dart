import 'package:flutter/material.dart';
import 'package:soccer_grid/vars/team_index.dart';

class TeamGrid extends StatefulWidget {
  final Function(String) onTeamSelected;
  const TeamGrid(
    {
      Key? key, 
      required this.onTeamSelected
    }
  ) : super(key: key);

  @override
  State<TeamGrid> createState() => _TeamGridState();
}

class _TeamGridState extends State<TeamGrid> {
  String player1Name="";
  String player2Name="";                                                        
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(3),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: teamList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            String selectedTeam = teamList[index];
            widget.onTeamSelected(selectedTeam);
          },
          child: Card(
            child: Image.asset(
              'assets/images/${teamList[index]}.png',
              fit: BoxFit.cover,
              width: 2,
              height: 2,
            ),
          ),
        );
      },
    );
  }
}
