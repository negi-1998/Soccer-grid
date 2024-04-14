import "package:flutter/material.dart";

class HomePageModel extends ChangeNotifier {
  bool rebuildHomepage = false;

  void triggerRebuild() {
    rebuildHomepage = true;
    notifyListeners();
  }

  void resetTrigger() {
    rebuildHomepage = false;
    notifyListeners();
  }
}
