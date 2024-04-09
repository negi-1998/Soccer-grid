import 'package:flutter/material.dart';

class NameProvider extends ChangeNotifier{
  late String player1Name;
  late String player2Name;
  NameProvider({
    this.player1Name="Player 1",
    this.player2Name="Player 2"
  });

  void updatePlayer1Name({required String newPlayer1Name }) {
    player1Name = newPlayer1Name;
    notifyListeners();
  }

  void updatePlayer2Name({required String newPlayer2Name }) {
    player2Name = newPlayer2Name;
    notifyListeners();
  }
}