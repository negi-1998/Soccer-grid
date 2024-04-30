import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/pages/home_page.dart';
import 'package:video_player/video_player.dart';
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
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late VideoPlayerController _videoController; 
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(_animationController);

    _videoController = VideoPlayerController.asset('assets/vid/ball_loop.mp4'); // Initialize video player controller
    _initializeVideoPlayerFuture = _videoController.initialize(); // Initialize video player
    _videoController.play(); // Start playing the video
    _videoController.setLooping(true); // Loop the video
  }

  @override
  void dispose() {
    super.dispose();
    // Ensure the status bar is shown when the game page is disposed
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _animationController.dispose();
    _videoController.dispose(); // Dispose of the video player controller
  }

  void _showBackDialog() {
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit Game?'),
          content: const Text('Do you want to go back to the main menu?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
              Navigator.of(context).pop();
              context.read<PointsProvider>().player1Score=0;
              context.read<PointsProvider>().player2Score=0;
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>const HomePage(),
                  )
                );
            },
              child: const Text('Main Menu'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); 
              },
              child: const Text('Stay'),
            ),
          ],
        ),
      );
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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: true,
      onPopInvoked:(didPop) {
        if(didPop) {
          _showBackDialog();
        }
        _showBackDialog();
      },
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: screenWidth,
                    height: screenHeight,
                    child: VideoPlayer(_videoController),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                  
                }
              },
            ),
            Column(
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
                      color: Colors.white,
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
                        _animationController.forward();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3, // Adjusted height based on screen size
                  width: screenWidth, // Full width of the screen
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (cardOptions.isNotEmpty)
                        Builder(
                          builder: (context) {
                            return SlideTransition(
                              position: _animation,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  OptionCard(
                                    option: cardOptions.elementAt(0),
                                    correctOption: correctOption,
                                    size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                                  ),
                                  OptionCard(
                                    option: cardOptions.length > 1 ? cardOptions.elementAt(1) : '',
                                    correctOption: correctOption,
                                    size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      if (cardOptions.length > 2)
                        Builder(
                          builder: (context) {
                            return SlideTransition(
                              position: _animation,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  OptionCard(
                                    option: cardOptions.elementAt(2),
                                    correctOption: correctOption,
                                    size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                                  ),
                                  OptionCard(
                                    option: cardOptions.length > 3 ? cardOptions.elementAt(3) : '',
                                    correctOption: correctOption,
                                    size: Size(screenWidth * 0.45, 60), // Adjusted size based on screen width
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}