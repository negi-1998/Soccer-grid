import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/componenets/error_dialog.dart';
import 'package:soccer_grid/componenets/team_grid.dart';
import 'package:soccer_grid/pages/game_page.dart';
import 'package:soccer_grid/providers/player_name_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController player1Controller;
  late TextEditingController player2Controller;
  late String player1Name;
  late String player2Name;
  late String player1Team;
  late String player2Team;
  late AudioPlayer audioPlayer;
  final String bgMusicUrl = 'audio/coverSong.mp3';
  late double iconSize;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    player1Controller.dispose();
    player2Controller.dispose();
    super.dispose();
  }

  void _initControllers() {
    player1Controller = TextEditingController();
    player2Controller = TextEditingController();
  }

  void _initAudioPlayer() async {
    audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource(bgMusicUrl));
  }

  void selectTeamForPlayer1(String teamName) {
    setState(() {
      player1Team = teamName;
    });
  }

  void selectTeamForPlayer2(String teamName) {
    setState(() {
      player2Team = teamName;
    });
  }

  void setPlayersNames() {
    setState(() {
      player1Name = player1Controller.text;
      player2Name = player2Controller.text;
    });
    context.read<NameProvider>().updatePlayer1Name(newPlayer1Name: player1Name);
    context.read<NameProvider>().updatePlayer2Name(newPlayer2Name: player2Name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/coverPhoto1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TeamGrid(
                            onTeamSelected: selectTeamForPlayer1,
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            width: constraints.maxWidth * 0.6,
                            child: TextField(
                              controller: player1Controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20.0),
                                    right: Radius.circular(20.0),
                                  ),
                                ),
                                labelText: 'Player 1',
                                hintText: 'Enter your name',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            width: constraints.maxWidth * 0.6,
                            child: TextField(
                              controller: player2Controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20.0),
                                    right: Radius.circular(20.0),
                                  ),
                                ),
                                labelText: 'Player 2',
                                hintText: 'Enter your name',
                              ),
                            ),
                          ),
                          TeamGrid(
                            onTeamSelected: selectTeamForPlayer2,
                          ),
                          
                          const SizedBox(height: 20.0),
                          Container(
                            width: constraints.maxWidth * 0.8,
                            child: ElevatedButton(
                              onPressed: () {
                                setPlayersNames();
                                if (player1Name.isEmpty ||
                                    player2Name.isEmpty ||
                                    player1Team.isEmpty ||
                                    player2Team.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const ErrorDialog(),
                                  );
                                  return;
                                }
                                dispose();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GamePage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize:
                                    const Size.fromWidth(double.infinity),
                              ),
                              child: const Text(
                                'Let\'s play',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
