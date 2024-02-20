import 'package:flutter/material.dart';
import 'package:soccer_grid/componenets/game_grid.dart';
import 'package:soccer_grid/pages/game_page.dart';
import 'package:soccer_grid/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GamePage(player1Name: 'haha',player2Name: 'dgda',),
      // home: const HomePage(),
      title: "Soccer Grid",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.blue
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),

          
        )
      ),
    );
  }
}