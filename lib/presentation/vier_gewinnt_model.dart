import 'package:flutter/material.dart';
import 'package:vier_gewinnt/application/vier_gewinnt_logic.dart';

class VierGewinnt extends StatefulWidget {
  @override
  _VierGewinntState createState() => _VierGewinntState();
}

class _VierGewinntState extends State<VierGewinnt> {
  final VierGewinntLogic _logic = VierGewinntLogic();

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
                onTap: () => _logic.dropPiece(col),
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _logic.board[row][col] ?? Color.fromARGB(255, 79, 69, 69),
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
          onPressed: _logic.resetBoard,
          child: Text('Neues Spiel starten'),
        ),
      ],
    );
  }
}
