import 'package:flutter/material.dart';
import 'package:game/game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activeplayer = "X";
  bool gameover = false;
  int turn = 0;
  String result = " ";
  bool isswitced = false;
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    bool landscope =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
            child: !landscope
                ? Column(
                    children: [
                      ...firstblock(),
                      expandedMethods(context, landscope),
                      ...secondBlock()
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [...firstblock(), ...secondBlock()],
                        ),
                      ),
                      expandedMethods(context, landscope)
                    ],
                  )),
      ),
    );
  }

  List<Widget> firstblock() {
    return [
      SwitchListTile.adaptive(
          title: const Text(
            "تشغيل /ايقاف وضع اللعب الثنائي",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          value: isswitced,
          onChanged: (bool newVal) {
            setState(() {
              isswitced = newVal;
              Player.playerO.clear();
              Player.playerX.clear();
              Player.resultXO = [];
              Player.winO = 0;
              Player.winX = 0;
            });
          }),
      ////
      const SizedBox(
        height: 15,
      ),
      Text(
        " $activeplayer دور اللاعب".toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 52),
        textAlign: TextAlign.center,
      ),
      ////
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PlayerResult("X", Player.winX.toString()),
          PlayerResult("O", Player.winO.toString()),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
    ];
  }

  // ignore: non_constant_identifier_names
  Column PlayerResult(String name, String result) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          " $name نتيجة اللاعب ",
          style: const TextStyle(
              color: Colors.yellow, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(result),
      ],
    );
  }

  List<Widget> secondBlock() {
    return [
      Text(
        result,
        style: const TextStyle(color: Colors.white, fontSize: 42),
        textAlign: TextAlign.center,
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            Player.playerO = [];
            Player.playerX = [];
            activeplayer = "X";
            gameover = false;
            turn = 0;
            result = " ";
            Player.resultXO = [];
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text("العب من جديد"),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).splashColor)),
      )
    ];
  }

  Expanded expandedMethods(BuildContext context, bool landscop) {
    return Expanded(
        child: Align(
      alignment: Alignment.topCenter,
      child: GridView.count(
        padding: MediaQuery.of(context).orientation == Orientation.landscape
            ? const EdgeInsets.all(25)
            : const EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 7.0,
        crossAxisSpacing: 7.0,
        childAspectRatio: 1.0,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: landscop ? Axis.horizontal : Axis.vertical,

        //نسبة العرض الى الطول
        children: List.generate(
            9,
            (index) => InkWell(
                  onTap: gameover ? null : () => _onTap(index),
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).shadowColor),
                      child: Text(
                        Player.playerX.contains(index)
                            ? "X"
                            : Player.playerO.contains(index)
                                ? "O"
                                : " ",
                        style: TextStyle(
                            color: Player.playerO.contains(index)
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      )),
                )),
      ),
    ));
  }

  _onTap(int index) async {
    if ((Player.playerO.isEmpty || !Player.playerO.contains(index)) &&
        (Player.playerX.isEmpty || !Player.playerX.contains(index))) {
      game.playgame(index, activeplayer);
      update();
    }
    if (!gameover && !isswitced) {
      await game.autoplayer(activeplayer);
      update();
    }
  }

  void update() {
    setState(() {
      turn++;
      activeplayer = activeplayer == "X" ? "O" : "X";
      String winnerplayer = game.checkwinner();

      if (winnerplayer != " ") {
        gameover = true;
        result = "$winnerplayer نقطة للاعب ";
        Player.resultXO.add(result);
        game.calculateresult();
      } else if (!gameover && turn >= 9) {
        result = "تعادل";
      }
    });
  }
}
