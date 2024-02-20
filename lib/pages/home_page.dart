import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:soccer_grid/componenets/error_dialog.dart';
import 'package:soccer_grid/componenets/team_grid.dart';
import 'package:soccer_grid/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String player1Name="";
  String player2Name="";                                                
  String player1Team="";
  String player2Team="";
  TextEditingController player1Controller = TextEditingController();    
  TextEditingController player2Controller = TextEditingController();
  late AudioPlayer audioPlayer;
  String bgMusicUrl = 'audio/coverSong.mp3';
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

  void setPlayersNames(){
    player1Name = player1Controller.text;
    player2Name = player2Controller.text;
  }

Future<void> _playAudio() async {
  try {
    audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource(bgMusicUrl));
  } catch (e) {
    print("Error playing audio: $e");
  } finally {
    // Release the player even if an error occurs
  }
}

@override
void initState() {
  print('audio started!!!!!!!!!!!!!');
  super.initState();
  _playAudio(); // Call the asynchronous method
}


@override
void dispose() {
  print("audio disposed!!!!!!!!!!!!!!!!!");
  audioPlayer.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/coverPhoto1.jpg"),
                    fit: BoxFit.cover,
                  ),
                )
            ),
             Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TeamGrid(
                   onTeamSelected: selectTeamForPlayer1,
                  ),
                  Padding(  
                    padding: const EdgeInsets.all(15),  
                    child: Column(  
                    children: <Widget>[  
                      Padding(  
                        padding: const EdgeInsets.all(15),  
                        child: TextField(  
                          controller: player1Controller,
                          decoration: const InputDecoration(  
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20)),
                            ),  
                            labelText: 'Player 1',  
                            hintText: 'Enter your name',  
                            fillColor: Colors.grey,
                            filled: true,
                          ),  
                        ),  
                      ), 
                      const SizedBox(
                        height: 10,
                      ) ,
    
                      Padding(  
                        padding: const EdgeInsets.all(15),  
                        child: TextField(
                          controller: player2Controller,
                          //obscureText: true,  
                          decoration: const InputDecoration(  
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(20), right: Radius.circular(20)),
                            ),  
                            labelText: 'Player 2',  
                            hintText: 'Enter your name', 
                            fillColor: Colors.grey,
                            filled: true, 
                          ),  
                        ),  
                ), 
                  
                ],
              ),
            ),
            TeamGrid(
             onTeamSelected: selectTeamForPlayer2,
            ),

            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: (){
                setPlayersNames();
                if(player1Name=="" ||  player2Name=="" || player1Team=="" || player2Team=="") {
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
                    builder: (context)=>GamePage( player1Name: player1Name, player2Name: player2Name)
                  )
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: const Size.fromWidth(double.infinity)
              ),
              child: const Text('Lets play', style: TextStyle(
                color: Colors.black
              ),
              )

                )
        ]
              ),
            )
        ]
        )
      );
  }
}



