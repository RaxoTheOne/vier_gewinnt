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
    // Check horizontal
    for (int c = 0; c <= 3; c++) {
      if (col + c <= 3 &&
          board[row][col + c] == board[row][col] &&
          board[row][col] != null) {
        return true;
      }
    }
    // Check vertical
    for (int r = 0; r <= 2; r++) {
      if (row - r >= 0 &&
          board[row - r][col] == board[row][col] &&
          board[row][col] != null) {
        return true;
      }
    }
    // Check diagonal \
    for (int d = -3; d <= 3; d++) {
      if (row - d >= 0 && row - d <= 5 && col - d >= 0 && col - d <= 6) {
        if (board[row - d][col - d] == board[row][col] &&
            board[row][col] != null) {
          return true;
        }
      }
    }
    // Check diagonal /
    for (int d = -3; d <= 3; d++) {
      if (row + d >= 0 && row + d <= 5 && col - d >= 0 && col - d <= 6) {
        if (board[row + d][col - d] == board[row][col] &&
            board[row][col] != null) {
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
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: board[row][col],
                    shape: BoxShape.circle,
                  ),
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
