// ignore_for_file: camel_case_extensions

import 'dart:math';

extension containsAll on List {
  bool containsall(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Player {
  static const X = "X";
  static const O = "O";
  static int winX = 0;
  static int winO = 0;

  static const empty = "O";
  static List<int> playerX = [];
  static List<int> playerO = [];
  static List<String> resultXO = [];
}

class Game {
  void playgame(int index, String activeplayer) {
    if (activeplayer.contains("X")) {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  void calculateresult() {
    for (int i = 0; i < Player.resultXO.length; i++) {
      if (Player.resultXO[i].contains("X")) {
        Player.winX++;
      } else if (Player.resultXO[i].contains("O")) {
        Player.winO++;
      }
    }
  }

  String checkwinner() {
    String winner = " ";
    //bool gameover;
    if (Player.playerO.containsall(0, 1, 2) ||
        Player.playerO.containsall(0, 4, 8) ||
        Player.playerO.containsall(3, 4, 5) ||
        Player.playerO.containsall(6, 7, 8) ||
        Player.playerO.containsall(0, 3, 6) ||
        Player.playerO.containsall(1, 4, 7) ||
        Player.playerO.containsall(2, 5, 8) ||
        Player.playerO.containsall(0, 3, 6) ||
        Player.playerO.containsall(0, 4, 8) ||
        Player.playerO.containsall(2, 4, 6)) {
      winner = "O";
    } else if (Player.playerO.containsall(0, 1, 2) ||
        Player.playerX.containsall(0, 4, 8) ||
        Player.playerX.containsall(3, 4, 5) ||
        Player.playerX.containsall(6, 7, 8) ||
        Player.playerX.containsall(0, 3, 6) ||
        Player.playerX.containsall(1, 4, 7) ||
        Player.playerX.containsall(2, 5, 8) ||
        Player.playerX.containsall(0, 3, 6) ||
        Player.playerX.containsall(0, 4, 8) ||
        Player.playerX.containsall(2, 4, 6)) {
      winner = "X";
    }
    return winner;
  }

  Future<void> autoplayer(activeplayer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    int? index = 0;
    List<int> emptycalls = [];
    for (int i = 0; i < 9; i++) {
      if (!Player.playerO.contains(i) && !Player.playerX.contains(i)) {
        emptycalls.add(i);
      }
    }
    //Attack
    if (Player.playerO.containsall(0, 1) && emptycalls.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsall(3, 4) && emptycalls.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsall(6, 7) && emptycalls.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsall(0, 3) && emptycalls.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsall(1, 4) && emptycalls.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsall(2, 5) && emptycalls.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsall(0, 4) && emptycalls.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsall(2, 4) && emptycalls.contains(6)) {
      index = 6;
    }
    //Attack
    else if (Player.playerO.containsall(0, 2) && emptycalls.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsall(3, 5) && emptycalls.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsall(6, 8) && emptycalls.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsall(0, 6) && emptycalls.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsall(1, 7) && emptycalls.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsall(2, 8) && emptycalls.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsall(0, 8) && emptycalls.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsall(2, 6) && emptycalls.contains(4)) {
      index = 4;
    }
    //Attack
    else if (Player.playerO.containsall(2, 1) && emptycalls.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsall(5, 4) && emptycalls.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsall(8, 7) && emptycalls.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsall(6, 3) && emptycalls.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsall(7, 4) && emptycalls.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsall(8, 5) && emptycalls.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsall(8, 4) && emptycalls.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsall(6, 4) && emptycalls.contains(2)) {
      index = 2;
    }

    //D
    else if (Player.playerX.containsall(0, 1) && emptycalls.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsall(3, 4) && emptycalls.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsall(6, 7) && emptycalls.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsall(0, 3) && emptycalls.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsall(1, 4) && emptycalls.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsall(2, 5) && emptycalls.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsall(0, 4) && emptycalls.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsall(2, 4) && emptycalls.contains(6)) {
      index = 6;
    }
    //D
    else if (Player.playerX.containsall(0, 2) && emptycalls.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsall(3, 5) && emptycalls.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsall(6, 8) && emptycalls.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsall(0, 6) && emptycalls.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsall(1, 7) && emptycalls.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsall(2, 8) && emptycalls.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsall(0, 8) && emptycalls.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsall(2, 6) && emptycalls.contains(4)) {
      index = 4;
    }
    //D
    else if (Player.playerX.containsall(2, 1) && emptycalls.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsall(5, 4) && emptycalls.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsall(8, 7) && emptycalls.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsall(6, 3) && emptycalls.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsall(7, 4) && emptycalls.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsall(8, 5) && emptycalls.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsall(8, 4) && emptycalls.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsall(6, 4) && emptycalls.contains(2)) {
      index = 2;
    } else {
      Random random = Random();
      int randomindex = random.nextInt(emptycalls.length);
      index = emptycalls[randomindex];
    }
    playgame(index, activeplayer);
  }
}
