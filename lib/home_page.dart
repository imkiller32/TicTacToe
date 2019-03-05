import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/custom_dialog.dart';
import 'package:tictactoe/game_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;
  String player1Name = "Player 1";
  String player2Name = "Player 2";

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = new List();
    player2 = new List();
    activePlayer = 1;

    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "X";
        gb.bg = Colors.blue;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "0";
        gb.bg = Colors.green;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => new CustomDialog("Game Tied",
                  "Press the reset button to start again.", resetGame));
        } else {
          activePlayer == 2 ? null : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = new List();
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog(
                  "$player1Name WON",
                  "Press the reset button to start again.",
                  resetGame,
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("$player2Name WON",
                "Press the reset button to start again.", resetGame));
      }
    }

    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return new Scaffold(
        appBar: new AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5.0),
                child: Text(
                  "tic-tac-toe",
                  style: TextStyle(
                    fontSize: 19.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) => new SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: new RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: buttonsList[i].enabled
                            ? () => playGame(buttonsList[i])
                            : null,
                        child: new Text(
                          buttonsList[i].text,
                          style: new TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                        color: buttonsList[i].bg,
                        disabledColor: buttonsList[i].bg,
                      ),
                    ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.crop_square,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: new InputDecoration(
                              hintText: player1Name,
                            ),
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              player1Name = value.toString().toUpperCase();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.crop_square,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: new InputDecoration(
                              hintText: player2Name,
                            ),
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              player2Name = value.toString().toUpperCase();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                )),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              splashColor: Colors.grey,
              child: new Text(
                "RESET",
                style: new TextStyle(
                    color: Colors.white, fontSize: 18.0, letterSpacing: 2),
              ),
              color: Colors.blue,
              padding: const EdgeInsets.all(18.0),
              onPressed: resetGame,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
          ],
        ));
  }
}