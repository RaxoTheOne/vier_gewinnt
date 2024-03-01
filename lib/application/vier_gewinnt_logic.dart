import 'package:flutter/material.dart';

class VierGewinntLogic {
  List<List<Color?>> board =
      List.generate(6, (_) => List.filled(7, null)); // Game board
  bool redTurn = true; // Indicates whose turn it is
  bool gameOver = false; // Indicates if the game is over

  void dropPiece(int col) {
    if (!gameOver) {
      for (int row = 5; row >= 0; row--) {
        if (board[row][col] == null) {
          board[row][col] = redTurn ? Colors.red : Colors.yellow;
          redTurn = !redTurn;
          if (checkWinner(row, col)) {
            gameOver = true;
            // Show Dialog here if needed
          }
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
    board = List.generate(6, (_) => List.filled(7, null));
    redTurn = true;
    gameOver = false;
  }
}
