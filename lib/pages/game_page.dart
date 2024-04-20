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
  @override
   void initState() {
    super.initState();
    // Hide the status bar when the game page is initialized
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
              
                });
              },
            ),
          ),
          SizedBox(
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
                          OptionCard(option: cardOptions.elementAt(0), correctOption: correctOption),
                          OptionCard(option: cardOptions.length > 1 ? cardOptions.elementAt(1) : '', correctOption: correctOption)
                        ]);
                        
                      
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

}