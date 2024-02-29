import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vier Gewinnt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vier Gewinnt'),
        ),
        body: VierGewinnt(),
      ),
    );
  }
}

class VierGewinnt extends StatefulWidget {
  @override
  _VierGewinntState createState() => _VierGewinntState();
}

class _VierGewinntState extends State<VierGewinnt> {
  List<List<Color?>> board =
      List.generate(6, (_) => List.filled(7, null)); // Game board
  bool redTurn = true; // Indicates whose turn it is
  bool gameOver = false; // Indicates if the game is over

  void dropPiece(int col) {
    if (!gameOver) {
      for (int row = 5; row >= 0; row--) {
        if (board[row][col] == null) {
          setState(() {
            board[row][col] = redTurn ? Colors.red : Colors.yellow;
            redTurn = !redTurn;
            if (checkWinner(row, col)) {
              gameOver = true;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Spiel beendet!'),
                    content: Text('${redTurn ? "Rot" : "Gelb"} hat gewonnen!'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Neues Spiel'),
                        onPressed: () {
                          resetBoard();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          });
          return;
        }
      }
    }
  }

  bool checkWinner(int row, int col) {
    Color? color = board[row][col];
    if (color == null) return false;

    // Check horizontal
    for (int c = 0; c <= 3; c++) {
      if (col + c <= 3 && board[row][col + c] == color) {
        return true;
      }
    }
    // Check vertical
    for (int r = 0; r <= 2; r++) {
      if (row - r >= 0 && board[row - r][col] == color) {
        return true;
      }
    }
    // Check diagonal \
    for (int d = -3; d <= 3; d++) {
      if (row - d >= 0 && row - d <= 5 && col - d >= 0 && col - d <= 6) {
        if (board[row - d][col - d] == color) {
          return true;
        }
      }
    }
    // Check diagonal /
    for (int d = -3; d <= 3; d++) {
      if (row + d >= 0 && row + d <= 5 && col - d >= 0 && col - d <= 6) {
        if (board[row + d][col - d] == color) {
          return true;
        }
      }
    }
    return false;
  }

  void resetBoard() {
    setState(() {
      board = List.generate(6, (_) => List.filled(7, null));
      redTurn = true;
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
            itemCount: 42,
            itemBuilder: (context, index) {
              int row = index ~/ 7;
              int col = index % 7;
              return GestureDetector(
                onTap: () => dropPiece(col),
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: board[row][col] ?? Color.fromARGB(255, 79, 69, 69),
                    shape: BoxShape.circle,
                  ),
                  width: 60, // Adjust size of game pieces for visibility
                  height: 60,
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: resetBoard,
          child: Text('Neues Spiel starten'),
        ),
      ],
    );
  }
}
