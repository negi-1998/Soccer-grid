import 'package:flutter/material.dart';

class PointsProvider extends ChangeNotifier {
  late int player1Score;
  late int player2Score;
  PointsProvider({
    this.player1Score=0,
    this.player2Score=0
  });

  void incrementPlayer1() {
    player1Score+=2;
    notifyListeners();
  }

  void incrementPlayer2() {
    player2Score+=2;
    notifyListeners();
  }

  void decrementPlayer1() {
    player1Score-=1;
    notifyListeners();
  }

  void decrementPlayer2() {
    player2Score-=1;
    notifyListeners();
  }
}
